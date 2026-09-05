const { GoogleGenAI } = require('@google/genai');
const pool = require('../db');

const MODEL = process.env.AI_MODEL || 'gemini-3.6-flash';

const CATEGORY_BY_TYPE = {
  Historical: [1],
  Art: [2],
  'Hidden Gems': [4],
  Mixed: [1, 2, 4],
};

const MAX_DESCRIPTION_CHARS = 140;
const AI_TIMEOUT_MS = 60000;

class AiPlannerError extends Error {
  constructor(message, { code = 'AI_ERROR' } = {}) {
    super(message);
    this.code = code;
  }
}

async function loadCountryCatalog({ countryId, cityIds = [] }) {
  const params = [];
  let where;
  if (Array.isArray(cityIds) && cityIds.length > 0) {
    const validIds = cityIds.map((id) => parseInt(id, 10)).filter((id) => Number.isInteger(id));
    if (validIds.length > 0) {
      where = `c.city_id IN (${validIds.map(() => '?').join(',')})`;
      params.push(...validIds);
    } else {
      where = 'c.country_id = ?';
      params.push(countryId);
    }
  } else {
    where = 'c.country_id = ?';
    params.push(countryId);
  }
  const [rows] = await pool.query(
    `SELECT p.place_id, p.name, p.short_description, p.latitude, p.longitude,
            p.image_cover, p.category_id, pc.name AS category_name,
            c.name AS city_name
     FROM places p
     JOIN place_categories pc ON p.category_id = pc.category_id
     JOIN cities c ON p.city_id = c.city_id
     WHERE ${where}
     ORDER BY pc.category_id, c.name, p.name`,
    params
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

function buildPrompt({ countryName, numberOfDays, vacationType, travelStyle, catalogText, cityNames, arrivalCity, departureCity, participantNames }) {
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
      ? 'relaxing caf\u00E9s, viewpoints and low-key local spots'
      : 'lively squares, restaurants and places with great atmosphere';

  const cityLine = cityNames && cityNames.length > 0
    ? `- Cities to visit: ${cityNames.join(', ')}`
    : `- Base country: ${countryName}`;
  const arrivalLine = arrivalCity
    ? `- Arrival city: the user arrives in ${arrivalCity} and the first day of the itinerary should start there.`
    : '';
  const departureLine = departureCity
    ? `- Departure city: the user departs from ${departureCity}; the last day should end there (avoid scheduling the final evening far from it).`
    : '';
  const groupLine =
    travelStyle === 'Group' && participantNames && participantNames.length > 0
      ? `- This is a GROUP trip with these participants: ${participantNames.join(', ')}. Prefer activities, restaurants and squares that work well for a group and mention the group context in notes where relevant.`
      : '';

  return `You are a travel planner for the PinMap app. Create a day-by-day itinerary for a trip to ${countryName}.

User preferences:
- Duration: exactly ${numberOfDays} day(s)
- Vacation type: ${vacationType} (strongly prefer places from these categories: ${preferred})
- Travel style: ${travelStyle}
${cityLine}
${arrivalLine}
${departureLine}
${groupLine}
Rules:
1. Use ONLY places from the provided catalog below. Every activity MUST reference a place_id that exists in the catalog. Never invent, guess or approximate a place that is not listed.
2. The itinerary must have exactly ${numberOfDays} day(s).
3. Each day should have activities in morning/afternoon/evening slots (1-3 for morning/afternoon, 1 for evening preferred but flexible if catalog is small).
4. For evening slots prefer ${eveningPreference} (category "Atmosphere & experience").
5. Do not repeat the same place within the same day; avoid repeating across the trip unless catalog is small.
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
            morning: { type: 'array', description: 'Places for the morning', items: planItemSchema() },
            afternoon: { type: 'array', description: 'Places for the afternoon', items: planItemSchema() },
            evening: { type: 'array', description: 'Places for the evening', items: planItemSchema() },
          },
          required: ['day_number', 'theme', 'morning', 'afternoon', 'evening'],
        },
      },
    },
    required: ['title', 'days'],
  };
}

function validateAndFilter(plan, byId, numberOfDays) {
  if (!plan || !Array.isArray(plan.days) || plan.days.length === 0) {
    throw new AiPlannerError('Gemini returned an empty itinerary', { code: 'AI_INVALID_RESPONSE' });
  }
  if (numberOfDays && plan.days.length !== numberOfDays) {
    console.warn(`[AI] day count mismatch: expected ${numberOfDays} got ${plan.days.length}`);
    if (plan.days.length < numberOfDays) {
      throw new AiPlannerError(`Gemini returned ${plan.days.length} days instead of ${numberOfDays}`, { code: 'AI_INVALID_RESPONSE' });
    }
    plan.days = plan.days.slice(0, numberOfDays);
  }
  let totalPlaces = 0;
  const seen = new Set();
  for (let i = 0; i < plan.days.length; i++) {
    const day = plan.days[i];
    if (day.day_number != null && day.day_number !== i + 1) {
      console.warn(`[AI] correcting day_number ${day.day_number} -> ${i+1}`);
    }
    day.day_number = i + 1;
    for (const slot of ['morning', 'afternoon', 'evening']) {
      let items = day[slot];
      if (!Array.isArray(items)) {
        day[slot] = [];
        continue;
      }
      const valid = [];
      for (const item of items) {
        const pid = item && item.place_id;
        if (!Number.isInteger(pid)) continue;
        const place = byId.get(pid);
        if (!place) continue;
        if (seen.has(place.place_id)) continue;
        seen.add(place.place_id);
        valid.push({ place_id: place.place_id, note: (item.note || '').toString().trim().slice(0, 120) });
      }
      day[slot] = valid;
      totalPlaces += valid.length;
    }
    if (day.morning.length === 0 && day.afternoon.length === 0 && day.evening.length === 0) {
      console.warn(`[AI] day ${day.day_number} has no valid activities after filtering`);
    }
  }
  if (totalPlaces === 0) {
    throw new AiPlannerError('Gemini did not return any valid catalog places', { code: 'AI_INVALID_RESPONSE' });
  }
  console.log(`[AI] validated plan: ${plan.days.length} days, ${totalPlaces} places`);
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

function classifyProviderError(err) {
  const status = err && (err.status || err.statusCode);
  const msg = (err && err.message) ? err.message.toLowerCase() : '';
  if (status === 429 || msg.includes('quota') || msg.includes('rate limit') || msg.includes('resource_exhausted')) {
    return 'AI_RATE_LIMIT';
  }
  if (status === 401 || status === 403 || msg.includes('api key') || msg.includes('unauthenticated') || msg.includes('permission')) {
    return 'AI_AUTH_ERROR';
  }
  if (status === 404 || msg.includes('model') && msg.includes('not found')) {
    return 'AI_MODEL_NOT_FOUND';
  }
  if (msg.includes('timeout') || msg.includes('timed out')) {
    return 'AI_TIMEOUT';
  }
  return 'AI_PROVIDER_ERROR';
}

async function withTimeout(promise, ms) {
  let timer;
  const timeout = new Promise((_, reject) => {
    timer = setTimeout(() => reject(new AiPlannerError('AI request timed out', { code: 'AI_TIMEOUT' })), ms);
  });
  try {
    const result = await Promise.race([promise, timeout]);
    clearTimeout(timer);
    return result;
  } catch (e) {
    clearTimeout(timer);
    throw e;
  }
}

async function generateTrip({ countryId, countryName, numberOfDays, startDate, endDate, tripType, travelStyle, cityIds, cityNames, arrivalCity, departureCity, participants }) {
  if (!process.env.GEMINI_API_KEY) {
    throw new AiPlannerError('AI trip generation is currently unavailable because the AI service is not configured.', { code: 'AI_NOT_CONFIGURED' });
  }

  const catalog = await loadCountryCatalog({ countryId, cityIds });
  console.log(`[AI] generateTrip country=${countryName}(${countryId}) days=${numberOfDays} model=${MODEL} catalog=${catalog.length}`);
  if (catalog.length === 0) {
    throw new AiPlannerError('No places found for this country', { code: 'COUNTRY_NO_PLACES' });
  }
  if (catalog.length < 3) {
    throw new AiPlannerError('The selected destination does not currently have enough places for this type of trip.', { code: 'INSUFFICIENT_PLACES' });
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
        cityNames,
        arrivalCity,
        departureCity,
        participantNames:
          Array.isArray(participants) && participants.length > 0
            ? participants.map((p) => p.name || p.username || '').filter((n) => n)
            : null,
      });
      console.log(`[AI] request attempt ${attempt+1} model=${MODEL}`);
      const interaction = await withTimeout(ai.interactions.create({
        model: MODEL,
        input: prompt,
        generation_config: { temperature: 0.8 },
        response_format: {
          type: 'text',
          mime_type: 'application/json',
          schema: responseSchema(),
        },
      }), AI_TIMEOUT_MS);
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
      plan = validateAndFilter(parsed, byId, numberOfDays);
      console.log(`[AI] success attempt ${attempt+1} title="${parsed.title||''}"`);
      break;
    } catch (err) {
      lastError = err;
      if (err instanceof AiPlannerError) {
        if (err.code === 'AI_INVALID_RESPONSE' && attempt === 0) {
          console.warn(`[AI] retry after invalid response: ${err.message}`);
          continue;
        }
        throw err;
      }
      const code = classifyProviderError(err);
      console.error(`[AI] provider error attempt ${attempt+1} code=${code} status=${err.status||''} msg=${(err.message||'').slice(0,300)}`);
      if (code === 'AI_TIMEOUT') {
        throw new AiPlannerError('The AI service took too long to respond. Please try again.', { code: 'AI_TIMEOUT' });
      }
      if (code === 'AI_RATE_LIMIT') {
        throw new AiPlannerError('AI trip planning is temporarily unavailable due to high demand. Please try again in a moment.', { code: 'AI_RATE_LIMIT' });
      }
      if (code === 'AI_AUTH_ERROR') {
        throw new AiPlannerError('AI trip generation is currently unavailable.', { code: 'AI_AUTH_ERROR' });
      }
      if (code === 'AI_MODEL_NOT_FOUND') {
        throw new AiPlannerError('AI trip generation is currently unavailable.', { code: 'AI_MODEL_NOT_FOUND' });
      }
      throw new AiPlannerError('AI trip planning is temporarily unavailable. Please try again later.', { code: code });
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

  const itinerary=buildItinerary(plan, byId, dates);
  console.log(`[AI] built itinerary days=${itinerary.length} places=${itinerary.reduce((s,d)=>s+d.morning.length+d.afternoon.length+d.evening.length,0)}`);
  const validatedCityIds = Array.isArray(cityIds) ? cityIds.map((id) => parseInt(id, 10)).filter((id) => Number.isInteger(id)) : [];
  console.log(`[AI PREFS] echo cityIds=${JSON.stringify(validatedCityIds)} arrival=${arrivalCity||""} departure=${departureCity||""} participants=${Array.isArray(participants)?participants.length:0}`);
  return {
    trip_id: 0,
    title: plan.title || `${countryName} Adventure`,
    country_id: countryId,
    start_date: startOnly,
    end_date: toDateOnly(endDate),
    trip_type: tripType,
    travel_style: travelStyle,
    number_of_days: numberOfDays,
    itinerary,
    city_ids: validatedCityIds,
    arrival_city: arrivalCity || null,
    departure_city: departureCity || null,
    participants: Array.isArray(participants) ? participants : [],
  };
}

module.exports = { generateTrip, AiPlannerError };
