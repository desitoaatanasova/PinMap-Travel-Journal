import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travel_journal_app/models/place.dart';
import 'package:travel_journal_app/services/place_service.dart';
import 'package:travel_journal_app/screens/place_details_page.dart';
import 'package:travel_journal_app/widgets/section_header.dart';
import 'package:travel_journal_app/theme/app_theme.dart';

class CategoryPage extends StatefulWidget {
  final String categoryName;
  final String cityName;
  final String countryName;

  const CategoryPage({
    super.key,
    required this.categoryName,
    required this.cityName,
    required this.countryName,
  });

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  final Set<String> _visitedPlaces = {};

  void _toggleVisited(String placeName) {
    setState(() {
      if (_visitedPlaces.contains(placeName)) {
        _visitedPlaces.remove(placeName);
      } else {
        _visitedPlaces.add(placeName);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final places = PlaceService.getPlacesForCategory(
        widget.categoryName, widget.cityName);

    return Scaffold(
      backgroundColor: AppTheme.bg,
      extendBody: true,
      appBar: AppBar(
        title: Text(
          widget.categoryName,
          style: GoogleFonts.playfairDisplay(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: AppTheme.darkBrown,
          ),
        ),
        backgroundColor: AppTheme.bg.withValues(alpha: 0.8),
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(
                AppTheme.space4, AppTheme.space4, AppTheme.space4, AppTheme.space2),
            child: Text(
              '${widget.cityName}, ${widget.countryName}',
              style: GoogleFonts.dancingScript(
                fontSize: 18,
                color: AppTheme.primary,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppTheme.space4),
            child: const SectionHeader(title: 'Places'),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(AppTheme.space4),
              itemCount: places.length,
              itemBuilder: (context, index) {
                final place = places[index];
                final isVisited = _visitedPlaces.contains(place.name);
                return _buildPlaceCard(context, place, isVisited);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlaceCard(
      BuildContext context, Place place, bool isVisited) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppTheme.space4),
      decoration: BoxDecoration(
        color: AppTheme.card,
        borderRadius: BorderRadius.circular(AppTheme.radiusLg),
        boxShadow: AppTheme.shadowMd,
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(AppTheme.radiusLg),
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PlaceDetailsPage(
                  place: place,
                  categoryName: widget.categoryName,
                  cityName: widget.cityName,
                  countryName: widget.countryName,
                ),
              ),
            );
          },
          borderRadius: BorderRadius.circular(AppTheme.radiusLg),
          child: Padding(
            padding: const EdgeInsets.all(AppTheme.space4),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildThumbnail(place),
                const SizedBox(width: AppTheme.space4),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              place.name,
                              style: GoogleFonts.playfairDisplay(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: AppTheme.darkBrown,
                              ),
                            ),
                          ),
                          if (isVisited)
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: AppTheme.space2,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.green.withValues(alpha: 0.15),
                                borderRadius:
                                    BorderRadius.circular(AppTheme.radiusFull),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.check_circle,
                                    size: 14,
                                    color: Colors.green,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    'Visited',
                                    style: GoogleFonts.dmSans(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.green,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: AppTheme.space1),
                      Text(
                        place.subtitle,
                        style: GoogleFonts.dmSans(
                          fontSize: 13,
                          color: AppTheme.warmGray,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: AppTheme.space2),
                      GestureDetector(
                        onTap: () => _toggleVisited(place.name),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppTheme.space3,
                            vertical: AppTheme.space1,
                          ),
                          decoration: BoxDecoration(
                            color: isVisited
                                ? Colors.green.withValues(alpha: 0.1)
                                : place.placeholderColor.withValues(alpha: 0.1),
                            borderRadius:
                                BorderRadius.circular(AppTheme.radiusFull),
                            border: Border.all(
                              color: isVisited
                                  ? Colors.green.withValues(alpha: 0.3)
                                  : place.placeholderColor
                                      .withValues(alpha: 0.3),
                              width: 1,
                            ),
                          ),
                          child: Text(
                            isVisited ? 'Visited' : 'Mark visited',
                            style: GoogleFonts.dmSans(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: isVisited
                                  ? Colors.green
                                  : place.placeholderColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildThumbnail(Place place) {
    if (place.imageUrls.isNotEmpty) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(AppTheme.radiusMd),
        child: Image.network(
          place.imageUrls[0],
          width: 80,
          height: 80,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stack) => _buildPlaceholder(place),
        ),
      );
    }
    return _buildPlaceholder(place);
  }

  Widget _buildPlaceholder(Place place) {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        color: place.placeholderColor.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(AppTheme.radiusMd),
      ),
      child: Icon(
        place.placeholderIcon,
        color: place.placeholderColor,
        size: 32,
      ),
    );
  }
}
