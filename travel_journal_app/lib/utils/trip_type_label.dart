import 'package:pinmap_travel_journal/l10n/app_localizations.dart';
import 'package:pinmap_travel_journal/utils/category_label.dart';

String tripStyleLabel(String identifier, AppLocalizations l10n) {
  switch (identifier) {
    case 'Solo':
      return l10n.tripStyleSolo;
    case 'Group':
      return l10n.tripStyleGroup;
    default:
      return identifier;
  }
}

String tripTypeLabel(String identifier, AppLocalizations l10n) {
  switch (identifier) {
    case 'Historical':
      return l10n.tripTypeHistorical;
    case 'Art':
      return l10n.tripTypeArt;
    case 'Hidden Gems':
      return categoryLabel(identifier, l10n);
    case 'Mixed':
      return l10n.tripTypeMixed;
    default:
      return identifier;
  }
}
