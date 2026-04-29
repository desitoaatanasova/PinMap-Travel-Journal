import 'package:flutter/material.dart';
import 'package:travel_journal_app/models/city_category.dart';

class CityPage extends StatelessWidget {
  final String cityName;
  final String countryName;

  const CityPage({
    super.key,
    required this.cityName,
    required this.countryName,
  });

  final List<CityCategory> _categories = const [
    CityCategory(name: 'Historical sights', icon: Icons.account_balance, color: Colors.brown),
    CityCategory(name: 'For the art lovers', icon: Icons.palette, color: Colors.purple),
    CityCategory(name: 'Atmosphere & experience', icon: Icons.theater_comedy, color: Colors.orange),
    CityCategory(name: 'Hidden gems', icon: Icons.diamond, color: Colors.teal),
    CityCategory(name: 'Close by', icon: Icons.near_me, color: Colors.green),
    CityCategory(name: 'My places', icon: Icons.favorite, color: Colors.red),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(cityName),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemCount: _categories.length,
          itemBuilder: (context, index) {
            final cat = _categories[index];
            return Card(
              elevation: 4,
              child: InkWell(
                onTap: () {
                  // TODO: Handle category tap
                },
                borderRadius: BorderRadius.circular(12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(cat.icon, size: 48, color: cat.color),
                    const SizedBox(height: 12),
                    Text(
                      cat.name,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: cat.color,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
