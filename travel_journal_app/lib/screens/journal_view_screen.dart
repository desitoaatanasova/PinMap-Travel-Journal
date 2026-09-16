import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinmap_travel_journal/models/journal.dart';
import 'package:pinmap_travel_journal/l10n/app_localizations.dart';
import 'package:pinmap_travel_journal/services/country_service.dart';
import 'package:pinmap_travel_journal/services/journal_pdf_export_service.dart';
import 'package:pinmap_travel_journal/services/journal_service.dart';
import 'package:pinmap_travel_journal/utils/journal_actions.dart';
import 'package:pinmap_travel_journal/services/pdf_download.dart';
import 'package:pinmap_travel_journal/widgets/authenticated_image.dart';
import 'package:pinmap_travel_journal/widgets/section_header.dart';
import 'package:pinmap_travel_journal/services/api_config.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:pinmap_travel_journal/theme/app_theme.dart';

class JournalViewScreen extends StatefulWidget {
  final int journalId;
  final bool isPublic;

  const JournalViewScreen({
    super.key,
    required this.journalId,
    this.isPublic = true,
  });

  @override
  State<JournalViewScreen> createState() => _JournalViewScreenState();
}

class _JournalViewScreenState extends State<JournalViewScreen> {
  Journal? _journal;
  bool _loading = true;
  String? _error;
  bool _isDownloading = false;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    try {
      Journal journal;
      if (widget.isPublic) {
        journal = await JournalService.getPublicJournal(widget.journalId);
      } else {
        final j = JournalService.getJournalById(widget.journalId);
        if (j == null) throw Exception('Journal not found');
        journal = j;
      }
      if (mounted)
        setState(() {
          _journal = journal;
          _loading = false;
        });
    } catch (e) {
      if (mounted)
        setState(() {
          _error = e.toString();
          _loading = false;
        });
    }
  }

  Future<void> _downloadJournal(BuildContext context, Journal journal) async {
    final l10n = AppLocalizations.of(context);
    final messenger = ScaffoldMessenger.of(context);
    setState(() => _isDownloading = true);
    try {
      String? countryName;
      try {
        for (final country in CountryService.getAllCountries()) {
          if (country.countryId == journal.countryId) {
            countryName = country.name;
            break;
          }
        }
      } catch (e) {
        debugPrint('JournalViewScreen download country lookup failed: $e');
      }
      final bytes = await JournalPdfExportService.buildJournalPdf(
        journal,
        countryName: countryName,
      );
      final filename = JournalPdfExportService.sanitizeFilename(journal.title);
      await savePdfBytes(bytes, filename);
      if (!mounted) return;
      setState(() => _isDownloading = false);
      messenger.showSnackBar(
        SnackBar(
          content: Text(l10n.planPdfDone, style: GoogleFonts.dmSans()),
          duration: const Duration(seconds: 2),
        ),
      );
    } catch (e) {
      if (!mounted) return;
      setState(() => _isDownloading = false);
      messenger.showSnackBar(
        SnackBar(
          content: Text(l10n.journalPdfError, style: GoogleFonts.dmSans()),
        ),
      );
    }
  }

  Future<void> _toggleVisibility() async {
    final journal = _journal;
    if (journal == null) return;
    final l10n = AppLocalizations.of(context);
    final current = JournalService.getJournalById(journal.journalId) ?? journal;
    final isPublic = current.visibility == 'public';
    final confirmed = await showDialog<bool>(
      context: context,
      builder:
          (ctx) => AlertDialog(
            title: Text(
              isPublic ? l10n.journalRemoveTitle : l10n.journalPostTitle,
              style: GoogleFonts.playfairDisplay(
                color: Theme.of(ctx).colorScheme.onSurface,
                fontWeight: FontWeight.bold,
              ),
            ),
            content: Text(
              isPublic ? l10n.journalRemoveText : l10n.journalPostText,
              style: GoogleFonts.dmSans(),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx, false),
                child: Text(
                  l10n.commonCancel,
                  style: GoogleFonts.dmSans(color: AppTheme.warmGray),
                ),
              ),
              ElevatedButton(
                onPressed: () => Navigator.pop(ctx, true),
                child: Text(
                  isPublic ? l10n.journalRemoveShort : l10n.journalPost,
                  style: GoogleFonts.dmSans(),
                ),
              ),
            ],
          ),
    );
    if (confirmed != true || !mounted) return;
    try {
      final newVis = await JournalService.updateVisibility(
        current.journalId,
        isPublic ? 'private' : 'public',
      );
      if (!mounted) return;
      setState(() {
        _journal = current.copyWith(visibility: newVis);
      });
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            isPublic ? l10n.journalRemoved : l10n.journalPosted,
            style: GoogleFonts.dmSans(),
          ),
        ),
      );
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            l10n.journalVisibilityError(e.toString()),
            style: GoogleFonts.dmSans(),
          ),
        ),
      );
    }
  }

  Color _pageColor(String? hex) {
    if (hex == null || hex.isEmpty) return const Color(0xFFFFFEF6);
    try {
      var v = hex.replaceAll('#', '');
      if (v.length == 6) v = 'FF$v';
      return Color(int.parse(v, radix: 16));
    } catch (_) {
      return const Color(0xFFFFFEF6);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          _journal?.title ?? l10n.navJournal,
          style: GoogleFonts.playfairDisplay(
            color: Theme.of(context).colorScheme.onSurface,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          if (!widget.isPublic && _journal != null && !_loading)
            _isDownloading
                ? const Padding(
                  padding: EdgeInsets.all(14),
                  child: SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                )
                : IconButton(
                  tooltip: l10n.journalDownload,
                  onPressed: () => _downloadJournal(context, _journal!),
                  icon: const Icon(Icons.download),
                ),
          if (!widget.isPublic && _journal != null && !_loading)
            PopupMenuButton<String>(
              icon: const Icon(Icons.more_vert),
              onSelected: (v) async {
                final journal = _journal;
                if (journal == null) return;
                if (v == 'toggle') {
                  await _toggleVisibility();
                } else if (v == 'delete') {
                  final deleted = await confirmDeleteJournal(context, journal);
                  if (deleted && context.mounted) Navigator.pop(context);
                }
              },
              itemBuilder: (_) {
                final journal = _journal!;
                final current =
                    JournalService.getJournalById(journal.journalId) ?? journal;
                final isPublic = current.visibility == 'public';
                return [
                  PopupMenuItem(
                    value: 'toggle',
                    child: Text(
                      isPublic ? l10n.journalRemoveProfile : l10n.journalPost,
                      style: GoogleFonts.dmSans(fontSize: 13),
                    ),
                  ),
                  PopupMenuItem(
                    value: 'delete',
                    child: Text(
                      l10n.journalDeleteAction,
                      style: GoogleFonts.dmSans(
                        fontSize: 13,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ];
              },
            ),
        ],
      ),
      body:
          _loading
              ? const Center(child: CircularProgressIndicator())
              : _error != null
              ? Center(
                child: Text(
                  _error!,
                  style: GoogleFonts.dmSans(color: AppTheme.warmGray),
                ),
              )
              : _journal == null
              ? Center(
                child: Text(l10n.journalNotFound, style: GoogleFonts.dmSans()),
              )
              : _buildContent(_journal!, l10n),
    );
  }

  Widget _buildContent(Journal journal, AppLocalizations l10n) {
    if (journal.pages.isEmpty) {
      return Center(
        child: Text(
          l10n.journalNoPages,
          style: GoogleFonts.dmSans(color: AppTheme.warmGray),
        ),
      );
    }
    return PageView.builder(
      itemCount: journal.pages.length,
      itemBuilder: (context, index) {
        final page = journal.pages[index];
        return Padding(
          padding: const EdgeInsets.all(AppTheme.space4),
          child: Column(
            children: [
              SectionHeader(title: l10n.journalPageTitle(page.pageNumber)),
              const SizedBox(height: AppTheme.space3),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: _pageColor(page.backgroundColor),
                    borderRadius: BorderRadius.circular(AppTheme.radiusLg),
                    boxShadow: AppTheme.shadowSm,
                    border: Border.all(
                      color: AppTheme.lightGray.withValues(alpha: 0.3),
                    ),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Stack(
                    children: [
                      for (final el in (List<JournalElement>.from(page.elements)
                        ..sort((a, b) => a.zIndex.compareTo(b.zIndex))))
                        _buildElement(el),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildElement(JournalElement el) {
    final left = el.xPosition.toDouble();
    final top = el.yPosition.toDouble();
    final w = el.width.toDouble();
    final h = el.height.toDouble();
    Widget child;
    if (el.elementType == 'text') {
      String text = '';
      String fontFamily = 'DM Sans';
      double fontSize = 14;
      Color color = const Color(0xDD000000);
      bool bold = false;
      bool italic = false;
      bool underline = false;
      TextAlign align = TextAlign.left;
      try {
        if (el.content != null) {
          final m = jsonDecode(el.content!) as Map<String, dynamic>;
          text = m['text'] ?? '';
          fontFamily = m['fontFamily'] ?? 'DM Sans';
          fontSize = (m['fontSize'] as num?)?.toDouble() ?? 14;
          final c = m['color'];
          if (c is int) color = Color(c);
          if (c is String) color = Color(int.tryParse(c) ?? 0xDD000000);
          bold = m['bold'] ?? false;
          italic = m['italic'] ?? false;
          underline = m['underline'] ?? false;
          final a = m['align'] ?? m['textAlign'];
          if (a == 'center') align = TextAlign.center;
          if (a == 'right') align = TextAlign.right;
          if (a == 'justify') align = TextAlign.justify;
        } else {
          text = '';
        }
      } catch (_) {
        text = el.content ?? '';
      }
      TextStyle style;
      switch (fontFamily) {
        case 'Playfair Display':
          style = GoogleFonts.playfairDisplay(
            fontSize: fontSize,
            color: color,
            fontWeight: bold ? FontWeight.w700 : FontWeight.w400,
            fontStyle: italic ? FontStyle.italic : FontStyle.normal,
            decoration:
                underline ? TextDecoration.underline : TextDecoration.none,
          );
          break;
        case 'Dancing Script':
          style = GoogleFonts.dancingScript(
            fontSize: fontSize,
            color: color,
            fontWeight: bold ? FontWeight.w700 : FontWeight.w400,
          );
          break;
        default:
          style = GoogleFonts.dmSans(
            fontSize: fontSize,
            color: color,
            fontWeight: bold ? FontWeight.w700 : FontWeight.w400,
            fontStyle: italic ? FontStyle.italic : FontStyle.normal,
            decoration:
                underline ? TextDecoration.underline : TextDecoration.none,
          );
      }
      child = SizedBox(
        width: w,
        child: Text(text, style: style, textAlign: align),
      );
    } else if (el.elementType == 'image' || el.elementType == 'ticket') {
      final url = el.imageUrl;
      if (url == null || url.isEmpty) {
        child = Container(
          width: w,
          height: h,
          color: AppTheme.lightGray,
          child: Icon(Icons.image, color: AppTheme.warmGray),
        );
      } else {
        final isUpload = url.startsWith('/uploads/');
        child = SizedBox(
          width: w,
          height: h,
          child:
              isUpload
                  ? AuthenticatedCachedImage(imageUrl: url, fit: BoxFit.cover)
                  : CachedNetworkImage(
                    imageUrl: ApiConfig.assetUrl(url),
                    fit: BoxFit.cover,
                    placeholder: (c, u) => Container(color: AppTheme.lightGray),
                    errorWidget:
                        (c, u, e) => Container(
                          color: AppTheme.lightGray,
                          child: Icon(
                            Icons.broken_image,
                            color: AppTheme.warmGray,
                          ),
                        ),
                  ),
        );
      }
    } else if (el.elementType == 'sticker') {
      final emoji = el.content ?? '⭐';
      child = SizedBox(
        width: w,
        height: h,
        child: Center(child: Text(emoji, style: TextStyle(fontSize: h * 0.6))),
      );
    } else {
      child = const SizedBox();
    }
    return Positioned(
      left: left,
      top: top,
      width: w,
      height: el.elementType == 'text' ? null : h,
      child: Transform.rotate(
        angle: el.rotation * 3.1415926535 / 180,
        child: Transform.scale(
          scale: el.scale,
          alignment: Alignment.topLeft,
          child: child,
        ),
      ),
    );
  }
}
