import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pinmap_travel_journal/models/journal.dart';
import 'package:pinmap_travel_journal/screens/journal_editor/canvas_element.dart';
import 'package:pinmap_travel_journal/screens/journal_editor/editor_page.dart';
import 'package:pinmap_travel_journal/screens/journal_editor/editor_toolbars.dart';
import 'package:pinmap_travel_journal/screens/manual_crop_screen.dart';
import 'package:pinmap_travel_journal/screens/ticket_preview_screen.dart';
import 'package:pinmap_travel_journal/services/api_client.dart';
import 'package:pinmap_travel_journal/services/country_service.dart';
import 'package:pinmap_travel_journal/services/image_upload_service.dart';
import 'package:pinmap_travel_journal/services/journal_service.dart';
import 'package:pinmap_travel_journal/services/sync_queue_service.dart';
import 'package:pinmap_travel_journal/services/ticket_scan_service.dart';
import 'package:pinmap_travel_journal/theme/app_theme.dart';

class JournalEditorScreen extends StatefulWidget {
  final String? chapterId;
  final String? countryName;

  const JournalEditorScreen({super.key, this.chapterId, this.countryName});

  @override
  State<JournalEditorScreen> createState() => _JournalEditorScreenState();
}

class _JournalEditorScreenState extends State<JournalEditorScreen> {
  late final PageController _pageController;
  final List<EditorPageState> _pages = [];
  Journal? _journal;
  int _currentIndex = 0;
  String? _selectedElementId;
  String? _editingElementId;
  Timer? _autosaveTimer;
  bool _saving = false;

  // Format defaults used for the next text block when no text is selected.
  bool _defBold = false;
  bool _defItalic = false;
  bool _defUnderline = false;
  int _defColorValue = 0xDD000000;
  String _defFont = 'DM Sans';
  double _defFontSize = 14;

  static const List<String> _availableFonts = [
    'DM Sans',
    'Playfair Display',
    'Dancing Script',
  ];

  static const Map<String?, String> _pageBackgrounds = {
    null: 'Cream',
    '#FFF3E0': 'Peach',
    '#E8F5E9': 'Mint',
    '#E3F2FD': 'Sky',
    '#F3E5F5': 'Lavender',
    '#FFFDE7': 'Lemon',
  };

  static const List<Color> _textColors = [
    Colors.black87,
    Colors.red,
    Colors.blue,
    Colors.green,
    AppTheme.primary,
    Colors.purple,
    Colors.orange,
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _initJournal();
  }

  void _initJournal() {
    Journal? journal;
    if (widget.chapterId != null) {
      final id = int.tryParse(widget.chapterId!) ?? 0;
      journal = JournalService.getJournalById(id);
    }
    if (journal == null) {
      final countryId = widget.countryName != null
          ? CountryService.countryIdByName(widget.countryName!)
          : 0;
      journal = Journal(
        journalId: DateTime.now().millisecondsSinceEpoch,
        title: widget.countryName ?? 'My Travel Journal',
        countryId: countryId,
      );
    }
    _journal = journal;
    if (journal.pages.isEmpty) {
      _pages.add(EditorPageState(pageNumber: 1));
    } else {
      for (var i = 0; i < journal.pages.length; i++) {
        final page = journal.pages[i];
        _pages.add(EditorPageState(
          pageId: page.pageId == 0 ? null : page.pageId,
          pageNumber: i + 1,
          backgroundColor: page.backgroundColor,
          elements: [
            for (final el in page.elements) EditorElement.fromJournalElement(el),
          ],
        ));
      }
    }
  }

  // ---------------------------------------------------------------- saving

  Journal _buildJournalForSave() {
    final journal = _journal!;
    final pages = <JournalPage>[];
    for (var i = 0; i < _pages.length; i++) {
      final page = _pages[i];
      page.pageNumber = i + 1;
      pages.add(JournalPage(
        pageId: page.pageId ?? 0,
        pageNumber: i + 1,
        backgroundColor: page.backgroundColor,
        elements: [
          for (final el in page.elements) el.toJournalElement(),
        ],
      ));
    }
    return Journal(
      journalId: journal.journalId,
      title: journal.title,
      countryId: journal.countryId,
      coverImage: journal.coverImage,
      pages: pages,
    );
  }

  /// Saves the journal; on failure queues the draft offline. Returns true when
  /// the save was queued (offline) instead of reaching the server.
  Future<bool> _persistJournal() async {
    if (_journal == null) return false;
    final journal = _buildJournalForSave();
    setState(() => _saving = true);
    try {
      final result = await JournalService.saveJournal(journal);
      if (!mounted) return false;
      _journal = Journal(
        journalId: result.journalId,
        title: journal.title,
        countryId: journal.countryId,
        coverImage: journal.coverImage,
        pages: journal.pages,
      );
      for (final saved in result.pages) {
        if (saved.pageNumber >= 1 && saved.pageNumber <= _pages.length) {
          _pages[saved.pageNumber - 1].pageId = saved.pageId;
        }
      }
      setState(() => _saving = false);
      return false;
    } catch (e) {
      debugPrint('Journal save failed, queueing offline: $e');
      setState(() => _saving = false);
      await SyncQueueService.enqueue(SyncAction(
        type: SyncActionType.saveDraft,
        data: journal.toJson(),
        timestamp: DateTime.now(),
      ));
      return true;
    }
  }

  void _scheduleAutosave() {
    _autosaveTimer?.cancel();
    _autosaveTimer = Timer(const Duration(milliseconds: 700), () {
      _autosaveTimer = null;
      _persistJournal();
    });
  }

  Future<void> _saveNow() async {
    final queued = await _persistJournal();
    if (!mounted) return;
    _showSnack(
      queued ? 'Saved on this device — will sync when online.' : 'Draft saved!',
    );
  }

  void _showSnack(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: GoogleFonts.dmSans()),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  // ------------------------------------------------------------- selection

  EditorElement? get _selectedElement {
    if (_pages.isEmpty) return null;
    final page = _pages[_currentIndex];
    for (final el in page.elements) {
      if (el.id == _selectedElementId) return el;
    }
    return null;
  }

  bool get _formattingText => _selectedElement?.type == 'text';

  bool get _isBold => _formattingText ? _selectedElement!.bold : _defBold;
  bool get _isItalic => _formattingText ? _selectedElement!.italic : _defItalic;
  bool get _isUnderline =>
      _formattingText ? _selectedElement!.underline : _defUnderline;
  int get _colorValue =>
      _formattingText ? _selectedElement!.textColorValue : _defColorValue;
  String get _currentFont =>
      _formattingText ? _selectedElement!.fontFamily : _defFont;
  double get _fontSize =>
      _formattingText ? _selectedElement!.fontSize : _defFontSize;

  // ---------------------------------------------------------------- build

  @override
  Widget build(BuildContext context) {
    final selected = _selectedElement;
    return Scaffold(
      backgroundColor: const Color(0xFFFFFEF6),
      extendBody: true,
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _journal?.title ?? 'New Journal',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.playfairDisplay(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppTheme.darkBrown,
              ),
            ),
            Text(
              '${_pages.length} page${_pages.length == 1 ? '' : 's'}',
              style: GoogleFonts.dmSans(
                fontSize: 11,
                color: AppTheme.warmGray,
              ),
            ),
          ],
        ),
        backgroundColor: const Color(0xFFFFFEF6),
        elevation: 0,
        actions: [
          if (_saving)
            const Padding(
              padding: EdgeInsets.only(right: 16),
              child: Center(
                child: SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
              ),
            )
          else
            IconButton(
              icon: const Icon(Icons.save_outlined),
              tooltip: 'Save',
              onPressed: _journal == null ? null : _saveNow,
            ),
        ],
      ),
      body: Column(
        children: [
          EditorPageStrip(
            pageCount: _pages.length,
            currentIndex: _currentIndex,
            onPageSelected: (index) => _animateTo(index),
            onPageLongPress: _showPageMenu,
            onAddPage: _addPage,
            onBackground: _pickPageBackground,
          ),
          EditorFormatToolbar(
            bold: _isBold,
            italic: _isItalic,
            underline: _isUnderline,
            fontSize: _fontSize,
            onToggleBold: _toggleBold,
            onToggleItalic: _toggleItalic,
            onToggleUnderline: _toggleUnderline,
            onPickColor: _showColorPicker,
            onPickFont: _showFontPicker,
            onFontSize: _setFontSize,
          ),
          Expanded(child: _buildPagesView()),
          if (selected != null)
            EditorSelectionToolbar(
              canEdit: selected.type == 'text',
              onEdit: () => setState(() => _editingElementId = selected.id),
              onRotateLeft: () => _adjust(selected, rotation: -15),
              onRotateRight: () => _adjust(selected, rotation: 15),
              onSmaller: () => _adjust(selected, scaleDelta: -0.15),
              onBigger: () => _adjust(selected, scaleDelta: 0.15),
              onBringForward: () => _bringForward(selected),
              onSendBackward: () => _sendBackward(selected),
              onDuplicate: () => _duplicateElement(selected),
              onDelete: () => _deleteElement(selected),
            ),
          EditorBottomPanel(
            onAddPage: _addPage,
            onAddText: _addTextBlock,
            onPickImage: _pickImage,
            onScanTicket: _scanTicket,
            onPickSticker: _showStickerPicker,
          ),
        ],
      ),
    );
  }

  Widget _buildPagesView() {
    return PageView.builder(
      controller: _pageController,
      itemCount: _pages.length,
      onPageChanged: (index) {
        setState(() {
          _currentIndex = index;
          _selectedElementId = null;
          _editingElementId = null;
        });
      },
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
          child: EditorPage(
            page: _pages[index],
            journalTitle: _journal?.title ?? '',
            selectedElementId: _selectedElementId,
            editingElementId: _editingElementId,
            onSelect: (id) {
              setState(() {
                _selectedElementId = id;
                if (id == null) _editingElementId = null;
              });
            },
            onElementChanged: (el) {
              setState(() {});
              _scheduleAutosave();
            },
            onElementDoubleTap: _handleElementDoubleTap,
            onElementLongPress: _handleElementLongPress,
          ),
        );
      },
    );
  }

  void _animateTo(int index) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || !_pageController.hasClients) return;
      _pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
      );
    });
  }

  // -------------------------------------------------------------- elements

  void _addTextBlock() {
    final page = _pages[_currentIndex];
    final n = page.elements.length;
    final el = EditorElement(
      id: 'text_${DateTime.now().microsecondsSinceEpoch}',
      type: 'text',
      x: 40 + (n % 5) * 20,
      y: 70 + (n % 5) * 26,
      zIndex: 3,
      text: 'Double-tap to edit',
      fontFamily: _defFont,
      fontSize: _defFontSize,
      textColorValue: _defColorValue,
      bold: _defBold,
      italic: _defItalic,
      underline: _defUnderline,
    );
    setState(() {
      page.elements.add(el);
      _selectedElementId = el.id;
      _editingElementId = el.id;
    });
    _scheduleAutosave();
  }

  Future<void> _pickImage() async {
    final source = await showModalBottomSheet<ImageSource>(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(AppTheme.space4),
              child: Text(
                'Add a picture',
                style: GoogleFonts.dmSans(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.photo_library_outlined),
              title: const Text('From gallery'),
              onTap: () => Navigator.pop(context, ImageSource.gallery),
            ),
            ListTile(
              leading: const Icon(Icons.photo_camera_outlined),
              title: const Text('Take a photo'),
              onTap: () => Navigator.pop(context, ImageSource.camera),
            ),
          ],
        ),
      ),
    );
    if (source == null) return;
    final picked = await ImagePicker().pickImage(
      source: source,
      maxWidth: 1920,
      maxHeight: 1920,
      imageQuality: 88,
    );
    if (picked == null) return;
    final bytes = await picked.readAsBytes();
    await _addPhoto(bytes);
  }

  Future<void> _addPhoto(Uint8List bytes) async {
    if (_journal == null) return;
    try {
      await _persistJournal();
      if (!mounted) return;
      final page = _pages[_currentIndex];
      final n = page.elements.length;
      final el = EditorElement(
        id: 'image_${DateTime.now().microsecondsSinceEpoch}',
        type: 'image',
        x: 40 + (n % 5) * 18,
        y: 90 + (n % 5) * 22,
        width: 200,
        height: 160,
        zIndex: 1,
      );
      setState(() {
        page.elements.add(el);
        _selectedElementId = el.id;
      });
      final result = await ImageUploadService.upload(
        journalId: _journal!.journalId,
        journalTitle: _journal!.title,
        countryId: _journal!.countryId,
        pageId: page.pageId,
        elementKey: el.elementKey ?? el.id,
        imageBytes: bytes,
        xPosition: el.x,
        yPosition: el.y,
        width: el.width!,
        height: el.height!,
        scale: el.scale,
        rotation: el.rotation,
        zIndex: el.zIndex,
      );
      if (!mounted) return;
      setState(() {
        if (result.journalId != null &&
            result.journalId != _journal!.journalId) {
          _journal = Journal(
            journalId: result.journalId!,
            title: _journal!.title,
            countryId: _journal!.countryId,
            coverImage: _journal!.coverImage,
            pages: _journal!.pages,
          );
        }
        page.pageId = result.pageId ?? page.pageId;
        el.imageUrl = result.imageUrl;
        el.localImageBytes = result.queuedOffline ? bytes : null;
        el.uploadPending = result.queuedOffline;
      });
      _scheduleAutosave();
      _showSnack(
        result.queuedOffline
            ? 'Picture saved on this device — will sync when online.'
            : 'Picture added!',
      );
    } catch (e) {
      debugPrint('Add photo error: $e');
      if (mounted) _showSnack('Could not add picture: $e');
    }
  }

  Future<void> _scanTicket() async {
    try {
      final captured = await TicketScanService.capture(context);
      if (captured == null) return;
      final originalBytes = captured.bytes;

      final corners = await TicketScanService.detect(originalBytes);
      Uint8List? cropped = corners != null
          ? await TicketScanService.crop(originalBytes, corners)
          : null;

      if (cropped == null) {
        if (!mounted) return;
        final manual = await Navigator.of(context).push<ManualCropResult>(
          MaterialPageRoute(
            builder: (_) => ManualCropScreen(
              imageBytes: originalBytes,
              initialCorners: corners,
            ),
          ),
        );
        if (manual == null || manual.action == ManualCropAction.cancelled) {
          return;
        }
        if (manual.action == ManualCropAction.retake) {
          _scanTicket();
          return;
        }
        cropped = manual.bytes;
      }
      if (cropped == null) return;

      if (!mounted) return;
      final preview = await Navigator.of(context).push<TicketPreviewResult>(
        MaterialPageRoute(
          builder: (_) => TicketPreviewScreen(
            originalBytes: originalBytes,
            croppedBytes: cropped!,
            onSave: (processed, backgroundRemoved) =>
                _saveTicket(originalBytes, processed, backgroundRemoved),
          ),
        ),
      );
      if (preview == null) return;
      if (preview.action == TicketPreviewAction.retake) {
        _scanTicket();
        return;
      }
      if (preview.action == TicketPreviewAction.saved &&
          preview.saveResult != null &&
          preview.processedBytes != null) {
        final result = preview.saveResult!;
        _addTicketElement(result, preview.processedBytes!);
        if (mounted) {
          _showSnack(
            result.queuedOffline
                ? 'Ticket saved on this device. Will sync when online.'
                : 'Ticket added to your journal!',
          );
        }
      }
    } on TicketScanCancelledException {
      return;
    } on TicketScanException catch (e) {
      if (mounted) _showSnack(e.message);
    } catch (e) {
      if (mounted) _showSnack('Ticket scan failed: $e');
    }
  }

  Future<TicketSaveResult> _saveTicket(
    Uint8List originalBytes,
    Uint8List processedBytes,
    bool backgroundRemoved,
  ) async {
    await _persistJournal();
    final page = _pages[_currentIndex];
    final n = page.elements.length;
    final elementKey = 'ticket_${DateTime.now().microsecondsSinceEpoch}';
    return TicketScanService.save(
      journalId: _journal!.journalId,
      journalTitle: _journal!.title,
      countryId: _journal!.countryId,
      pageId: page.pageId,
      elementKey: elementKey,
      originalBytes: originalBytes,
      processedBytes: processedBytes,
      backgroundRemoved: backgroundRemoved,
      xPosition: 40 + (n % 5) * 14,
      yPosition: 100 + (n % 5) * 18,
      width: 200,
      height: 130,
      scale: 1,
      rotation: 0,
      zIndex: 1,
    );
  }

  void _addTicketElement(TicketSaveResult result, Uint8List processedBytes) {
    final journal = _journal;
    if (journal == null) return;
    final page = _pages[_currentIndex];
    final n = page.elements.length;
    if (result.journalId != null && result.journalId != journal.journalId) {
      _journal = Journal(
        journalId: result.journalId!,
        title: journal.title,
        countryId: journal.countryId,
        coverImage: journal.coverImage,
        pages: journal.pages,
      );
    }
    final el = EditorElement(
      id: result.elementKey ?? 'ticket_${DateTime.now().microsecondsSinceEpoch}',
      type: 'ticket',
      elementKey: result.elementKey,
      x: 40 + (n % 5) * 14,
      y: 100 + (n % 5) * 18,
      width: 200,
      height: 130,
      zIndex: 1,
      imageUrl: result.imageUrl,
      ticketId: result.ticketId,
      localImageBytes: result.queuedOffline ? processedBytes : null,
      uploadPending: result.queuedOffline,
    );
    setState(() {
      page.pageId = result.pageId ?? page.pageId;
      page.elements.add(el);
      _selectedElementId = el.id;
    });
    _scheduleAutosave();
  }

  void _addStickerToCanvas(String emoji) {
    final page = _pages[_currentIndex];
    final n = page.elements.length;
    setState(() {
      page.elements.add(EditorElement(
        id: 'sticker_${DateTime.now().microsecondsSinceEpoch}',
        type: 'sticker',
        x: 40 + (n % 5) * 20,
        y: 100 + (n % 5) * 30,
        zIndex: 2,
        emoji: emoji,
        stickerSize: 40,
      ));
    });
    _scheduleAutosave();
  }

  void _showStickerPicker() {
    const stickers = [
      {'emoji': '✈️', 'name': 'Airplane'},
      {'emoji': '🎫', 'name': 'Ticket'},
      {'emoji': '📸', 'name': 'Camera'},
      {'emoji': '🎨', 'name': 'Art'},
      {'emoji': '☕', 'name': 'Coffee'},
      {'emoji': '🏛️', 'name': 'Building'},
      {'emoji': '🎭', 'name': 'Theater'},
      {'emoji': '🍷', 'name': 'Wine'},
    ];
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(AppTheme.space4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Add Sticker',
              style: GoogleFonts.dmSans(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: AppTheme.space4),
            Wrap(
              spacing: AppTheme.space3,
              runSpacing: AppTheme.space3,
              children: stickers.map((sticker) {
                return GestureDetector(
                  onTap: () {
                    _addStickerToCanvas(sticker['emoji'] as String);
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(AppTheme.space2),
                    decoration: BoxDecoration(
                      color: AppTheme.bg,
                      borderRadius: BorderRadius.circular(AppTheme.radiusMd),
                    ),
                    child: Column(
                      children: [
                        Text(
                          sticker['emoji'] as String,
                          style: const TextStyle(fontSize: 32),
                        ),
                        Text(
                          sticker['name'] as String,
                          style: GoogleFonts.dmSans(fontSize: 11),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  void _handleElementDoubleTap(EditorElement el) {
    if (el.type == 'text') {
      setState(() {
        _selectedElementId = el.id;
        _editingElementId = el.id;
      });
    }
  }

  void _handleElementLongPress(EditorElement el) {
    setState(() => _selectedElementId = el.id);
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (el.type == 'text')
              ListTile(
                leading: const Icon(Icons.edit),
                title: const Text('Edit text'),
                onTap: () {
                  Navigator.pop(context);
                  setState(() => _editingElementId = el.id);
                },
              ),
            ListTile(
              leading: const Icon(Icons.copy),
              title: const Text('Duplicate'),
              onTap: () {
                Navigator.pop(context);
                _duplicateElement(el);
              },
            ),
            ListTile(
              leading: const Icon(Icons.layers_clear),
              title: const Text('Bring forward'),
              onTap: () {
                Navigator.pop(context);
                _bringForward(el);
              },
            ),
            ListTile(
              leading: const Icon(Icons.layers),
              title: const Text('Send backward'),
              onTap: () {
                Navigator.pop(context);
                _sendBackward(el);
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete_outline, color: Colors.red),
              title: const Text('Delete', style: TextStyle(color: Colors.red)),
              onTap: () {
                Navigator.pop(context);
                _deleteElement(el);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _adjust(EditorElement el,
      {double rotation = 0, double scaleDelta = 0}) {
    setState(() {
      if (rotation != 0) {
        el.rotation = (el.rotation + rotation) % 360;
      }
      if (scaleDelta != 0) {
        el.scale = (el.scale + scaleDelta).clamp(0.2, 4.0).toDouble();
      }
    });
    _scheduleAutosave();
  }

  void _bringForward(EditorElement el) {
    setState(() => el.zIndex = (el.zIndex + 1).clamp(0, 50).toInt());
    _scheduleAutosave();
  }

  void _sendBackward(EditorElement el) {
    setState(() => el.zIndex = (el.zIndex - 1).clamp(0, 50).toInt());
    _scheduleAutosave();
  }

  void _duplicateElement(EditorElement el) {
    final copy = el.copyForDuplicate();
    setState(() {
      _pages[_currentIndex].elements.add(copy);
      _selectedElementId = copy.id;
    });
    _scheduleAutosave();
  }

  void _deleteElement(EditorElement el) {
    setState(() {
      _pages[_currentIndex].elements.removeWhere((e) => e.id == el.id);
      _selectedElementId = null;
    });
    final ticketId = el.ticketId;
    if (ticketId != null) {
      // Best effort: remove the uploaded image server-side too.
      ApiClient.delete('/tickets/$ticketId').catchError((_) {});
    }
    _scheduleAutosave();
  }

  // --------------------------------------------------------------- format

  void _toggleBold() {
    if (_formattingText) {
      setState(() => _selectedElement!.bold = !_selectedElement!.bold);
      _scheduleAutosave();
    } else {
      setState(() => _defBold = !_defBold);
    }
  }

  void _toggleItalic() {
    if (_formattingText) {
      setState(() => _selectedElement!.italic = !_selectedElement!.italic);
      _scheduleAutosave();
    } else {
      setState(() => _defItalic = !_defItalic);
    }
  }

  void _toggleUnderline() {
    if (_formattingText) {
      setState(() => _selectedElement!.underline = !_selectedElement!.underline);
      _scheduleAutosave();
    } else {
      setState(() => _defUnderline = !_defUnderline);
    }
  }

  void _setFontSize(double size) {
    if (_formattingText) {
      setState(() => _selectedElement!.fontSize = size);
      _scheduleAutosave();
    } else {
      setState(() => _defFontSize = size);
    }
  }

  void _showColorPicker() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(AppTheme.space4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Text Color',
              style: GoogleFonts.dmSans(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: AppTheme.space4),
            Wrap(
              spacing: AppTheme.space3,
              children: _textColors.map((color) {
                final active = _colorValue == color.toARGB32();
                return GestureDetector(
                  onTap: () {
                    if (_formattingText) {
                      setState(
                        () =>
                            _selectedElement!.textColorValue = color.toARGB32(),
                      );
                      _scheduleAutosave();
                    } else {
                      setState(() => _defColorValue = color.toARGB32());
                    }
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: active ? AppTheme.darkBrown : Colors.transparent,
                        width: 3,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  void _showFontPicker() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(AppTheme.space4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Font Family',
              style: GoogleFonts.dmSans(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: AppTheme.space4),
            ..._availableFonts.map((font) {
              return ListTile(
                title: Text(
                  font,
                  style: _fontPreviewStyle(font),
                ),
                trailing: _currentFont == font
                    ? Icon(Icons.check, color: AppTheme.primary)
                    : null,
                onTap: () {
                  if (_formattingText) {
                    setState(() => _selectedElement!.fontFamily = font);
                    _scheduleAutosave();
                  } else {
                    setState(() => _defFont = font);
                  }
                  Navigator.pop(context);
                },
              );
            }),
          ],
        ),
      ),
    );
  }

  TextStyle _fontPreviewStyle(String font) {
    final base = TextStyle(fontSize: 18, color: AppTheme.darkBrown);
    switch (font) {
      case 'Playfair Display':
        return GoogleFonts.playfairDisplay(textStyle: base);
      case 'Dancing Script':
        return GoogleFonts.dancingScript(textStyle: base);
      default:
        return GoogleFonts.dmSans(textStyle: base);
    }
  }

  // ------------------------------------------------------------------ pages

  void _addPage() {
    setState(() {
      _pages.add(EditorPageState(pageNumber: _pages.length + 1));
      _selectedElementId = null;
      _editingElementId = null;
    });
    _animateTo(_pages.length - 1);
    _scheduleAutosave();
  }

  void _duplicatePage(int index) {
    final copy = EditorPageState(
      pageNumber: index + 1,
      backgroundColor: _pages[index].backgroundColor,
      elements: [
        for (final el in _pages[index].elements) el.copyForPage(),
      ],
    );
    setState(() => _pages.insert(index + 1, copy));
    _animateTo(index + 1);
    _scheduleAutosave();
  }

  void _deletePage(int index) {
    if (_pages.length <= 1) {
      _showSnack('A journal needs at least one page.');
      return;
    }
    setState(() {
      _pages.removeAt(index);
      _currentIndex = index > 0 ? index - 1 : 0;
      _selectedElementId = null;
      _editingElementId = null;
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted && _pageController.hasClients) {
        _pageController.jumpToPage(_currentIndex);
      }
    });
    _scheduleAutosave();
  }

  void _movePage(int index, int delta) {
    final target = index + delta;
    if (target < 0 || target >= _pages.length) return;
    setState(() {
      final page = _pages.removeAt(index);
      _pages.insert(target, page);
      if (_currentIndex == index) {
        _currentIndex = target;
      } else if (_currentIndex == target) {
        _currentIndex = index;
      }
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted && _pageController.hasClients) {
        _pageController.jumpToPage(_currentIndex);
      }
    });
    _scheduleAutosave();
  }

  void _showPageMenu(int index) {
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.copy),
              title: const Text('Duplicate page'),
              onTap: () {
                Navigator.pop(context);
                _duplicatePage(index);
              },
            ),
            ListTile(
              leading: const Icon(Icons.chevron_left),
              title: const Text('Move left'),
              enabled: index > 0,
              onTap: () {
                Navigator.pop(context);
                _movePage(index, -1);
              },
            ),
            ListTile(
              leading: const Icon(Icons.chevron_right),
              title: const Text('Move right'),
              enabled: index < _pages.length - 1,
              onTap: () {
                Navigator.pop(context);
                _movePage(index, 1);
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete_outline, color: Colors.red),
              title: const Text('Delete page',
                  style: TextStyle(color: Colors.red)),
              enabled: _pages.length > 1,
              onTap: () {
                Navigator.pop(context);
                _deletePage(index);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _pickPageBackground() {
    final page = _pages[_currentIndex];
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(AppTheme.space4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Page background',
              style: GoogleFonts.dmSans(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: AppTheme.space4),
            Wrap(
              spacing: AppTheme.space3,
              runSpacing: AppTheme.space3,
              children: _pageBackgrounds.entries.map((entry) {
                final active = page.backgroundColor == entry.key;
                return GestureDetector(
                  onTap: () {
                    setState(() => page.backgroundColor = entry.key);
                    Navigator.pop(context);
                    _scheduleAutosave();
                  },
                  child: Container(
                    width: 72,
                    padding: const EdgeInsets.all(AppTheme.space2),
                    decoration: BoxDecoration(
                      color: journalPageColor(entry.key),
                      borderRadius: BorderRadius.circular(AppTheme.radiusMd),
                      border: Border.all(
                        color: active
                            ? AppTheme.primary
                            : AppTheme.lightGray,
                        width: active ? 2 : 1,
                      ),
                    ),
                    child: Text(
                      entry.value,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.dmSans(
                        fontSize: 11,
                        color: AppTheme.darkBrown,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _autosaveTimer?.cancel();
    if (_journal != null) {
      // Fire-and-forget final save (no setState from dispose).
      final journal = _buildJournalForSave();
      unawaited(_saveJournalOnDispose(journal));
    }
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _saveJournalOnDispose(Journal journal) async {
    try {
      await JournalService.saveJournal(journal);
    } catch (e) {
      debugPrint('Final journal save failed, queueing offline: $e');
      await SyncQueueService.enqueue(SyncAction(
        type: SyncActionType.saveDraft,
        data: journal.toJson(),
        timestamp: DateTime.now(),
      ));
    }
  }
}
