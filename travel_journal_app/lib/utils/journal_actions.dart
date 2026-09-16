import 'package:flutter/material.dart';
import 'package:pinmap_travel_journal/l10n/app_localizations.dart';
import 'package:pinmap_travel_journal/models/journal.dart';
import 'package:pinmap_travel_journal/services/journal_service.dart';
import 'package:pinmap_travel_journal/utils/dialog_helper.dart';
import 'package:pinmap_travel_journal/utils/snackbar_helper.dart';

bool _deleteInProgress = false;

/// Shows a destructive confirmation dialog and permanently deletes the
/// journal via [JournalService.deleteJournal].
/// Returns true only when the journal was deleted.
Future<bool> confirmDeleteJournal(BuildContext context, Journal journal) async {
  if (_deleteInProgress) return false;
  final l10n = AppLocalizations.of(context);
  final confirmed = await showAppConfirmDialog(
    context,
    title: l10n.journalDeleteTitle,
    content: l10n.journalDeleteText(journal.title),
    confirmText: l10n.settingsDelete,
    cancelText: l10n.commonCancel,
    confirmColor: Colors.red,
  );
  if (confirmed != true) return false;
  if (!context.mounted) return false;
  _deleteInProgress = true;
  try {
    await JournalService.deleteJournal(journal.journalId);
    if (!context.mounted) return true;
    showAppSnackBar(context, AppLocalizations.of(context).journalDeleted);
    return true;
  } catch (_) {
    if (context.mounted) {
      showAppSnackBar(context, AppLocalizations.of(context).journalDeleteError);
    }
    return false;
  } finally {
    _deleteInProgress = false;
  }
}
