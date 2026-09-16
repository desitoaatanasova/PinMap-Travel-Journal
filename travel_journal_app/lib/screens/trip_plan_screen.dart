import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinmap_travel_journal/models/trip.dart';
import 'package:pinmap_travel_journal/l10n/app_localizations.dart';
import 'package:pinmap_travel_journal/services/api_client.dart';
import 'package:pinmap_travel_journal/services/country_service.dart';
import 'package:pinmap_travel_journal/services/pdf_download.dart';
import 'package:pinmap_travel_journal/services/pdf_export_service.dart';
import 'package:pinmap_travel_journal/services/trip_service.dart';
import 'package:pinmap_travel_journal/screens/new_trip_screen.dart';
import 'package:pinmap_travel_journal/screens/trip_map_screen.dart';
import 'package:pinmap_travel_journal/theme/app_theme.dart';

class TripPlanScreen extends StatefulWidget {
  final String tripId;
  final Trip? trip;

  const TripPlanScreen({super.key, required this.tripId, this.trip});

  @override
  State<TripPlanScreen> createState() => _TripPlanScreenState();
}

class _TripPlanScreenState extends State<TripPlanScreen> {
  Trip? _trip;
  bool _saving = false;
  bool _regenerating = false;
  bool _isExporting = false;

  bool get _isDraft => _trip != null && _trip!.tripId == 0;

  @override
  void initState() {
    super.initState();
    _trip =
        widget.trip ??
        TripService.getTripById(int.tryParse(widget.tripId) ?? 0);
  }

  @override
  Widget build(BuildContext context) {
    final trip = _trip;

    if (trip == null) {
      return Scaffold(
        body: Center(
          child: Text(
            AppLocalizations.of(context).planNotFound,
            style: GoogleFonts.playfairDisplay(
              fontSize: 20,
              color: AppTheme.warmGray,
            ),
          ),
        ),
      );
    }

    return Scaffold(
      extendBody: true,
      body: CustomScrollView(
        slivers: [
          _buildSliverAppBar(trip),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(AppTheme.space4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildActionButtons(context, trip),
                  const SizedBox(height: AppTheme.space6),
                  Text(
                    AppLocalizations.of(context).planItineraryTitle,
                    style: GoogleFonts.playfairDisplay(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: AppTheme.space4),
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              final day = trip.itinerary[index];
              return _buildDayCard(context, day);
            }, childCount: trip.itinerary.length),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: AppTheme.space12)),
        ],
      ),
    );
  }

  SliverAppBar _buildSliverAppBar(Trip trip) {
    return SliverAppBar(
      expandedHeight: 200,
      pinned: true,
      backgroundColor: AppTheme.primary,
      iconTheme: const IconThemeData(color: Colors.white),
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          color: AppTheme.primary.withValues(alpha: 0.1),
          child: Center(
            child: Icon(
              Icons.luggage,
              size: 48,
              color: AppTheme.primary.withValues(alpha: 0.3),
            ),
          ),
        ),
        titlePadding: const EdgeInsets.only(
          left: AppTheme.space4,
          bottom: AppTheme.space4,
        ),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            trip.title,
            style: GoogleFonts.playfairDisplay(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Text(
            '${_formatDate(trip.startDate)} - ${_formatDate(trip.endDate)}',
            style: GoogleFonts.dmSans(
              fontSize: 14,
              color: AppTheme.warmOffWhite,
            ),
          ),
        ],
      ),
      titleSpacing: AppTheme.space4,
    );
  }

  Widget _buildActionButtons(BuildContext context, Trip trip) {
    final l10n = AppLocalizations.of(context);
    final rowChildren = <Widget>[
      Expanded(
        child: OutlinedButton.icon(
          onPressed: () => _openMapView(context, trip),
          icon: const Icon(Icons.map, size: 18),
          label: Text(l10n.planMapView),
        ),
      ),
      const SizedBox(width: AppTheme.space2),
      Expanded(
        child: OutlinedButton.icon(
          onPressed: _isExporting ? null : () => _exportPdf(context, trip),
          icon:
              _isExporting
                  ? const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                  : const Icon(Icons.picture_as_pdf, size: 18),
          label: Text(_isExporting ? l10n.planExporting : l10n.planExportPdf),
        ),
      ),
      const SizedBox(width: AppTheme.space2),
      if (_isDraft)
        Expanded(
          child: OutlinedButton.icon(
            onPressed: _regenerating ? null : () => _regenerate(context, trip),
            icon:
                _regenerating
                    ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                    : const Icon(Icons.refresh, size: 18),
            label: Text(l10n.planRegenerate),
          ),
        )
      else
        Expanded(
          child: OutlinedButton.icon(
            onPressed: () => _openEditScreen(context, trip),
            icon: const Icon(Icons.edit, size: 18),
            label: Text(l10n.commonEdit),
          ),
        ),
      const SizedBox(width: AppTheme.space2),
      if (_isDraft)
        Expanded(
          child: OutlinedButton.icon(
            onPressed: () => _confirmDiscard(context),
            icon: const Icon(Icons.close, size: 18),
            label: Text(l10n.planDiscard),
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.red,
              side: const BorderSide(color: Colors.red),
            ),
          ),
        )
      else
        Expanded(
          child: OutlinedButton.icon(
            onPressed: () => _confirmDelete(context, trip.tripId),
            icon: const Icon(Icons.delete, size: 18),
            label: Text(l10n.settingsDelete),
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.red,
              side: const BorderSide(color: Colors.red),
            ),
          ),
        ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (_isDraft) ...[
          ElevatedButton.icon(
            onPressed: _saving ? null : () => _saveDraft(context, trip),
            icon:
                _saving
                    ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                    : const Icon(Icons.save),
            label: Text(_saving ? l10n.planSaving : l10n.tripSave),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: AppTheme.space3),
            ),
          ),
          const SizedBox(height: AppTheme.space2),
        ],
        Row(children: rowChildren),
        if (_isDraft) ...[
          const SizedBox(height: AppTheme.space2),
          Center(
            child: Text(
              l10n.planDraftNote,
              style: GoogleFonts.dmSans(fontSize: 12, color: AppTheme.warmGray),
            ),
          ),
        ],
      ],
    );
  }

  Future<void> _saveDraft(BuildContext context, Trip trip) async {
    final l10n = AppLocalizations.of(context);
    final messenger = ScaffoldMessenger.of(context);
    setState(() => _saving = true);
    try {
      final saved = await TripService.saveDraftTrip(trip);
      if (!mounted) return;
      setState(() {
        _trip = saved;
        _saving = false;
      });
      messenger.showSnackBar(
        SnackBar(
          content: Text(
            l10n.planSaved,
            style: GoogleFonts.dmSans(),
          ),
          duration: const Duration(seconds: 2),
        ),
      );
    } catch (e) {
      if (!mounted) return;
      setState(() => _saving = false);
      final message = e is ApiException ? e.message : l10n.planSaveError;
      messenger.showSnackBar(
        SnackBar(content: Text(message, style: GoogleFonts.dmSans())),
      );
    }
  }

  Future<void> _regenerate(BuildContext context, Trip trip) async {
    final l10n = AppLocalizations.of(context);
    final messenger = ScaffoldMessenger.of(context);
    setState(() => _regenerating = true);
    try {
      if (CountryService.getAllCountries().isEmpty) {
        try {
          await CountryService.loadCountries();
        } catch (e) {
          debugPrint('TripPlanScreen loadCountries failed: $e');
        }
      }
      String countryName = '';
      try {
        final countries = CountryService.getAllCountries();
        for (final co in countries) {
          if (co.countryId == trip.countryId) {
            countryName = co.name;
            break;
          }
        }
      } catch (e) {
        debugPrint('TripPlanScreen country lookup failed: $e');
      }
      if (countryName.isEmpty && trip.countryId != 0) {
        try {
          await CountryService.loadCountries();
          for (final co in CountryService.getAllCountries()) {
            if (co.countryId == trip.countryId) {
              countryName = co.name;
              break;
            }
          }
        } catch (e) {
          debugPrint('TripPlanScreen fallback loadCountries failed: $e');
        }
      }
      List<String> cityNames =
          trip.cityIds
              .map((id) => CountryService.cityName(id))
              .where((n) => n != null && n!.isNotEmpty)
              .map((n) => n!)
              .toList();
      if (trip.cityIds.isNotEmpty && cityNames.isEmpty) {
        try {
          await CountryService.loadCountries();
          cityNames =
              trip.cityIds
                  .map((id) => CountryService.cityName(id))
                  .where((n) => n != null && n!.isNotEmpty)
                  .map((n) => n!)
                  .toList();
        } catch (e) {
          debugPrint('TripPlanScreen cityNames fallback failed: $e');
        }
      }
      final aiTrip = await TripService.generateTrip(
        countryId: trip.countryId,
        countryName: countryName,
        numberOfDays: trip.numberOfDays ?? trip.itinerary.length,
        startDate: trip.startDate,
        endDate: trip.endDate,
        tripType: trip.tripType,
        travelStyle: trip.travelStyle,
        cityIds: trip.cityIds,
        cityNames: cityNames,
        arrivalCity: trip.arrivalCity,
        departureCity: trip.departureCity,
        participants: trip.participants,
      );
      await TripService.saveDraft(aiTrip);
      if (!mounted) return;
      setState(() {
        _trip = aiTrip;
        _regenerating = false;
      });
      messenger.showSnackBar(
        SnackBar(
          content: Text(l10n.planRegenerated, style: GoogleFonts.dmSans()),
          duration: const Duration(seconds: 2),
        ),
      );
    } catch (e) {
      if (!mounted) return;
      setState(() => _regenerating = false);
      final message =
          e is ApiException ? e.message : l10n.planRegenError;
      messenger.showSnackBar(
        SnackBar(content: Text(message, style: GoogleFonts.dmSans())),
      );
    }
  }

  Future<void> _exportPdf(BuildContext context, Trip trip) async {
    final l10n = AppLocalizations.of(context);
    final messenger = ScaffoldMessenger.of(context);
    setState(() => _isExporting = true);
    try {
      var exportTrip = trip;
      if (exportTrip.itinerary.isEmpty && exportTrip.tripId != 0) {
        try {
          exportTrip = await TripService.fetchTripDetail(exportTrip.tripId);
          if (!mounted) return;
          setState(() => _trip = exportTrip);
        } catch (e) {
          if (!mounted) return;
          setState(() => _isExporting = false);
          final message =
              e is ApiException ? e.message : l10n.planLoadError;
          messenger.showSnackBar(
            SnackBar(content: Text(message, style: GoogleFonts.dmSans())),
          );
          return;
        }
      }
      String? countryName;
      try {
        for (final country in CountryService.getAllCountries()) {
          if (country.countryId == exportTrip.countryId) {
            countryName = country.name;
            break;
          }
        }
      } catch (e) {
        debugPrint('TripPlanScreen export country lookup failed: $e');
      }
      final bytes = await PdfExportService.buildTripPdf(
        exportTrip,
        countryName: countryName,
      );
      final filename = PdfExportService.sanitizeFilename(exportTrip.title);
      await savePdfBytes(bytes, filename);
      if (!mounted) return;
      setState(() => _isExporting = false);
      messenger.showSnackBar(
        SnackBar(
          content: Text(l10n.planPdfDone, style: GoogleFonts.dmSans()),
          duration: const Duration(seconds: 2),
        ),
      );
    } catch (e) {
      if (!mounted) return;
      setState(() => _isExporting = false);
      messenger.showSnackBar(
        SnackBar(
          content: Text(l10n.planPdfError, style: GoogleFonts.dmSans()),
        ),
      );
    }
  }

  void _confirmDiscard(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    showDialog(
      context: context,
      builder:
          (dialogContext) => AlertDialog(
            title: Text(
              l10n.planDiscardTitle,
              style: GoogleFonts.playfairDisplay(
                color: Theme.of(dialogContext).colorScheme.onSurface,
                fontWeight: FontWeight.bold,
              ),
            ),
            content: Text(
              l10n.planDiscardText,
              style: GoogleFonts.dmSans(),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  l10n.commonCancel,
                  style: GoogleFonts.dmSans(color: AppTheme.warmGray),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  TripService.clearDraft();
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                ),
                child: Text(l10n.planDiscard, style: GoogleFonts.dmSans()),
              ),
            ],
          ),
    );
  }

  void _openMapView(BuildContext context, Trip trip) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TripMapScreen(trip: trip)),
    );
  }

  Widget _buildDayCard(BuildContext context, TripDay day) {
    final l10n = AppLocalizations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: AppTheme.space4,
        vertical: AppTheme.space2,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color ?? colorScheme.surface,
        borderRadius: BorderRadius.circular(AppTheme.radiusLg),
        boxShadow: AppTheme.shadowMd,
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.space4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppTheme.space3,
                vertical: AppTheme.space1,
              ),
              decoration: BoxDecoration(
                color: colorScheme.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(AppTheme.radiusFull),
              ),
              child: Text(
                l10n.planDayNumber(day.dayNumber),
                style: GoogleFonts.dmSans(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: colorScheme.primary,
                ),
              ),
            ),
            const SizedBox(height: AppTheme.space3),
            if (day.morning.isNotEmpty) ...[
              _buildSectionHeader(context, l10n.planMorning, Icons.wb_sunny),
              const SizedBox(height: AppTheme.space2),
              ...day.morning.map(
                (activity) => _buildActivityRow(context, activity),
              ),
              const SizedBox(height: AppTheme.space3),
            ],
            if (day.afternoon.isNotEmpty) ...[
              _buildSectionHeader(context, l10n.planAfternoon, Icons.light_mode),
              const SizedBox(height: AppTheme.space2),
              ...day.afternoon.map(
                (activity) => _buildActivityRow(context, activity),
              ),
              const SizedBox(height: AppTheme.space3),
            ],
            if (day.evening.isNotEmpty) ...[
              _buildSectionHeader(context, l10n.planEvening, Icons.nightlight),
              const SizedBox(height: AppTheme.space2),
              ...day.evening.map(
                (activity) => _buildActivityRow(context, activity),
              ),
              const SizedBox(height: AppTheme.space3),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(
    BuildContext context,
    String title,
    IconData icon,
  ) {
    final colorScheme = Theme.of(context).colorScheme;
    return Row(
      children: [
        Icon(icon, size: 18, color: colorScheme.primary),
        const SizedBox(width: AppTheme.space2),
        Text(
          title,
          style: GoogleFonts.dmSans(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: colorScheme.primary,
          ),
        ),
      ],
    );
  }

  Widget _buildActivityRow(BuildContext context, TripActivity activity) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppTheme.space2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.place, size: 16, color: AppTheme.warmGray),
          const SizedBox(width: AppTheme.space2),
          Text(
            activity.timeSlot,
            style: GoogleFonts.dmSans(fontSize: 12, color: AppTheme.warmGray),
          ),
          const SizedBox(width: AppTheme.space2),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  activity.placeName ?? AppLocalizations.of(context).planActivityFallback,
                  style: GoogleFonts.dmSans(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                if (activity.notes.isNotEmpty) ...[
                  const SizedBox(height: 2),
                  Text(
                    activity.notes,
                    style: GoogleFonts.dmSans(
                      fontSize: 12,
                      color: AppTheme.warmGray,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _openEditScreen(BuildContext context, Trip trip) async {
    final updated = await Navigator.push<Trip>(
      context,
      MaterialPageRoute(builder: (_) => NewTripScreen(trip: trip)),
    );
    if (updated != null && mounted) {
      setState(() {
        _trip = updated;
      });
      if (updated.tripId == 0) {
        await TripService.saveDraft(updated);
      }
    }
  }

  void _confirmDelete(BuildContext context, int tripId) {
    final l10n = AppLocalizations.of(context);
    showDialog(
      context: context,
      builder:
          (dialogContext) => AlertDialog(
            title: Text(
              l10n.planDeleteTitle,
              style: GoogleFonts.playfairDisplay(
                color: Theme.of(dialogContext).colorScheme.onSurface,
                fontWeight: FontWeight.bold,
              ),
            ),
            content: Text(
              l10n.planDeleteText,
              style: GoogleFonts.dmSans(),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  l10n.commonCancel,
                  style: GoogleFonts.dmSans(color: AppTheme.warmGray),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  TripService.deleteTrip(tripId);
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                ),
                child: Text(l10n.settingsDelete, style: GoogleFonts.dmSans()),
              ),
            ],
          ),
    );
  }

  String _formatDate(DateTime date) {
    final months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return '${months[date.month - 1]} ${date.day}';
  }
}
