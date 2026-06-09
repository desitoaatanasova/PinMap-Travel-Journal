import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinmap_travel_journal/models/trip.dart';
import 'package:pinmap_travel_journal/services/country_service.dart';
import 'package:pinmap_travel_journal/services/trip_service.dart';
import 'package:pinmap_travel_journal/screens/trip_plan_screen.dart';
import 'package:pinmap_travel_journal/theme/app_theme.dart';

class NewTripScreen extends StatefulWidget {
  const NewTripScreen({super.key});

  @override
  State<NewTripScreen> createState() => _NewTripScreenState();
}

class _NewTripScreenState extends State<NewTripScreen> {
  int? _selectedCountryId;
  String? _selectedCountryName;
  int _numberOfDays = 3;
  DateTime? _startDate;
  DateTime? _endDate;
  bool _isSolo = true;
  String _vacationType = 'Historical';

  final List<String> _vacationTypes = const [
    'Historical',
    'Art',
    'Hidden Gems',
    'Mixed',
  ];

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: GoogleFonts.playfairDisplay(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: AppTheme.darkBrown,
      ),
    );
  }

  void _incrementDays() {
    setState(() {
      if (_numberOfDays < 14) {
        _numberOfDays++;
        if (_startDate != null) {
          _endDate = _startDate!.add(Duration(days: _numberOfDays - 1));
        }
      }
    });
  }

  void _decrementDays() {
    setState(() {
      if (_numberOfDays > 1) {
        _numberOfDays--;
        if (_startDate != null) {
          _endDate = _startDate!.add(Duration(days: _numberOfDays - 1));
        }
      }
    });
  }

  Future<void> _pickDate({required bool isStart}) async {
    final initial = isStart
        ? (_startDate ?? DateTime.now())
        : (_endDate ?? _startDate ?? DateTime.now());
    final picked = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: DateTime(2024),
      lastDate: DateTime(2027),
    );
    if (picked != null) {
      setState(() {
        if (isStart) {
          _startDate = picked;
          if (_endDate != null && _endDate!.isBefore(_startDate!)) {
            _endDate = _startDate;
          }
          if (_startDate != null && _endDate != null) {
            _numberOfDays = _endDate!.difference(_startDate!).inDays + 1;
          }
        } else {
          _endDate = picked;
          if (_startDate != null) {
            _numberOfDays = _endDate!.difference(_startDate!).inDays + 1;
          }
        }
      });
    }
  }

  Widget _buildDateField({
    required String label,
    required DateTime? date,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(AppTheme.space3),
        decoration: BoxDecoration(
          color: AppTheme.card,
          borderRadius: BorderRadius.circular(AppTheme.radiusMd),
          border: Border.all(color: AppTheme.lightGray),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: GoogleFonts.dmSans(
                fontSize: 12,
                color: AppTheme.warmGray,
              ),
            ),
            const SizedBox(height: AppTheme.space1),
            Row(
              children: [
                Icon(
                  Icons.calendar_today,
                  size: 18,
                  color: AppTheme.primary,
                ),
                const SizedBox(width: AppTheme.space2),
                Text(
                  date != null
                      ? '${date.month}/${date.day}/${date.year}'
                      : 'Select',
                  style: GoogleFonts.dmSans(
                    fontSize: 14,
                    color: date != null ? AppTheme.darkBrown : AppTheme.warmGray,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  bool get _canGenerate {
    return _selectedCountryId != null && _startDate != null && _endDate != null;
  }

  void _generateTripPlan() {
    final trip = Trip(
      tripId: DateTime.now().millisecondsSinceEpoch,
      title: _selectedCountryName!,
      countryId: _selectedCountryId!,
      startDate: _startDate!,
      endDate: _endDate!,
      tripType: _vacationType,
      travelStyle: _isSolo ? 'Solo' : 'Group',
      itinerary: _buildMockItinerary(_selectedCountryName!),
    );
    TripService.addTrip(trip);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TripPlanScreen(
            tripId: trip.tripId.toString(), trip: trip),
      ),
    );
  }

  List<TripDay> _buildMockItinerary(String countryName) {
    return List.generate(_numberOfDays, (index) {
      return TripDay(
        dayNumber: index + 1,
        morning: [
          TripActivity(
            placeName: 'Day ${index + 1} Morning Sightseeing',
            timeSlot: '9:00 AM',
            notes: 'Explore top attractions in $countryName',
          ),
        ],
        afternoon: [
          TripActivity(
            placeName: 'Day ${index + 1} Afternoon Exploration',
            timeSlot: '2:00 PM',
            notes: 'Discover hidden corners of $countryName',
          ),
        ],
        evening: [
          TripActivity(
            placeName: 'Day ${index + 1} Evening',
            timeSlot: '7:00 PM',
            notes: 'Dinner and relaxation in $countryName',
          ),
        ],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final countries = CountryService.getAllCountries();

    return Scaffold(
      backgroundColor: AppTheme.bg,
      extendBody: true,
      appBar: AppBar(
        title: Text(
          'New Trip',
          style: GoogleFonts.playfairDisplay(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: AppTheme.darkBrown,
          ),
        ),
        backgroundColor: AppTheme.bg,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppTheme.space4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildSectionTitle('Destination'),
            const SizedBox(height: AppTheme.space2),
            DropdownButtonFormField<int>(
              value: _selectedCountryId,
              decoration: const InputDecoration(
                hintText: 'Choose a country',
                prefixIcon: Icon(Icons.public),
              ),
              items: countries.map((c) {
                return DropdownMenuItem(
                  value: c.countryId,
                  child: Text(c.name),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedCountryId = value;
                  _selectedCountryName = countries
                      .firstWhere((c) => c.countryId == value)
                      .name;
                });
              },
            ),
            const SizedBox(height: AppTheme.space6),
            _buildSectionTitle('Dates'),
            const SizedBox(height: AppTheme.space2),
            Row(
              children: [
                Expanded(
                  child: _buildDateField(
                    label: 'Start Date',
                    date: _startDate,
                    onTap: () => _pickDate(isStart: true),
                  ),
                ),
                const SizedBox(width: AppTheme.space3),
                Expanded(
                  child: _buildDateField(
                    label: 'End Date',
                    date: _endDate,
                    onTap: () => _pickDate(isStart: false),
                  ),
                ),
              ],
            ),
            if (_numberOfDays > 0) ...[
              const SizedBox(height: AppTheme.space2),
              Text(
                'Duration: $_numberOfDays days',
                style: GoogleFonts.dmSans(
                  fontSize: 14,
                  color: AppTheme.warmGray,
                ),
              ),
            ],
            const SizedBox(height: AppTheme.space6),
            _buildSectionTitle('Number of Days'),
            const SizedBox(height: AppTheme.space2),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: _decrementDays,
                  icon: const Icon(Icons.remove_circle_outline),
                  color: AppTheme.primary,
                  iconSize: 32,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: AppTheme.space4),
                  child: Column(
                    children: [
                      Text(
                        '$_numberOfDays',
                        style: GoogleFonts.playfairDisplay(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.darkBrown,
                        ),
                      ),
                      Text(
                        _numberOfDays == 1 ? 'day' : 'days',
                        style: GoogleFonts.dmSans(
                          fontSize: 12,
                          color: AppTheme.warmGray,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: _incrementDays,
                  icon: const Icon(Icons.add_circle_outline),
                  color: AppTheme.primary,
                  iconSize: 32,
                ),
              ],
            ),
            const SizedBox(height: AppTheme.space6),
            _buildSectionTitle('Type of Vacation'),
            const SizedBox(height: AppTheme.space2),
            SegmentedButton<String>(
              segments: _vacationTypes
                  .map((type) => ButtonSegment<String>(
                        value: type,
                        label: Text(type),
                      ))
                  .toList(),
              selected: {_vacationType},
              onSelectionChanged: (selection) {
                setState(() {
                  _vacationType = selection.first;
                });
              },
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.resolveWith((states) {
                  if (states.contains(WidgetState.selected)) {
                    return AppTheme.primary.withValues(alpha: 0.1);
                  }
                  return null;
                }),
                foregroundColor: WidgetStateProperty.resolveWith((states) {
                  if (states.contains(WidgetState.selected)) {
                    return AppTheme.primary;
                  }
                  return AppTheme.warmGray;
                }),
              ),
            ),
            const SizedBox(height: AppTheme.space6),
            _buildSectionTitle('Travel Style'),
            const SizedBox(height: AppTheme.space2),
            SegmentedButton<bool>(
              segments: const [
                ButtonSegment<bool>(
                  value: true,
                  label: Text('Solo'),
                  icon: Icon(Icons.person),
                ),
                ButtonSegment<bool>(
                  value: false,
                  label: Text('Group'),
                  icon: Icon(Icons.group),
                ),
              ],
              selected: {_isSolo},
              onSelectionChanged: (selection) {
                setState(() {
                  _isSolo = selection.first;
                });
              },
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.resolveWith((states) {
                  if (states.contains(WidgetState.selected)) {
                    return AppTheme.primary.withValues(alpha: 0.1);
                  }
                  return null;
                }),
                foregroundColor: WidgetStateProperty.resolveWith((states) {
                  if (states.contains(WidgetState.selected)) {
                    return AppTheme.primary;
                  }
                  return AppTheme.warmGray;
                }),
              ),
            ),
            const SizedBox(height: AppTheme.space8),
            ElevatedButton.icon(
              onPressed: _canGenerate ? _generateTripPlan : null,
              icon: const Icon(Icons.auto_awesome),
              label: const Text('Generate Trip Plan'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                    vertical: AppTheme.space3),
              ),
            ),
            const SizedBox(height: AppTheme.space4),
          ],
        ),
      ),
    );
  }
}
