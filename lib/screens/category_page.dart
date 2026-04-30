import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travel_journal_app/services/place_service.dart';
import 'package:travel_journal_app/screens/place_details_page.dart';
import 'package:travel_journal_app/widgets/section_header.dart';
import 'package:travel_journal_app/theme/app_theme.dart';

class CategoryPage extends StatelessWidget {
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
  Widget build(BuildContext context) {
    final places = PlaceService.getPlacesForCategory(categoryName, cityName);

    return Scaffold(
      backgroundColor: AppTheme.bg,
      extendBody: true,
      appBar: AppBar(
        title: Text(
          categoryName,
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
              '$cityName, $countryName',
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
                              categoryName: categoryName,
                              cityName: cityName,
                              countryName: countryName,
                            ),
                          ),
                        );
                      },
                      borderRadius: BorderRadius.circular(AppTheme.radiusLg),
                      child: Padding(
                        padding: const EdgeInsets.all(AppTheme.space4),
                        child: Row(
                          children: [
                            Container(
                              width: 70,
                              height: 70,
                              decoration: BoxDecoration(
                                color: place.placeholderColor.withValues(alpha: 0.15),
                                borderRadius: BorderRadius.circular(AppTheme.radiusMd),
                              ),
                              child: Icon(
                                place.placeholderIcon,
                                color: place.placeholderColor,
                                size: 32,
                              ),
                            ),
                            const SizedBox(width: AppTheme.space4),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    place.name,
                                    style: GoogleFonts.playfairDisplay(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: AppTheme.darkBrown,
                                    ),
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
                                ],
                              ),
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 16,
                              color: AppTheme.warmGray,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
