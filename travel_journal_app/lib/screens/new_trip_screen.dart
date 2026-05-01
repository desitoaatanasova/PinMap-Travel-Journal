import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travel_journal_app/models/trip.dart';
import 'package:travel_journal_app/services/country_service.dart';
import 'package:travel_journal_app/services/trip_service.dart';
import 'package:travel_journal_app/screens/trip_plan_screen.dart';
import 'package:travel_journal_app/theme/app_theme.dart';

class NewTripScreen extends StatefulWidget {
  const NewTripScreen({super.key});

  @override
  State<NewTripScreen> createState() => _NewTripScreenState();
}

class _NewTripScreenState extends State<NewTripScreen> {
  String? _selectedCountry;
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
    return _selectedCountry != null && _startDate != null && _endDate != null;
  }

  void _generateTripPlan() {
    final countryName = _selectedCountry!.split(' ').last;
    final trip = Trip(
      id: '${countryName.toLowerCase()}-${DateTime.now().millisecondsSinceEpoch}',
      destination: _selectedCountry!,
      startDate: DateTime.now(),
      endDate: DateTime.now().add(Duration(days: _numberOfDays - 1)),
      durationDays: _numberOfDays,
      isSolo: _isSolo,
      tripType: _vacationType,
      budget: '',
      itinerary: _buildMockItinerary(countryName),
    );
    TripService.addTrip(trip);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TripPlanScreen(tripId: trip.id, trip: trip),
      ),
    );
  }

  List<TripDay> _buildMockItinerary(String countryName) {
    final activitiesByType = {
      'Historical': [
        TripActivity(
            name: 'Historic Landmark Visit',
            description: 'Explore ancient sites in $countryName',
            time: '9:00 AM',
            icon: Icons.account_balance),
        TripActivity(
            name: 'Museum Tour',
            description: 'Discover local history',
            time: '2:00 PM',
            icon: Icons.museum),
      ],
      'Art': [
        TripActivity(
            name: 'Art Gallery Walk',
            description: 'Visit top galleries in $countryName',
            time: '10:00 AM',
            icon: Icons.palette),
        TripActivity(
            name: 'Street Art Tour',
            description: 'Discover local murals',
            time: '3:00 PM',
            icon: Icons.brush),
      ],
      'Hidden Gems': [
        TripActivity(
            name: 'Local Secret Spot',
            description: 'Off-the-beaten-path location',
            time: '9:30 AM',
            icon: Icons.star),
        TripActivity(
            name: 'Hidden Cafe',
            description: 'Cozy local favorite',
            time: '2:30 PM',
            icon: Icons.local_cafe),
      ],
      'Mixed': [
        TripActivity(
            name: 'Morning Sightseeing',
            description: 'Top attractions in $countryName',
            time: '9:00 AM',
            icon: Icons.visibility),
        TripActivity(
            name: 'Afternoon Exploration',
            description: 'Discover hidden corners',
            time: '2:00 PM',
            icon: Icons.explore),
      ],
    };

    final dayActivities =
        activitiesByType[_vacationType] ?? activitiesByType['Mixed']!;

    return List.generate(_numberOfDays, (index) {
      return TripDay(
        dayNumber: index + 1,
        morning: [
          TripActivity(
            name: 'Day ${index + 1} Morning',
            description: dayActivities[0].description,
            time: dayActivities[0].time,
            icon: dayActivities[0].icon,
          ),
        ],
        afternoon: [
          TripActivity(
            name: 'Day ${index + 1} Afternoon',
            description: dayActivities[1].description,
            time: dayActivities[1].time,
            icon: dayActivities[1].icon,
          ),
        ],
        evening: [
          TripActivity(
            name: 'Day ${index + 1} Evening',
            description: 'Dinner and relaxation in $countryName',
            time: '7:00 PM',
            icon: Icons.nightlight),
        ],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final countries = CountryService.getAllCountries();
    final countryNames =
        countries.map((c) => '${c.flag} ${c.name}').toList();

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
            DropdownButtonFormField<String>(
              value: _selectedCountry,
              decoration: const InputDecoration(
                hintText: 'Choose a country',
                prefixIcon: Icon(Icons.public),
              ),
              items: countryNames.map((name) {
                return DropdownMenuItem(
                  value: name,
                  child: Text(name),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedCountry = value;
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
                  label: Text('Solo 👤'),
                  icon: Icon(Icons.person),
                ),
                ButtonSegment<bool>(
                  value: false,
                  label: Text('Group 👥'),
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
