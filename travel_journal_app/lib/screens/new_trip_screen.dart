import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:latlong2/latlong.dart';
import 'package:pinmap_travel_journal/models/country.dart';
import 'package:pinmap_travel_journal/models/trip.dart';
import 'package:pinmap_travel_journal/services/api_client.dart';
import 'package:pinmap_travel_journal/services/country_service.dart';
import 'package:pinmap_travel_journal/services/social_service.dart';
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
  static const double _nearbyKm = 150;
  static const Distance _distance = Distance();

  late final bool _isEditing;
  int? _selectedCountryId;
  String? _selectedCountryName;
  int _numberOfDays = 3;
  DateTime? _startDate;
  DateTime? _endDate;
  bool _isSolo = true;
  String _vacationType = 'Historical';
  bool _generating = false;

  final Set<int> _selectedCityIds = {};
  final List<CityPin> _nearbyCities = [];
  String? _arrivalCity;
  String? _departureCity;

  List<TripParticipant> _mutualFriends = [];
  final Set<int> _selectedParticipantIds = {};
  bool _loadingFriends = false;

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
      _selectedCityIds.addAll(trip.cityIds);
      _arrivalCity = trip.arrivalCity;
      _departureCity = trip.departureCity;
      _selectedParticipantIds.addAll(trip.participants.map((p) => p.userId));
    }
    CountryService.loadCountries().then((_) {
      if (mounted) {
        setState(() {
          if (_selectedCountryId != null) _refreshNearbyCities();
        });
      }
    });
    if (!_isSolo) _loadFriends();
  }

  Future<void> _loadFriends() async {
    if (_loadingFriends) return;
    setState(() => _loadingFriends = true);
    try {
      final friends = await SocialService.getMutualConnections();
      if (!mounted) return;
      setState(() {
        _mutualFriends = friends;
        _loadingFriends = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() => _loadingFriends = false);
    }
  }

  Country? get _selectedCountry {
    if (_selectedCountryId == null) return null;
    final countries = CountryService.getAllCountries();
    for (final c in countries) {
      if (c.countryId == _selectedCountryId) return c;
    }
    return null;
  }

  List<CityPin> get _countryCities => _selectedCountry?.cityPins ?? const [];

  List<CityPin> get _availableCities => [..._countryCities, ..._nearbyCities];

  List<String> get _selectedCityNames {
    final names = <String>[];
    for (final city in _availableCities) {
      if (_selectedCityIds.contains(city.cityId)) {
        names.add(city.name);
      }
    }
    return names;
  }

  List<TripParticipant> get _selectedParticipants {
    return _mutualFriends
        .where((f) => _selectedParticipantIds.contains(f.userId))
        .toList();
  }

  void _refreshNearbyCities() {
    _nearbyCities.clear();
    final country = _selectedCountry;
    if (country == null) return;
    for (final other in CountryService.getAllCountries()) {
      if (other.countryId == country.countryId) continue;
      for (final city in other.cityPins) {
        for (final base in country.cityPins) {
          final dist = _distance(base.latLng, city.latLng);
          if (dist <= _nearbyKm * 1000) {
            _nearbyCities.add(city);
            break;
          }
        }
      }
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

  Widget _buildPickerField({
    required IconData icon,
    required String label,
    required String value,
    required VoidCallback onTap,
    bool clearable = false,
    VoidCallback? onClear,
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
        child: Row(
          children: [
            Icon(icon, size: 18, color: AppTheme.primary),
            const SizedBox(width: AppTheme.space2),
            Expanded(
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
                  Text(
                    value,
                    style: GoogleFonts.dmSans(
                      fontSize: 14,
                      color:
                          value == label ? AppTheme.warmGray : AppTheme.darkBrown,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            if (clearable && value.isNotEmpty && value != label)
              GestureDetector(
                onTap: onClear,
                child: const Padding(
                  padding: EdgeInsets.all(4),
                  child: Icon(Icons.close, size: 16, color: AppTheme.warmGray),
                ),
              ),
            const Icon(Icons.arrow_drop_down, color: AppTheme.warmGray),
          ],
        ),
      ),
    );
  }

  bool get _canGenerate {
    return _selectedCountryId != null && _startDate != null && _endDate != null;
  }

  Future<void> _openCityMultiSelect() async {
    final country = _selectedCountry;
    if (country == null) return;
    final selected = await showModalBottomSheet<Set<int>>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppTheme.bg,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppTheme.radiusLg)),
      ),
      builder: (context) {
        final current = Set<int>.of(_selectedCityIds);
        return StatefulBuilder(
          builder: (context, setSheetState) {
            return DraggableScrollableSheet(
              expand: false,
              initialChildSize: 0.75,
              maxChildSize: 0.95,
              builder: (context, scrollController) {
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(
                          AppTheme.space4, AppTheme.space4, AppTheme.space4, 0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Choose cities to visit',
                              style: GoogleFonts.playfairDisplay(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: AppTheme.darkBrown,
                              ),
                            ),
                          ),
                          Text(
                            '${current.length} selected',
                            style: GoogleFonts.dmSans(
                              fontSize: 12,
                              color: AppTheme.warmGray,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView(
                        controller: scrollController,
                        padding: const EdgeInsets.all(AppTheme.space4),
                        children: [
                          if (_countryCities.isNotEmpty) ...[
                            _buildCityGroupTitle('Cities in ${country.name}'),
                            ..._countryCities.map(
                              (city) => _buildCityCheckTile(city, current, setSheetState, country.name),
                            ),
                          ],
                          if (_nearbyCities.isNotEmpty) ...[
                            const SizedBox(height: AppTheme.space4),
                            _buildCityGroupTitle(
                                'Nearby in neighbouring countries'),
                            ..._nearbyCities.map(
                              (city) => _buildCityCheckTile(
                                city,
                                current,
                                setSheetState,
                                _nearbyCountryName(city),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                    SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.all(AppTheme.space4),
                        child: ElevatedButton.icon(
                          onPressed: () => Navigator.pop(context, current),
                          icon: const Icon(Icons.check),
                          label: Text(
                            current.isEmpty
                                ? 'Done'
                                : 'Add ${current.length} city(ies)',
                          ),
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(double.infinity, 48),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            );
          },
        );
      },
    );
    if (selected != null && mounted) {
      setState(() {
        _selectedCityIds
          ..clear()
          ..addAll(selected);
      });
    }
  }

  String _nearbyCountryName(CityPin city) {
    for (final c in CountryService.getAllCountries()) {
      for (final cityInCountry in c.cityPins) {
        if (cityInCountry.cityId == city.cityId) return c.name;
      }
    }
    return '';
  }

  Widget _buildCityGroupTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppTheme.space2),
      child: Text(
        title,
        style: GoogleFonts.dmSans(
          fontSize: 13,
          fontWeight: FontWeight.w700,
          color: AppTheme.primary,
        ),
      ),
    );
  }

  Widget _buildCityCheckTile(
    CityPin city,
    Set<int> current,
    StateSetter setSheetState,
    String countryName,
  ) {
    final checked = current.contains(city.cityId);
    return CheckboxListTile(
      value: checked,
      onChanged: (value) {
        setSheetState(() {
          if (value == true) {
            current.add(city.cityId);
          } else {
            current.remove(city.cityId);
          }
        });
      },
      controlAffinity: ListTileControlAffinity.leading,
      activeColor: AppTheme.primary,
      contentPadding: EdgeInsets.zero,
      dense: true,
      title: Text(
        city.name,
        style: GoogleFonts.dmSans(
          fontSize: 14,
          color: AppTheme.darkBrown,
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: countryName.isEmpty
          ? null
          : Text(
              countryName,
              style: GoogleFonts.dmSans(
                fontSize: 11,
                color: AppTheme.warmGray,
              ),
            ),
    );
  }

  Future<void> _openCitySearch({required bool isArrival}) async {
    if (_availableCities.isEmpty) return;
    final result = await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppTheme.bg,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppTheme.radiusLg)),
      ),
      builder: (context) {
        final controller = TextEditingController();
        var filter = '';
        return StatefulBuilder(
          builder: (context, setSheetState) {
            final list = _availableCities
                .where((c) =>
                    c.name.toLowerCase().contains(filter.toLowerCase()))
                .toList();
            return DraggableScrollableSheet(
              expand: false,
              initialChildSize: 0.7,
              maxChildSize: 0.95,
              builder: (context, scrollController) {
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(
                          AppTheme.space4, AppTheme.space4, AppTheme.space4, 0),
                      child: TextField(
                        controller: controller,
                        autofocus: true,
                        onChanged: (value) => setSheetState(() => filter = value),
                        decoration: const InputDecoration(
                          hintText: 'Search cities',
                          prefixIcon: Icon(Icons.search),
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListView(
                        controller: scrollController,
                        padding: const EdgeInsets.all(AppTheme.space4),
                        children: list
                            .map((city) => ListTile(
                                  contentPadding: EdgeInsets.zero,
                                  leading: const Icon(Icons.location_city,
                                      color: AppTheme.primary),
                                  title: Text(
                                    city.name,
                                    style: GoogleFonts.dmSans(
                                      fontSize: 14,
                                      color: AppTheme.darkBrown,
                                    ),
                                  ),
                                  subtitle: Text(
                                    _nearbyCountryName(city),
                                    style: GoogleFonts.dmSans(
                                      fontSize: 11,
                                      color: AppTheme.warmGray,
                                    ),
                                  ),
                                  onTap: () => Navigator.pop(context, city.name),
                                ))
                            .toList(),
                      ),
                    ),
                  ],
                );
              },
            );
          },
        );
      },
    );
    if (result != null && mounted) {
      setState(() {
        if (isArrival) {
          _arrivalCity = result;
        } else {
          _departureCity = result;
        }
      });
    }
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
        cityIds: _selectedCityIds.toList(),
        cityNames: _selectedCityNames,
        arrivalCity: _arrivalCity,
        departureCity: _departureCity,
        participants: _selectedParticipants,
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
      cityIds: _selectedCityIds.toList(),
      arrivalCity: _arrivalCity,
      departureCity: _departureCity,
      participants: _selectedParticipants,
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
      cityIds: _selectedCityIds.toList(),
      arrivalCity: _arrivalCity,
      departureCity: _departureCity,
      participants: _selectedParticipants,
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
              initialValue: _selectedCountryId,
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
                  _selectedCityIds.clear();
                  _arrivalCity = null;
                  _departureCity = null;
                  _refreshNearbyCities();
                });
              },
            ),
            const SizedBox(height: AppTheme.space3),
            _buildPickerField(
              icon: Icons.location_city,
              label: 'Choose cities to visit (optional)',
              value: _selectedCityNames.isEmpty
                  ? 'Choose cities to visit (optional)'
                  : _selectedCityNames.join(', '),
              onTap: _selectedCountry == null
                  ? () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Choose a country first',
                            style: GoogleFonts.dmSans(),
                          ),
                        ),
                      );
                    }
                  : _openCityMultiSelect,
            ),
            const SizedBox(height: AppTheme.space3),
            Row(
              children: [
                Expanded(
                  child: _buildPickerField(
                    icon: Icons.flight_land,
                    label: 'Arrival city',
                    value: _arrivalCity ?? 'Arrival city',
                    onTap: () => _openCitySearch(isArrival: true),
                    clearable: true,
                    onClear: () => setState(() => _arrivalCity = null),
                  ),
                ),
                const SizedBox(width: AppTheme.space3),
                Expanded(
                  child: _buildPickerField(
                    icon: Icons.flight_takeoff,
                    label: 'Departure city',
                    value: _departureCity ?? 'Departure city',
                    onTap: () => _openCitySearch(isArrival: false),
                    clearable: true,
                    onClear: () => setState(() => _departureCity = null),
                  ),
                ),
              ],
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
                if (!_isSolo) _loadFriends();
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
            if (!_isSolo) ...[
              const SizedBox(height: AppTheme.space6),
              _buildSectionTitle('Travel Companions'),
              const SizedBox(height: AppTheme.space2),
              _buildParticipantsSection(),
            ],
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

  Widget _buildParticipantsSection() {
    if (_loadingFriends) {
      return const Padding(
        padding: EdgeInsets.all(AppTheme.space4),
        child: Center(child: CircularProgressIndicator()),
      );
    }
    if (_mutualFriends.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(AppTheme.space4),
        decoration: BoxDecoration(
          color: AppTheme.card,
          borderRadius: BorderRadius.circular(AppTheme.radiusMd),
          border: Border.all(color: AppTheme.lightGray),
        ),
        child: Text(
          'No friends found yet. Follow other travellers (and let them follow you back) and they will appear here to add as trip companions.',
          style: GoogleFonts.dmSans(
            fontSize: 13,
            color: AppTheme.warmGray,
          ),
        ),
      );
    }
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.card,
        borderRadius: BorderRadius.circular(AppTheme.radiusMd),
        border: Border.all(color: AppTheme.lightGray),
      ),
      child: Column(
        children: _mutualFriends.map((friend) {
          final checked = _selectedParticipantIds.contains(friend.userId);
          return CheckboxListTile(
            value: checked,
            onChanged: (value) {
              setState(() {
                if (value == true) {
                  _selectedParticipantIds.add(friend.userId);
                } else {
                  _selectedParticipantIds.remove(friend.userId);
                }
              });
            },
            controlAffinity: ListTileControlAffinity.leading,
            activeColor: AppTheme.primary,
            dense: true,
            title: Text(
              friend.displayName,
              style: GoogleFonts.dmSans(
                fontSize: 14,
                color: AppTheme.darkBrown,
                fontWeight: FontWeight.w500,
              ),
            ),
            subtitle: Text(
              '@${friend.username}',
              style: GoogleFonts.dmSans(
                fontSize: 11,
                color: AppTheme.warmGray,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
