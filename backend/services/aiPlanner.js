const { GoogleGenAI } = require('@google/genai');
const pool = require('../db');

const MODEL = process.env.AI_MODEL || 'gemini-3.6-flash';

const CATEGORY_BY_TYPE = {
  Historical: [1],
  Art: [2],
  'Hidden Gems': [4],
  Mixed: [1, 2, 4],
};

const EVENING_CATEGORY = 3;
const MAX_DESCRIPTION_CHARS = 140;

class AiPlannerError extends Error {
  constructor(message, { code = 'AI_ERROR' } = {}) {
    super(message);
    this.code = code;
  }
}

async function loadCountryCatalog(countryId) {
  const [rows] = await pool.query(
    `SELECT p.place_id, p.name, p.short_description, p.latitude, p.longitude,
            p.image_cover, p.category_id, pc.name AS category_name,
            c.name AS city_name
     FROM places p
     JOIN place_categories pc ON p.category_id = pc.category_id
     JOIN cities c ON p.city_id = c.city_id
     WHERE c.country_id = ?
     ORDER BY pc.category_id, c.name, p.name`,
    [countryId]
  );
  return rows;
}

function serializeCatalog(places) {
  return places
    .map((p) => {
      const desc = (p.short_description || '')
        .replace(/\s+/g, ' ')
        .trim()
        .slice(0, MAX_DESCRIPTION_CHARS);
      return JSON.stringify({
        id: p.place_id,
        name: p.name,
        city: p.city_name,
        cat: p.category_name,
        desc,
      });
    })
    .join('\n');
}

function buildPrompt({ countryName, numberOfDays, vacationType, travelStyle, catalogText }) {
  const preferredCategories = CATEGORY_BY_TYPE[vacationType] || CATEGORY_BY_TYPE.Mixed;
  const categoryNames = {
    1: 'Historical Sights',
    2: 'For the Art Lovers',
    3: 'Atmosphere & experience',
    4: 'Hidden Gems',
    5: 'Close by',
  };
  const preferred = preferredCategories.map((id) => categoryNames[id]).join(', ');
  const eveningPreference =
    travelStyle === 'Solo'
      ? 'relaxing cafés, viewpoints and low-key local spots'
      : 'lively squares, restaurants and places with great atmosphere';

  return `You are a travel planner for the PinMap app. Create a day-by-day itinerary for a trip to ${countryName}.

User preferences:
- Duration: exactly ${numberOfDays} day(s)
- Vacation type: ${vacationType} (strongly prefer places from these categories: ${preferred})
- Travel style: ${travelStyle}

Rules:
1. Use ONLY places from the provided catalog below. Every activity MUST reference a place_id that exists in the catalog. Never invent, guess or approximate a place that is not listed.
2. The itinerary must have exactly ${numberOfDays} day(s).
3. Each day must have 1-3 places in the "morning" slot, 1-3 in the "afternoon" slot, and exactly 1 in the "evening" slot.
4. For evening slots prefer ${eveningPreference} (category "Atmosphere & experience").
5. Do not repeat the same place on the same day. Prefer not repeating places across the whole trip unless the catalog is small.
6. Give each day a short "theme" (max 5 words).
7. For each activity include a short "note" (max 15 words) describing what to do there.
8. The trip title should be short and evocative, e.g. "${countryName}: A ${numberOfDays}-Day Escape".

CATALOG (id | name | city | category | description):
${catalogText}`;
}

function planItemSchema() {
  return {
    type: 'object',
    properties: {
      place_id: { type: 'integer', description: 'A place_id from the provided catalog' },
      note: { type: 'string', description: 'Short note (max 15 words) for the visit' },
    },
    required: ['place_id'],
  };
}

function responseSchema() {
  return {
    type: 'object',
    properties: {
      title: { type: 'string', description: 'Short evocative trip title' },
      days: {
        type: 'array',
        description: 'Exactly one entry per trip day, in chronological order',
        items: {
          type: 'object',
          properties: {
            day_number: { type: 'integer', minimum: 1, description: 'Day number starting at 1' },
            theme: { type: 'string', description: 'Short day theme, max 5 words' },
            morning: { type: 'array', description: '1-3 places for the morning', items: planItemSchema() },
            afternoon: { type: 'array', description: '1-3 places for the afternoon', items: planItemSchema() },
            evening: { type: 'array', description: 'Exactly 1 place for the evening', items: planItemSchema() },
          },
          required: ['day_number', 'theme', 'morning', 'afternoon', 'evening'],
        },
      },
    },
    required: ['title', 'days'],
  };
}

function validateAndFilter(plan, byId) {
  if (!plan || !Array.isArray(plan.days) || plan.days.length === 0) {
    throw new AiPlannerError('Gemini returned an empty itinerary', { code: 'AI_INVALID_RESPONSE' });
  }
  let totalPlaces = 0;
  const seen = new Set();
  for (const day of plan.days) {
    for (const slot of ['morning', 'afternoon', 'evening']) {
      const items = day[slot];
      if (!Array.isArray(items)) {
        day[slot] = [];
        continue;
      }
      const valid = [];
      for (const item of items) {
        const place = byId.get(item && item.place_id);
        if (place && !seen.has(place.place_id)) {
          seen.add(place.place_id);
          valid.push({ place_id: place.place_id, note: (item.note || '').trim() });
        }
      }
      day[slot] = valid;
      totalPlaces += valid.length;
    }
  }
  if (totalPlaces === 0) {
    throw new AiPlannerError('Gemini did not return any valid catalog places', { code: 'AI_INVALID_RESPONSE' });
  }
  return plan;
}

function toActivity(item, timeSlot, byId) {
  const place = byId.get(item.place_id);
  if (!place) return null;
  return {
    place_id: place.place_id,
    place_name: place.name,
    place_image: place.image_cover,
    time_slot: timeSlot,
    notes: item.note || '',
    latitude: place.latitude != null ? Number(place.latitude) : null,
    longitude: place.longitude != null ? Number(place.longitude) : null,
    category_id: place.category_id,
    city_name: place.city_name,
  };
}

function buildItinerary(plan, byId, dates) {
  return plan.days.map((day, index) => {
    const buildSlot = (slot, timeSlot) =>
      (day[slot] || [])
        .map((item) => toActivity(item, timeSlot, byId))
        .filter((a) => a !== null);
    return {
      day_number: index + 1,
      date: dates[index] || null,
      morning: buildSlot('morning', 'Morning'),
      afternoon: buildSlot('afternoon', 'Afternoon'),
      evening: buildSlot('evening', 'Evening'),
    };
  });
}

function toDateOnly(value) {
  if (!value) return null;
  return String(value).slice(0, 10);
}

function addDays(dateStr, days) {
  const [y, m, d] = dateStr.split('-').map(Number);
  return new Date(Date.UTC(y, m - 1, d + days)).toISOString().slice(0, 10);
}

async function generateTrip({ countryId, countryName, numberOfDays, startDate, endDate, tripType, travelStyle }) {
  if (!process.env.GEMINI_API_KEY) {
    throw new AiPlannerError('GEMINI_API_KEY is not set on the server', { code: 'AI_NOT_CONFIGURED' });
  }

  const catalog = await loadCountryCatalog(countryId);
  if (catalog.length === 0) {
    throw new AiPlannerError('No places found for this country', { code: 'COUNTRY_NO_PLACES' });
  }
  const byId = new Map(catalog.map((p) => [p.place_id, p]));

  const ai = new GoogleGenAI({ apiKey: process.env.GEMINI_API_KEY });

  let plan;
  let lastError;
  for (let attempt = 0; attempt < 2; attempt++) {
    try {
      const prompt = buildPrompt({
        countryName,
        numberOfDays,
        vacationType: tripType,
        travelStyle,
        catalogText: serializeCatalog(catalog),
      });
      const interaction = await ai.interactions.create({
        model: MODEL,
        input: prompt,
        generation_config: { temperature: 0.8 },
        response_format: {
          type: 'text',
          mime_type: 'application/json',
          schema: responseSchema(),
        },
      });
      const text = interaction.output_text;
      if (!text) {
        throw new AiPlannerError('Gemini returned an empty response', { code: 'AI_EMPTY_RESPONSE' });
      }
      let parsed;
      try {
        parsed = JSON.parse(text);
      } catch (e) {
        throw new AiPlannerError('Gemini returned invalid JSON', { code: 'AI_INVALID_RESPONSE' });
      }
      plan = validateAndFilter(parsed, byId);
      break;
    } catch (err) {
      lastError = err;
      if (err instanceof AiPlannerError && err.code === 'AI_INVALID_RESPONSE' && attempt === 0) {
        continue;
      }
      throw err;
    }
  }
  if (!plan) {
    throw lastError || new AiPlannerError('Failed to generate trip', { code: 'AI_ERROR' });
  }

  const dates = [];
  const startOnly = toDateOnly(startDate);
  if (startOnly) {
    for (let i = 0; i < numberOfDays; i++) {
      dates.push(addDays(startOnly, i));
    }
  }

  return {
    trip_id: 0,
    title: plan.title || `${countryName} Adventure`,
    country_id: countryId,
    start_date: startOnly,
    end_date: toDateOnly(endDate),
    trip_type: tripType,
    travel_style: travelStyle,
    number_of_days: numberOfDays,
    itinerary: buildItinerary(plan, byId, dates),
  };
}

module.exports = { generateTrip, AiPlannerError };
