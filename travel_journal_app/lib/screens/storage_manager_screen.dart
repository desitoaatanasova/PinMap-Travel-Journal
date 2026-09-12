import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinmap_travel_journal/services/sync_queue_service.dart';
import 'package:pinmap_travel_journal/services/trip_service.dart';
import 'package:pinmap_travel_journal/theme/app_theme.dart';

class StorageManagerScreen extends StatefulWidget {
  const StorageManagerScreen({super.key});

  @override
  State<StorageManagerScreen> createState() => _StorageManagerScreenState();
}

class _StorageManagerScreenState extends State<StorageManagerScreen> {
  int _pendingCount = 0;
  int _failedCount = 0;
  int _queueBytes = 0;
  bool _hasDraft = false;
  int _draftBytes = 0;
  bool _loading = true;
  List<SyncAction> _failedItems = [];

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final pending = SyncQueueService.pendingCount;
    final failed = SyncQueueService.deadLetterCount;
    final queueBytes = await SyncQueueService.getQueueBytes();
    final draft = await TripService.loadDraft();
    final draftBytes = await TripService.getDraftBytes();
    final failedItems = List<SyncAction>.from(SyncQueueService.deadLetters);
    if (mounted) {
      setState(() {
        _pendingCount = pending;
        _failedCount = failed;
        _queueBytes = queueBytes;
        _hasDraft = draft != null;
        _draftBytes = draftBytes;
        _failedItems = failedItems;
        _loading = false;
      });
    }
  }

  String _formatBytes(int bytes) {
    if (bytes < 1024) return '$bytes B';
    final kb = bytes / 1024;
    if (kb < 1024) return '${kb.toStringAsFixed(1)} KB';
    return '${(kb / 1024).toStringAsFixed(1)} MB';
  }

  Future<void> _retryAll() async {
    SyncQueueService.clearAuthPause();
    await SyncQueueService.processQueue();
    await _load();
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Retrying pending changes',
            style: GoogleFonts.dmSans(),
          ),
        ),
      );
    }
  }

  Future<void> _confirmClearFailed() async {
    if (_failedCount == 0) return;
    final ok = await showDialog<bool>(
      context: context,
      builder:
          (ctx) => AlertDialog(
            title: Text(
              'Clear failed operations?',
              style: GoogleFonts.playfairDisplay(
                color: AppTheme.darkBrown,
                fontWeight: FontWeight.bold,
              ),
            ),
            content: Text(
              'This will remove $_failedCount failed operation(s) that could not be synced. This cannot be undone.',
              style: GoogleFonts.dmSans(),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx, false),
                child: Text(
                  'Cancel',
                  style: GoogleFonts.dmSans(color: AppTheme.warmGray),
                ),
              ),
              ElevatedButton(
                onPressed: () => Navigator.pop(ctx, true),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                ),
                child: Text('Clear', style: GoogleFonts.dmSans()),
              ),
            ],
          ),
    );
    if (ok == true) {
      await SyncQueueService.discardAllDeadLetters();
      await _load();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Failed operations cleared',
              style: GoogleFonts.dmSans(),
            ),
          ),
        );
      }
    }
  }

  Future<void> _confirmClearDraft() async {
    if (!_hasDraft) return;
    final ok = await showDialog<bool>(
      context: context,
      builder:
          (ctx) => AlertDialog(
            title: Text(
              'Clear AI draft?',
              style: GoogleFonts.playfairDisplay(
                color: AppTheme.darkBrown,
                fontWeight: FontWeight.bold,
              ),
            ),
            content: Text(
              'This will remove the saved AI trip draft. This cannot be undone.',
              style: GoogleFonts.dmSans(),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx, false),
                child: Text(
                  'Cancel',
                  style: GoogleFonts.dmSans(color: AppTheme.warmGray),
                ),
              ),
              ElevatedButton(
                onPressed: () => Navigator.pop(ctx, true),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                ),
                child: Text('Clear', style: GoogleFonts.dmSans()),
              ),
            ],
          ),
    );
    if (ok == true) {
      await TripService.clearDraft();
      await _load();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Draft cleared', style: GoogleFonts.dmSans())),
        );
      }
    }
  }

  Future<void> _retryOne(SyncAction a) async {
    await SyncQueueService.retryDeadLetter(a.id);
    await _load();
  }

  Future<void> _clearOne(SyncAction a) async {
    await SyncQueueService.discardDeadLetter(a.id);
    await _load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.bg,
      appBar: AppBar(
        title: Text(
          'Storage',
          style: GoogleFonts.playfairDisplay(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: AppTheme.darkBrown,
          ),
        ),
        backgroundColor: AppTheme.bg,
        elevation: 0,
      ),
      body:
          _loading
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                padding: const EdgeInsets.all(AppTheme.space4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildSectionHeader('Sync'),
                    const SizedBox(height: AppTheme.space2),
                    _buildCard(
                      icon: Icons.sync,
                      title: 'Pending sync',
                      subtitle:
                          _pendingCount == 0
                              ? 'No pending changes'
                              : '$_pendingCount pending • ${_formatBytes(_queueBytes)}',
                      trailing: ElevatedButton(
                        onPressed: _pendingCount == 0 ? null : _retryAll,
                        child: Text(
                          'Retry',
                          style: GoogleFonts.dmSans(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    _buildCard(
                      icon: Icons.error_outline,
                      title: 'Failed operations',
                      subtitle:
                          _failedCount == 0
                              ? 'No failed operations'
                              : '$_failedCount failed',
                      trailing: ElevatedButton(
                        onPressed:
                            _failedCount == 0 ? null : _confirmClearFailed,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                        ),
                        child: Text(
                          'Clear failed',
                          style: GoogleFonts.dmSans(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    if (_failedItems.isNotEmpty) ...[
                      const SizedBox(height: AppTheme.space2),
                      ..._failedItems.map(
                        (a) => Container(
                          margin: const EdgeInsets.only(
                            bottom: AppTheme.space2,
                          ),
                          decoration: BoxDecoration(
                            color: AppTheme.card,
                            borderRadius: BorderRadius.circular(
                              AppTheme.radiusMd,
                            ),
                            boxShadow: AppTheme.shadowSm,
                          ),
                          child: ListTile(
                            title: Text(
                              a.type.name,
                              style: GoogleFonts.dmSans(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: AppTheme.darkBrown,
                              ),
                            ),
                            subtitle: Text(
                              a.lastError ?? 'Failed',
                              style: GoogleFonts.dmSans(
                                fontSize: 11,
                                color: AppTheme.warmGray,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.refresh, size: 18),
                                  color: AppTheme.primary,
                                  onPressed: () => _retryOne(a),
                                ),
                                IconButton(
                                  icon: const Icon(
                                    Icons.delete_outline,
                                    size: 18,
                                  ),
                                  color: Colors.red,
                                  onPressed: () => _clearOne(a),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                    const SizedBox(height: AppTheme.space6),
                    _buildSectionHeader('Drafts'),
                    const SizedBox(height: AppTheme.space2),
                    _buildCard(
                      icon: Icons.auto_awesome_outlined,
                      title: 'AI Trip Draft',
                      subtitle:
                          _hasDraft
                              ? 'Draft saved • ${_formatBytes(_draftBytes)}'
                              : 'No draft',
                      trailing: ElevatedButton(
                        onPressed: !_hasDraft ? null : _confirmClearDraft,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                        ),
                        child: Text(
                          'Clear draft',
                          style: GoogleFonts.dmSans(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: AppTheme.space6),
                    _buildSectionHeader('Cache'),
                    const SizedBox(height: AppTheme.space2),
                    Container(
                      decoration: BoxDecoration(
                        color: AppTheme.card,
                        borderRadius: BorderRadius.circular(AppTheme.radiusMd),
                        boxShadow: AppTheme.shadowSm,
                      ),
                      padding: const EdgeInsets.all(AppTheme.space4),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.storage_outlined,
                                color: AppTheme.primary,
                              ),
                              const SizedBox(width: AppTheme.space2),
                              Text(
                                'Browser-managed storage',
                                style: GoogleFonts.dmSans(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: AppTheme.darkBrown,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: AppTheme.space2),
                          Text(
                            'Some cached images and browser storage are managed by your browser and their exact size cannot be reliably measured by the app.',
                            style: GoogleFonts.dmSans(
                              fontSize: 12,
                              color: AppTheme.warmGray,
                              height: 1.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppTheme.space12),
                  ],
                ),
              ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: AppTheme.space2),
      child: Text(
        title.toUpperCase(),
        style: GoogleFonts.dmSans(
          fontSize: 12,
          fontWeight: FontWeight.w700,
          color: AppTheme.primary,
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  Widget _buildCard({
    required IconData icon,
    required String title,
    required String subtitle,
    Widget? trailing,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppTheme.space2),
      decoration: BoxDecoration(
        color: AppTheme.card,
        borderRadius: BorderRadius.circular(AppTheme.radiusMd),
        boxShadow: AppTheme.shadowSm,
      ),
      child: ListTile(
        leading: Icon(icon, color: AppTheme.primary),
        title: Text(
          title,
          style: GoogleFonts.dmSans(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppTheme.darkBrown,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: GoogleFonts.dmSans(fontSize: 12, color: AppTheme.warmGray),
        ),
        trailing: trailing,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppTheme.space4,
          vertical: AppTheme.space2,
        ),
      ),
    );
  }
}
