import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinmap_travel_journal/models/trip.dart';
import 'package:pinmap_travel_journal/services/api_client.dart';
import 'package:pinmap_travel_journal/services/country_service.dart';
import 'package:pinmap_travel_journal/services/trip_service.dart';
import 'package:pinmap_travel_journal/screens/trip_plan_screen.dart';
import 'package:pinmap_travel_journal/theme/app_theme.dart';

class NewTripScreen extends StatefulWidget {
  final Trip? trip;

  const NewTripScreen({super.key, this.trip});

  @override
  State<NewTripScreen> createState() => _NewTripScreenState();
}

class _NewTripScreenState extends State<NewTripScreen> {
  late final bool _isEditing;
  int? _selectedCountryId;
  String? _selectedCountryName;
  int _numberOfDays = 3;
  DateTime? _startDate;
  DateTime? _endDate;
  bool _isSolo = true;
  String _vacationType = 'Historical';
  bool _generating = false;

  final List<String> _vacationTypes = const [
    'Historical',
    'Art',
    'Hidden Gems',
    'Mixed',
  ];

  @override
  void initState() {
    super.initState();
    final trip = widget.trip;
    _isEditing = trip != null;
    if (trip != null) {
      _selectedCountryId = trip.countryId;
      _selectedCountryName = trip.title;
      _numberOfDays = trip.endDate.difference(trip.startDate).inDays + 1;
      _startDate = trip.startDate;
      _endDate = trip.endDate;
      _isSolo = trip.travelStyle != 'Group';
      _vacationType = trip.tripType.isEmpty ? 'Historical' : trip.tripType;
    }
  }

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

  Future<void> _generateTripPlan() async {
    final countryName = _selectedCountryName!;
    setState(() => _generating = true);
    try {
      final aiTrip = await TripService.generateTrip(
        countryId: _selectedCountryId!,
        countryName: countryName,
        numberOfDays: _numberOfDays,
        startDate: _startDate!,
        endDate: _endDate!,
        tripType: _vacationType,
        travelStyle: _isSolo ? 'Solo' : 'Group',
      );
      await TripService.saveDraft(aiTrip);
      if (!mounted) return;
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TripPlanScreen(
            tripId: aiTrip.tripId.toString(),
            trip: aiTrip,
          ),
        ),
      );
    } catch (e) {
      if (!mounted) return;
      await _showGenerationError(context, e, countryName);
    } finally {
      if (mounted) {
        setState(() => _generating = false);
      }
    }
  }

  Future<void> _showGenerationError(
      BuildContext context, Object error, String countryName) async {
    final message = error is ApiException
        ? error.message
        : 'Something went wrong generating your trip.';
    await showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          "Couldn't Generate Trip",
          style: GoogleFonts.playfairDisplay(
            color: AppTheme.darkBrown,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          message,
          style: GoogleFonts.dmSans(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel', style: GoogleFonts.dmSans(color: AppTheme.warmGray)),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _generateTripPlan();
            },
            child: Text('Retry', style: GoogleFonts.dmSans(color: AppTheme.primary)),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _useBasicPlan(countryName);
            },
            child: Text('Use basic plan', style: GoogleFonts.dmSans(color: AppTheme.primary)),
          ),
        ],
      ),
    );
  }

  void _useBasicPlan(String countryName) {
    final trip = Trip(
      tripId: DateTime.now().millisecondsSinceEpoch,
      title: countryName,
      countryId: _selectedCountryId!,
      startDate: _startDate!,
      endDate: _endDate!,
      tripType: _vacationType,
      travelStyle: _isSolo ? 'Solo' : 'Group',
      numberOfDays: _numberOfDays,
      itinerary: _buildMockItinerary(countryName),
    );
    TripService.addTrip(trip);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            TripPlanScreen(tripId: trip.tripId.toString(), trip: trip),
      ),
    );
  }

  void _saveTrip() {
    final trip = Trip(
      tripId: widget.trip!.tripId,
      title: _selectedCountryName!,
      countryId: _selectedCountryId!,
      startDate: _startDate!,
      endDate: _endDate!,
      tripType: _vacationType,
      travelStyle: _isSolo ? 'Solo' : 'Group',
      numberOfDays: _numberOfDays,
      itinerary: _numberOfDays == widget.trip!.itinerary.length
          ? widget.trip!.itinerary
          : _buildMockItinerary(_selectedCountryName!),
    );
    if (trip.tripId != 0) {
      TripService.updateTrip(trip);
    }
    Navigator.pop(context, trip);
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
          _isEditing ? 'Edit Trip' : 'New Trip',
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
              onPressed: (_canGenerate && !_generating)
                  ? (_isEditing ? _saveTrip : _generateTripPlan)
                  : null,
              icon: _generating
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : Icon(_isEditing ? Icons.save : Icons.auto_awesome),
              label: Text(
                _generating
                    ? 'Generating...'
                    : (_isEditing ? 'Save Trip' : 'Generate Trip Plan'),
              ),
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
