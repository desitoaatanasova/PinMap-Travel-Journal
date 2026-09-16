import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinmap_travel_journal/models/wishlist_item.dart';
import 'package:pinmap_travel_journal/l10n/app_localizations.dart';
import 'package:pinmap_travel_journal/utils/category_label.dart';
import 'package:pinmap_travel_journal/widgets/authenticated_image.dart';
import 'package:pinmap_travel_journal/utils/snackbar_helper.dart';
import 'package:pinmap_travel_journal/utils/dialog_helper.dart';
import 'package:pinmap_travel_journal/services/wishlist_service.dart';
import 'package:pinmap_travel_journal/services/country_service.dart';
import 'package:pinmap_travel_journal/services/place_service.dart';
import 'package:pinmap_travel_journal/screens/country_page.dart';
import 'package:pinmap_travel_journal/screens/place_details_page.dart';
import 'package:pinmap_travel_journal/widgets/premium_card.dart';
import 'package:pinmap_travel_journal/theme/app_theme.dart';

class WishListScreen extends StatefulWidget {
  const WishListScreen({super.key});

  @override
  State<WishListScreen> createState() => _WishListScreenState();
}

class _WishListScreenState extends State<WishListScreen> {
  bool _isGridView = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    await WishlistService.loadItems();
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      extendBody: true,
      body: ValueListenableBuilder<int>(
        valueListenable: WishlistService.version,
        builder: (context, _, __) {
          final items = WishlistService.getAllItems();
          return CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 120,
                pinned: true,
                elevation: 0,
                flexibleSpace: FlexibleSpaceBar(
                  title: Text(
                    l10n.navWishlist,
                    style: GoogleFonts.playfairDisplay(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  titlePadding: const EdgeInsets.only(
                    left: AppTheme.space4,
                    bottom: AppTheme.space4,
                  ),
                ),
                actions: [
                  IconButton(
                    icon: Icon(_isGridView ? Icons.view_list : Icons.grid_view),
                    color: AppTheme.warmGray,
                    onPressed: () {
                      setState(() {
                        _isGridView = !_isGridView;
                      });
                    },
                  ),
                ],
              ),
              if (items.isEmpty)
                SliverFillRemaining(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.favorite_border,
                          size: 64,
                          color: AppTheme.warmGray.withValues(alpha: 0.5),
                        ),
                        const SizedBox(height: AppTheme.space4),
                        Text(
                          l10n.wishEmpty,
                          style: GoogleFonts.playfairDisplay(
                            fontSize: 20,
                            color: AppTheme.warmGray,
                          ),
                        ),
                        const SizedBox(height: AppTheme.space2),
                        Text(
                          l10n.wishEmptyHint,
                          style: GoogleFonts.dmSans(
                            fontSize: 14,
                            color: AppTheme.warmGray,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              else ...[
                if (_isGridView)
                  SliverPadding(
                    padding: const EdgeInsets.all(AppTheme.space4),
                    sliver: SliverGrid(
                      delegate: SliverChildBuilderDelegate((context, index) {
                        final item = items[index];
                        return _buildGridCard(context, item);
                      }, childCount: items.length),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: AppTheme.space4,
                            mainAxisSpacing: AppTheme.space4,
                            childAspectRatio: 0.75,
                          ),
                    ),
                  )
                else
                  SliverPadding(
                    padding: const EdgeInsets.all(AppTheme.space4),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate((context, index) {
                        final item = items[index];
                        return Padding(
                          padding: const EdgeInsets.only(
                            bottom: AppTheme.space4,
                          ),
                          child: _buildListCard(context, item),
                        );
                      }, childCount: items.length),
                    ),
                  ),
                const SliverToBoxAdapter(
                  child: SizedBox(height: AppTheme.space12),
                ),
              ],
            ],
          );
        },
      ),
    );
  }

  Widget _buildGridCard(BuildContext context, WishlistItem item) {
    final l10n = AppLocalizations.of(context);
    return PremiumCard(
      padding: EdgeInsets.zero,
      onTap: () => _openItem(context, item),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(AppTheme.radiusLg),
                topRight: Radius.circular(AppTheme.radiusLg),
              ),
              child:
                  item.image != null
                      ? AuthenticatedCachedImage(
                        imageUrl: item.image!,
                        fit: BoxFit.cover,
                        placeholder:
                            (context, url) => _buildImageFallback(item),
                        errorWidget:
                            (context, url, error) => _buildImageFallback(item),
                      )
                      : _buildImageFallback(item),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(AppTheme.space3),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        item.name,
                        style: GoogleFonts.playfairDisplay(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                if (item.type == 'country') ...[
                  const SizedBox(height: 2),
                  Text(
                    l10n.wishCountryBadge,
                    style: GoogleFonts.dmSans(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: Colors.red,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ] else if (item.categoryName != null) ...[
                  const SizedBox(height: 2),
                  Text(
                    categoryLabel(item.categoryName!, l10n),
                    style: GoogleFonts.dmSans(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppTheme.space3),
            child: Row(
              children: [
                const Spacer(),
                GestureDetector(
                  onTap: () => _confirmRemove(context, item),
                  child: Icon(
                    Icons.delete_outline,
                    size: 20,
                    color: Colors.red.withValues(alpha: 0.7),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppTheme.space2),
        ],
      ),
    );
  }

  Widget _buildListCard(BuildContext context, WishlistItem item) {
    final l10n = AppLocalizations.of(context);
    return PremiumCard(
      padding: EdgeInsets.zero,
      onTap: () => _openItem(context, item),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(AppTheme.radiusLg),
              bottomLeft: Radius.circular(AppTheme.radiusLg),
            ),
            child:
                item.image != null
                    ? AuthenticatedCachedImage(
                      imageUrl: item.image!,
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                      placeholder:
                          (context, url) => _buildListImageFallback(item),
                      errorWidget:
                          (context, url, error) =>
                              _buildListImageFallback(item),
                    )
                    : _buildListImageFallback(item),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(AppTheme.space3),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          item.name,
                          style: GoogleFonts.playfairDisplay(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  if (item.type == 'country') ...[
                    const SizedBox(height: 2),
                    Text(
                      l10n.wishCountryBadge,
                      style: GoogleFonts.dmSans(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: Colors.red,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ] else if (item.categoryName != null) ...[
                    const SizedBox(height: 2),
                    Text(
                      categoryLabel(item.categoryName!, l10n),
                      style: GoogleFonts.dmSans(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                  const SizedBox(height: AppTheme.space2),
                  Row(
                    children: [
                      const Spacer(),
                      GestureDetector(
                        onTap: () => _confirmRemove(context, item),
                        child: Icon(
                          Icons.delete_outline,
                          size: 20,
                          color: Colors.red.withValues(alpha: 0.7),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _openItem(BuildContext context, WishlistItem item) async {
    if (item.type == 'country' && item.countryId != null) {
      final country =
          CountryService.getAllCountries()
              .where((c) => c.countryId == item.countryId)
              .firstOrNull;
      if (country != null) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CountryPage(country: country),
          ),
        );
      }
      return;
    }
    if (item.type == 'place' && item.placeId != null) {
      final place = await PlaceService.getPlaceById(item.placeId!);
      if (!context.mounted) return;
      if (place == null) {
        showAppSnackBar(context, 'Place not available');
        return;
      }
      if (CountryService.getAllCountries().isEmpty) {
        await CountryService.loadCountries();
      }
      String cityName = CountryService.cityName(place.cityId) ?? '';
      String countryName = '';
      for (final c in CountryService.getAllCountries()) {
        if (c.cityPins.any((p) => p.cityId == place.cityId)) {
          countryName = c.name;
          if (cityName.isEmpty) {
            final pin =
                c.cityPins.where((p) => p.cityId == place.cityId).firstOrNull;
            if (pin != null) cityName = pin.name;
          }
          break;
        }
      }
      final categoryName = item.categoryName ?? place.categoryName ?? '';
      if (!context.mounted) return;
      Navigator.push(
        context,
        MaterialPageRoute(
          builder:
              (context) => PlaceDetailsPage(
                place: place,
                categoryName: categoryName,
                cityName: cityName,
                countryName: countryName,
              ),
        ),
      );
    }
  }

  Widget _buildImageFallback(WishlistItem item) {
    return Container(
      color: AppTheme.primary.withValues(alpha: 0.1),
      child: Center(
        child: Text(
          item.name.isNotEmpty ? item.name[0].toUpperCase() : '?',
          style: GoogleFonts.playfairDisplay(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: AppTheme.primary.withValues(alpha: 0.5),
          ),
        ),
      ),
    );
  }

  Widget _buildListImageFallback(WishlistItem item) {
    return Container(
      width: 100,
      height: 100,
      color: AppTheme.primary.withValues(alpha: 0.1),
      child: Center(
        child: Text(
          item.name.isNotEmpty ? item.name[0].toUpperCase() : '?',
          style: GoogleFonts.playfairDisplay(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppTheme.primary.withValues(alpha: 0.5),
          ),
        ),
      ),
    );
  }

  Future<void> _confirmRemove(BuildContext context, WishlistItem item) async {
    final l10n = AppLocalizations.of(context);
    final confirmed = await showAppConfirmDialog(
      context,
      title: l10n.wishRemoveTitle,
      content: l10n.wishRemoveText(item.name),
      confirmText: l10n.journalRemoveShort,
      cancelText: l10n.commonCancel,
      confirmColor: Colors.red,
    );
    if (confirmed == true) {
      await WishlistService.removeItem(item.wishlistId);
      if (!mounted) return;
      if (context.mounted) {
        showAppSnackBar(context, l10n.wishlistRemoved(item.name));
      }
    }
  }
}
