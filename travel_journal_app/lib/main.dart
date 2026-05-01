import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travel_journal_app/screens/splash_screen.dart';
import 'package:travel_journal_app/screens/login_screen.dart';
import 'package:travel_journal_app/screens/register_screen.dart';
import 'package:travel_journal_app/screens/home_screen.dart';
import 'package:travel_journal_app/screens/trips_screen.dart';
import 'package:travel_journal_app/screens/new_trip_screen.dart';
import 'package:travel_journal_app/screens/trip_plan_screen.dart';
import 'package:travel_journal_app/screens/journal_screen.dart';
import 'package:travel_journal_app/screens/journal_editor_screen.dart';
import 'package:travel_journal_app/screens/wishlist_screen.dart';
import 'package:travel_journal_app/screens/profile_screen.dart';
import 'package:travel_journal_app/services/wishlist_service.dart';
import 'package:travel_journal_app/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await WishlistService.loadItems();
  runApp(const TravelJournalApp());
}

class TravelJournalApp extends StatelessWidget {
  const TravelJournalApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RinMap - Travel Journal',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/home': (context) => const MainScreen(),
        '/new-trip': (context) => const NewTripScreen(),
        '/trip-plan': (context) => TripPlanScreen(
              tripId: ModalRoute.of(context)!.settings.arguments as String,
            ),
        '/journal-editor': (context) => JournalEditorScreen(
              chapterId: ModalRoute.of(context)?.settings.arguments as String?,
            ),
      },
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = const [
    HomeScreen(),
    TripsScreen(),
    JournalScreen(),
    WishListScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.bg,
      extendBody: true,
      body: _screens[_selectedIndex],
      bottomNavigationBar: Container(
        margin: const EdgeInsets.fromLTRB(
            AppTheme.space4, 0, AppTheme.space4, AppTheme.space4),
        decoration: BoxDecoration(
          color: AppTheme.card.withValues(alpha: 0.95),
          borderRadius: BorderRadius.circular(AppTheme.radiusLg),
          boxShadow: AppTheme.shadowLg,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(AppTheme.radiusLg),
          child: NavigationBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            height: 64,
            selectedIndex: _selectedIndex,
            onDestinationSelected: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            indicatorColor: AppTheme.primary.withValues(alpha: 0.1),
            labelTextStyle: WidgetStatePropertyAll(
              GoogleFonts.dmSans(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: AppTheme.warmGray,
              ),
            ),
            destinations: [
              NavigationDestination(
                icon: Icon(Icons.home_outlined,
                    color: AppTheme.warmGray, size: 24),
                selectedIcon:
                    Icon(Icons.home, color: AppTheme.primary, size: 24),
                label: 'Home',
              ),
              NavigationDestination(
                icon: Icon(Icons.luggage_outlined,
                    color: AppTheme.warmGray, size: 24),
                selectedIcon:
                    Icon(Icons.luggage, color: AppTheme.primary, size: 24),
                label: 'Trips',
              ),
              NavigationDestination(
                icon: Icon(Icons.book_outlined,
                    color: AppTheme.warmGray, size: 24),
                selectedIcon:
                    Icon(Icons.book, color: AppTheme.primary, size: 24),
                label: 'Journal',
              ),
              NavigationDestination(
                icon: Icon(Icons.bookmark_border_outlined,
                    color: AppTheme.warmGray, size: 24),
                selectedIcon: Icon(Icons.bookmark,
                    color: AppTheme.primary, size: 24),
                label: 'Wish List',
              ),
              NavigationDestination(
                icon: Icon(Icons.person_outline,
                    color: AppTheme.warmGray, size: 24),
                selectedIcon:
                    Icon(Icons.person, color: AppTheme.primary, size: 24),
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
