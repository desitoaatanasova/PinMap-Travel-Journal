import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travel_journal_app/models/wishlist_item.dart';
import 'package:travel_journal_app/services/wishlist_service.dart';
import 'package:travel_journal_app/widgets/premium_card.dart';
import 'package:travel_journal_app/theme/app_theme.dart';

class WishListScreen extends StatefulWidget {
  const WishListScreen({super.key});

  @override
  State<WishListScreen> createState() => _WishListScreenState();
}

class _WishListScreenState extends State<WishListScreen> {
  bool _isGridView = true;
  late List<WishlistItem> _items;

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
    final grouped = WishlistService.getItemsByCountry();

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
            ...grouped.entries.map((entry) {
              final country = entry.key;
              final countryItems = entry.value;
              return [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: AppTheme.space4, vertical: AppTheme.space2),
                    child: Row(
                      children: [
                        Icon(
                          Icons.public,
                          size: 18,
                          color: AppTheme.primary,
                        ),
                        const SizedBox(width: AppTheme.space2),
                        Text(
                          country.toUpperCase(),
                          style: GoogleFonts.dmSans(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: AppTheme.primary,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                _isGridView
                    ? SliverGrid(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            final item = countryItems[index];
                            return _buildGridCard(context, item);
                          },
                          childCount: countryItems.length,
                        ),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: AppTheme.space4,
                          mainAxisSpacing: AppTheme.space4,
                          childAspectRatio: 0.75,
                        ),
                      )
                    : SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            final item = countryItems[index];
                            return _buildListCard(context, item);
                          },
                          childCount: countryItems.length,
                        ),
                      ),
                const SliverToBoxAdapter(
                  child: SizedBox(height: AppTheme.space4),
                ),
              ];
            }).expand((x) => x),
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
              child: item.imageUrl != null
                  ? Image.network(
                      item.imageUrl!,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stack) =>
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
                        item.name,
                        style: GoogleFonts.playfairDisplay(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppTheme.darkBrown,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (item.isVisited)
                      Icon(
                        Icons.check_circle,
                        size: 16,
                        color: Colors.green,
                      ),
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  '${item.city ?? ''}, ${item.country}',
                  style: GoogleFonts.dmSans(
                    fontSize: 11,
                    color: AppTheme.warmGray,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                if (item.category != null) ...[
                  const SizedBox(height: 2),
                  Text(
                    item.category!,
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
                if (item.isVisited)
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: AppTheme.space2, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.green.withValues(alpha: 0.1),
                      borderRadius:
                          BorderRadius.circular(AppTheme.radiusFull),
                    ),
                    child: Text(
                      'Visited',
                      style: GoogleFonts.dmSans(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: Colors.green,
                      ),
                    ),
                  ),
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
            child: item.imageUrl != null
                ? Image.network(
                    item.imageUrl!,
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stack) =>
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
                            color: AppTheme.darkBrown,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (item.isVisited)
                        Icon(
                          Icons.check_circle,
                          size: 18,
                          color: Colors.green,
                        ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '${item.city ?? ''}, ${item.country}',
                    style: GoogleFonts.dmSans(
                      fontSize: 12,
                      color: AppTheme.warmGray,
                    ),
                  ),
                  if (item.category != null) ...[
                    const SizedBox(height: 2),
                    Text(
                      item.category!,
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
                      if (item.isVisited)
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: AppTheme.space2, vertical: 2),
                          decoration: BoxDecoration(
                            color: Colors.green.withValues(alpha: 0.1),
                            borderRadius:
                                BorderRadius.circular(AppTheme.radiusFull),
                          ),
                          child: Text(
                            'Visited',
                            style: GoogleFonts.dmSans(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: Colors.green,
                            ),
                          ),
                        ),
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
          item.country.isNotEmpty ? item.country[0].toUpperCase() : '?',
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
          item.country.isNotEmpty ? item.country[0].toUpperCase() : '?',
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
          'Remove ${item.name} from your wishlist?',
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
      await WishlistService.removeItem(item.id);
      await _refresh();
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              '${item.name} removed from wishlist',
              style: GoogleFonts.dmSans(),
            ),
            duration: const Duration(seconds: 2),
          ),
        );
      }
    }
  }
}
