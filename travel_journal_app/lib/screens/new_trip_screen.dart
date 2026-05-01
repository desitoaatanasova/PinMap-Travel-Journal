import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travel_journal_app/models/trip.dart';
import 'package:travel_journal_app/screens/trip_plan_screen.dart';
import 'package:travel_journal_app/theme/app_theme.dart';

class NewTripScreen extends StatefulWidget {
  const NewTripScreen({super.key});

  @override
  State<NewTripScreen> createState() => _NewTripScreenState();
}

class _NewTripScreenState extends State<NewTripScreen> {
  final _destinationController = TextEditingController();
  DateTime? _startDate;
  DateTime? _endDate;
  bool _isSolo = true;
  String _tripType = 'Leisure';
  String _budget = '\$';

  int get _durationDays {
    if (_startDate != null && _endDate != null) {
      return _endDate!.difference(_startDate!).inDays + 1;
    }
    return 0;
  }

  final List<String> _tripTypes = const [
    'Leisure',
    'Business',
    'Adventure',
    'Cultural',
  ];

  final List<String> _budgetOptions = const ['\$', '\$\$', '\$\$\$', '\$\$\$\$'];

  @override
  Widget build(BuildContext context) {
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
            TextField(
              controller: _destinationController,
              decoration: const InputDecoration(
                hintText: 'Where to?',
                prefixIcon: Icon(Icons.search),
              ),
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
            if (_durationDays > 0) ...[
              const SizedBox(height: AppTheme.space2),
              Text(
                'Duration: $_durationDays days',
                style: GoogleFonts.dmSans(
                  fontSize: 14,
                  color: AppTheme.warmGray,
                ),
              ),
            ],
            const SizedBox(height: AppTheme.space6),
            _buildSectionTitle('Trip Type'),
            const SizedBox(height: AppTheme.space2),
            SegmentedButton<String>(
              segments: _tripTypes
                  .map((type) => ButtonSegment<String>(
                        value: type,
                        label: Text(type),
                      ))
                  .toList(),
              selected: {_tripType},
              onSelectionChanged: (selection) {
                setState(() {
                  _tripType = selection.first;
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
            const SizedBox(height: AppTheme.space6),
            _buildSectionTitle('Budget'),
            const SizedBox(height: AppTheme.space2),
            Wrap(
              spacing: AppTheme.space2,
              children: _budgetOptions.map((option) {
                final isSelected = _budget == option;
                return ChoiceChip(
                  label: Text(option),
                  selected: isSelected,
                  onSelected: (selected) {
                    setState(() {
                      _budget = option;
                    });
                  },
                  backgroundColor: AppTheme.card,
                  selectedColor: AppTheme.primary.withValues(alpha: 0.15),
                  labelStyle: GoogleFonts.dmSans(
                    color: isSelected ? AppTheme.primary : AppTheme.warmGray,
                    fontWeight:
                        isSelected ? FontWeight.w600 : FontWeight.normal,
                  ),
                  side: BorderSide(
                    color: isSelected
                        ? AppTheme.primary
                        : AppTheme.lightGray,
                  ),
                );
              }).toList(),
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
                    color: date != null
                        ? AppTheme.darkBrown
                        : AppTheme.warmGray,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
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
        } else {
          _endDate = picked;
        }
      });
    }
  }

  bool get _canGenerate {
    return _destinationController.text.isNotEmpty &&
        _startDate != null &&
        _endDate != null;
  }

  void _generateTripPlan() {
    final trip = Trip(
      id: '${_destinationController.text.toLowerCase().replaceAll(' ', '-')}-001',
      destination: _destinationController.text,
      startDate: _startDate!,
      endDate: _endDate!,
      durationDays: _durationDays,
      isSolo: _isSolo,
      tripType: _tripType,
      budget: _budget,
      itinerary: _buildMockItinerary(),
    );
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TripPlanScreen(tripId: trip.id, trip: trip),
      ),
    );
  }

  List<TripDay> _buildMockItinerary() {
    return List.generate(_durationDays, (index) {
      return TripDay(
        dayNumber: index + 1,
        morning: [
          TripActivity(
            name: 'Day ${index + 1} Morning',
            description: 'Start your day in ${_destinationController.text}',
            time: '9:00 AM',
            icon: Icons.wb_sunny,
          ),
        ],
        afternoon: [
          TripActivity(
            name: 'Day ${index + 1} Afternoon',
            description: 'Afternoon activities',
            time: '2:00 PM',
            icon: Icons.light_mode,
          ),
        ],
        evening: [
          TripActivity(
            name: 'Day ${index + 1} Evening',
            description: 'Dinner and relaxation',
            time: '7:00 PM',
            icon: Icons.nightlight,
          ),
        ],
      );
    });
  }

  @override
  void dispose() {
    _destinationController.dispose();
    super.dispose();
  }
}
