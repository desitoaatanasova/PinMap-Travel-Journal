import 'package:flutter/material.dart';
import 'package:travel_journal_app/services/place_service.dart';
import 'package:travel_journal_app/screens/place_details_page.dart';

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
      appBar: AppBar(
        title: Text('$categoryName - $cityName'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: places.length,
        itemBuilder: (context, index) {
          final place = places[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              contentPadding: const EdgeInsets.all(12),
              leading: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: place.placeholderColor.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  place.placeholderIcon,
                  color: place.placeholderColor,
                  size: 30,
                ),
              ),
              title: Text(
                place.name,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              subtitle: Text(place.subtitle),
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
            ),
          );
        },
      ),
    );
  }
}
