import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:pinmap_travel_journal/models/wishlist_item.dart';
import 'package:pinmap_travel_journal/services/wishlist_service.dart';
import 'package:pinmap_travel_journal/widgets/premium_card.dart';
import 'package:pinmap_travel_journal/theme/app_theme.dart';

class WishListScreen extends StatefulWidget {
  const WishListScreen({super.key});

  @override
  State<WishListScreen> createState() => _WishListScreenState();
}

class _WishListScreenState extends State<WishListScreen> {
  bool _isGridView = true;
  List<WishlistItem> _items = [];

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    await WishlistService.loadItems();
    setState(() {
      _items = WishlistService.getAllItems();
    });
  }

  Future<void> _refresh() async {
    setState(() {
      _items = WishlistService.getAllItems();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.bg,
      extendBody: true,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 120,
            pinned: true,
            backgroundColor: AppTheme.bg,
            elevation: 0,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                'Wish List',
                style: GoogleFonts.playfairDisplay(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.darkBrown,
                ),
              ),
              titlePadding: const EdgeInsets.only(
                  left: AppTheme.space4, bottom: AppTheme.space4),
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
          if (_items.isEmpty)
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
                      'No saved destinations',
                      style: GoogleFonts.playfairDisplay(
                        fontSize: 20,
                        color: AppTheme.warmGray,
                      ),
                    ),
                    const SizedBox(height: AppTheme.space2),
                    Text(
                      'Tap the heart icon on places to save them',
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
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final item = _items[index];
                      return _buildGridCard(context, item);
                    },
                    childCount: _items.length,
                  ),
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
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final item = _items[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: AppTheme.space4),
                        child: _buildListCard(context, item),
                      );
                    },
                    childCount: _items.length,
                  ),
                ),
              ),
            const SliverToBoxAdapter(
              child: SizedBox(height: AppTheme.space12),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildGridCard(BuildContext context, WishlistItem item) {
    return PremiumCard(
      padding: EdgeInsets.zero,
      onTap: () {},
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(AppTheme.radiusLg),
                topRight: Radius.circular(AppTheme.radiusLg),
              ),
              child: item.placeImage != null
                  ? CachedNetworkImage(
                      imageUrl: item.placeImage!,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => _buildImageFallback(item),
                      errorWidget: (context, url, error) =>
                          _buildImageFallback(item),
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
                        item.placeName,
                        style: GoogleFonts.playfairDisplay(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppTheme.darkBrown,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                if (item.categoryName != null) ...[
                  const SizedBox(height: 2),
                  Text(
                    item.categoryName!,
                    style: GoogleFonts.dmSans(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.primary,
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
    return PremiumCard(
      padding: EdgeInsets.zero,
      onTap: () {},
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(AppTheme.radiusLg),
              bottomLeft: Radius.circular(AppTheme.radiusLg),
            ),
            child: item.placeImage != null
                ? CachedNetworkImage(
                    imageUrl: item.placeImage!,
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                    placeholder: (context, url) =>
                        _buildListImageFallback(item),
                    errorWidget: (context, url, error) =>
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
                          item.placeName,
                          style: GoogleFonts.playfairDisplay(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: AppTheme.darkBrown,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  if (item.categoryName != null) ...[
                    const SizedBox(height: 2),
                    Text(
                      item.categoryName!,
                      style: GoogleFonts.dmSans(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.primary,
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

  Widget _buildImageFallback(WishlistItem item) {
    return Container(
      color: AppTheme.primary.withValues(alpha: 0.1),
      child: Center(
        child: Text(
          item.placeName.isNotEmpty
              ? item.placeName[0].toUpperCase()
              : '?',
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
          item.placeName.isNotEmpty
              ? item.placeName[0].toUpperCase()
              : '?',
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
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Remove from Wishlist',
          style: GoogleFonts.playfairDisplay(
            color: AppTheme.darkBrown,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          'Remove ${item.placeName} from your wishlist?',
          style: GoogleFonts.dmSans(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(
              'Cancel',
              style: GoogleFonts.dmSans(color: AppTheme.warmGray),
            ),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: Text(
              'Remove',
              style: GoogleFonts.dmSans(),
            ),
          ),
        ],
      ),
    );
    if (confirmed == true) {
      await WishlistService.removeItem(item.wishlistId);
      await _refresh();
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              '${item.placeName} removed from wishlist',
              style: GoogleFonts.dmSans(),
            ),
            duration: const Duration(seconds: 2),
          ),
        );
      }
    }
  }
}
