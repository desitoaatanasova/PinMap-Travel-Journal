import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travel_journal_app/models/city_category.dart';
import 'package:travel_journal_app/screens/category_page.dart';
import 'package:travel_journal_app/widgets/section_header.dart';
import 'package:travel_journal_app/theme/app_theme.dart';

class CityPage extends StatelessWidget {
  final String cityName;
  final String countryName;

  const CityPage({
    super.key,
    required this.cityName,
    required this.countryName,
  });

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
      appBar: AppBar(
        title: Text(
          cityName,
          style: GoogleFonts.playfairDisplay(
            fontSize: 22,
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
            padding: const EdgeInsets.symmetric(horizontal: AppTheme.space4),
            child: SectionHeader(title: 'Categories'),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(AppTheme.space4),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: AppTheme.space4,
                  mainAxisSpacing: AppTheme.space4,
                ),
                itemCount: _categories.length,
                itemBuilder: (context, index) {
                  final cat = _categories[index];
                  return Container(
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
                              builder: (context) => CategoryPage(
                                categoryName: cat.name,
                                cityName: cityName,
                                countryName: countryName,
                              ),
                            ),
                          );
                        },
                        borderRadius: BorderRadius.circular(AppTheme.radiusLg),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(AppTheme.radiusLg),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  color: cat.color.withValues(alpha: 0.1),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(cat.icon,
                                    size: 30, color: cat.color),
                              ),
                              const SizedBox(height: AppTheme.space3),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: AppTheme.space3),
                                child: Text(
                                  cat.name,
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.dmSans(
                                    color: cat.color,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
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
          ),
        ],
      ),
    );
  }
}
