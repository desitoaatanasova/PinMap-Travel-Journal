import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travel_journal_app/models/city_category.dart';
import 'package:travel_journal_app/models/wishlist_item.dart';
import 'package:travel_journal_app/screens/category_page.dart';
import 'package:travel_journal_app/services/wishlist_service.dart';
import 'package:travel_journal_app/widgets/section_header.dart';
import 'package:travel_journal_app/theme/app_theme.dart';

class CityPage extends StatefulWidget {
  final String cityName;
  final String countryName;

  const CityPage({
    super.key,
    required this.cityName,
    required this.countryName,
  });

  @override
  State<CityPage> createState() => _CityPageState();
}

class _CityPageState extends State<CityPage> {
  bool _isInWishlist = false;

  @override
  void initState() {
    super.initState();
    _isInWishlist =
        WishlistService.isInWishlist('${widget.countryName}-${widget.cityName}');
  }

  Future<void> _toggleWishlist() async {
    final id = '${widget.countryName}-${widget.cityName}';
    if (_isInWishlist) {
      await WishlistService.removeItem(id);
    } else {
      await WishlistService.addItem(WishlistItem(
        id: id,
        name: widget.cityName,
        country: widget.countryName,
        city: widget.cityName,
        type: 'city',
      ));
    }
    setState(() {
      _isInWishlist = !_isInWishlist;
    });
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            _isInWishlist
                ? '${widget.cityName} added to wishlist'
                : '${widget.cityName} removed from wishlist',
            style: GoogleFonts.dmSans(),
          ),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  final List<CityCategory> _categories = const [
    CityCategory(
      name: 'Historical sights',
      icon: Icons.account_balance,
      color: Color(0xFF8B4513),
      pinColor: Color(0xFF8B4513),
    ),
    CityCategory(
      name: 'For the art lovers',
      icon: Icons.palette,
      color: Color(0xFF008080),
      pinColor: Color(0xFF008080),
    ),
    CityCategory(
      name: 'Atmosphere & experience',
      icon: Icons.visibility,
      color: Color(0xFFDAA520),
      pinColor: Color(0xFFDAA520),
    ),
    CityCategory(
      name: 'Hidden gems',
      icon: Icons.star,
      color: Color(0xFF8A2BE2),
      pinColor: Color(0xFF8A2BE2),
    ),
    CityCategory(
      name: 'Close by',
      icon: Icons.explore,
      color: Color(0xFF228B22),
      pinColor: Color(0xFF228B22),
    ),
    CityCategory(
      name: 'My places',
      icon: Icons.favorite,
      color: Color(0xFFDC143C),
      pinColor: Color(0xFFDC143C),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.bg,
      extendBody: true,
      body: CustomScrollView(
        slivers: [
          _buildSliverAppBar(context),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                  AppTheme.space4, AppTheme.space4, AppTheme.space4, AppTheme.space2),
              child: SectionHeader(
                title: 'What to discover',
                color: AppTheme.darkBrown,
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(AppTheme.space4),
            sliver: SliverGrid(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final cat = _categories[index];
                  return _buildCategoryCard(context, cat);
                },
                childCount: _categories.length,
              ),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: AppTheme.space4,
                mainAxisSpacing: AppTheme.space4,
                childAspectRatio: 0.85,
              ),
            ),
          ),
        ],
      ),
    );
  }

  SliverAppBar _buildSliverAppBar(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 260,
      pinned: true,
      backgroundColor: AppTheme.darkBrown,
      iconTheme: const IconThemeData(color: Colors.white),
      actions: [
        IconButton(
          icon: Icon(
            _isInWishlist ? Icons.favorite : Icons.favorite_border,
            color: _isInWishlist ? Colors.redAccent : Colors.white,
          ),
          onPressed: _toggleWishlist,
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(
              'https://source.unsplash.com/800x400/?${widget.cityName},city',
              fit: BoxFit.cover,
              errorBuilder: (context, error, stack) => Container(
                color: AppTheme.darkBrown,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withValues(alpha: 0.6),
                    Colors.black.withValues(alpha: 0.85),
                  ],
                ),
              ),
            ),
            Positioned(
              left: AppTheme.space4,
              right: AppTheme.space4,
              bottom: AppTheme.space6,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.cityName,
                    style: GoogleFonts.playfairDisplay(
                      fontSize: 34,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      height: 1.1,
                    ),
                  ),
                  const SizedBox(height: AppTheme.space1),
                  Text(
                    widget.countryName,
                    style: GoogleFonts.dancingScript(
                      fontSize: 18,
                      color: AppTheme.warmGray,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryCard(BuildContext context, CityCategory cat) {
    return Container(
      decoration: BoxDecoration(
        color: cat.color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(AppTheme.radiusLg),
        border: Border.all(
          color: cat.color.withValues(alpha: 0.3),
          width: 1.5,
        ),
        boxShadow: AppTheme.shadowSm,
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(AppTheme.radiusLg),
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CategoryPage(
                  categoryName: cat.name,
                  cityName: widget.cityName,
                  countryName: widget.countryName,
                ),
              ),
            );
          },
          borderRadius: BorderRadius.circular(AppTheme.radiusLg),
          child: Padding(
            padding: const EdgeInsets.all(AppTheme.space4),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    color: cat.color.withValues(alpha: 0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    cat.icon,
                    size: 32,
                    color: cat.color,
                  ),
                ),
                const SizedBox(height: AppTheme.space3),
                Text(
                  cat.name,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.dmSans(
                    color: cat.color,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    height: 1.3,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
