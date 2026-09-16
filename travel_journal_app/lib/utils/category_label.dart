import 'package:pinmap_travel_journal/l10n/app_localizations.dart';

String categoryLabel(String identifier, AppLocalizations l10n) {
  switch (identifier) {
    case 'Historical Sights':
      return l10n.catHistorical;
    case 'For the Art Lovers':
      return l10n.catArtLovers;
    case 'Atmosphere & experience':
      return l10n.catAtmosphere;
    case 'Hidden Gems':
      return l10n.catHiddenGems;
    case 'Close by':
      return l10n.catCloseBy;
    case 'My places':
      return l10n.catMyPlaces;
    default:
      return identifier;
  }
}
