import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:pinmap_travel_journal/services/ticket_scan_service.dart';
import 'package:pinmap_travel_journal/theme/app_theme.dart';

enum TicketPreviewAction { saved, retake }

class TicketPreviewResult {
  final TicketPreviewAction action;
  final TicketSaveResult? saveResult;
  final Uint8List? processedBytes;

  TicketPreviewResult({required this.action, this.saveResult, this.processedBytes});
}

class TicketPreviewScreen extends StatefulWidget {
  final Uint8List originalBytes;
  final Uint8List croppedBytes;
  final Future<TicketSaveResult> Function(
      Uint8List processedBytes, bool backgroundRemoved) onSave;

  const TicketPreviewScreen({
    super.key,
    required this.originalBytes,
    required this.croppedBytes,
    required this.onSave,
  });

  @override
  State<TicketPreviewScreen> createState() => _TicketPreviewScreenState();
}

class _TicketPreviewScreenState extends State<TicketPreviewScreen> {
  bool _removeBackground = true;
  bool _keepOriginal = false;
  bool _busy = true;
  Uint8List? _previewBytes;
  String? _error;

  @override
  void initState() {
    super.initState();
    _refreshPreview();
  }

  Future<void> _refreshPreview() async {
    setState(() {
      _busy = true;
      _error = null;
    });
    try {
      final bytes = await TicketScanService.process(
        cropped: widget.croppedBytes,
        removeBackground: _removeBackground,
      );
      if (mounted) setState(() => _previewBytes = bytes);
    } catch (e) {
      if (mounted) setState(() => _error = 'Could not process image: $e');
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  void _setBackgroundRemoved(bool value) {
    setState(() {
      _removeBackground = value;
      _keepOriginal = !value;
    });
    _refreshPreview();
  }

  Future<void> _save() async {
    if (_busy || _previewBytes == null) return;
    setState(() {
      _busy = true;
      _error = null;
    });
    try {
      final processed = await TicketScanService.process(
        cropped: widget.croppedBytes,
        removeBackground: _removeBackground,
      );
      final result = await widget.onSave(processed, _removeBackground);
      if (mounted) {
        Navigator.of(context).pop(TicketPreviewResult(
          action: TicketPreviewAction.saved,
          saveResult: result,
          processedBytes: processed,
        ));
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = 'Upload failed: $e';
          _busy = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.bg,
      appBar: AppBar(
        title: Text('Ticket preview', style: GoogleFonts.dmSans(fontWeight: FontWeight.w600)),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: Center(
                  child: _previewBytes == null
                      ? const CircularProgressIndicator()
                      : Container(
                          margin: const EdgeInsets.all(AppTheme.space4),
                          decoration: BoxDecoration(
                            color: AppTheme.card,
                            borderRadius: BorderRadius.circular(AppTheme.radiusLg),
                            boxShadow: AppTheme.shadowMd,
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(AppTheme.radiusLg),
                            child: Image.memory(
                              _previewBytes!,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                ),
              ),
              if (_error != null)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppTheme.space4),
                  child: Text(
                    _error!,
                    style: GoogleFonts.dmSans(color: Colors.red, fontSize: 13),
                    textAlign: TextAlign.center,
                  ),
                ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppTheme.space4),
                child: Container(
                  decoration: BoxDecoration(
                    color: AppTheme.card,
                    borderRadius: BorderRadius.circular(AppTheme.radiusLg),
                    boxShadow: AppTheme.shadowSm,
                  ),
                  child: Column(
                    children: [
                      SwitchListTile(
                        title: Text('Remove background', style: GoogleFonts.dmSans(fontWeight: FontWeight.w600)),
                        subtitle: Text('Isolate the ticket, keep transparency', style: GoogleFonts.dmSans(fontSize: 12, color: AppTheme.warmGray)),
                        value: _removeBackground,
                        activeColor: AppTheme.primary,
                        onChanged: _setBackgroundRemoved,
                      ),
                      SwitchListTile(
                        title: Text('Keep original image', style: GoogleFonts.dmSans(fontWeight: FontWeight.w600)),
                        subtitle: Text('Keep original colors and background', style: GoogleFonts.dmSans(fontSize: 12, color: AppTheme.warmGray)),
                        value: _keepOriginal,
                        activeColor: AppTheme.primary,
                        onChanged: (value) => _setBackgroundRemoved(!value),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(AppTheme.space4),
                child: Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: _busy
                            ? null
                            : () => Navigator.of(context).pop(
                                  TicketPreviewResult(action: TicketPreviewAction.retake),
                                ),
                        child: const Text('Retake photo'),
                      ),
                    ),
                    const SizedBox(width: AppTheme.space3),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _busy ? null : _save,
                        child: const Text('Save'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (_busy)
            Container(
              color: Colors.black.withValues(alpha: 0.2),
              child: const Center(child: CircularProgressIndicator()),
            ),
        ],
      ),
    );
  }
}
