import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinmap_travel_journal/models/user_profile.dart';
import 'package:pinmap_travel_journal/screens/user_page_screen.dart';
import 'package:pinmap_travel_journal/services/social_service.dart';
import 'package:pinmap_travel_journal/theme/app_theme.dart';

class UserSearchScreen extends StatefulWidget {
  const UserSearchScreen({super.key});

  @override
  State<UserSearchScreen> createState() => _UserSearchScreenState();
}

class _UserSearchScreenState extends State<UserSearchScreen> {
  final TextEditingController _controller = TextEditingController();
  Timer? _debounce;
  List<UserProfile> _results = [];
  bool _loading = false;
  bool _searched = false;

  @override
  void dispose() {
    _debounce?.cancel();
    _controller.dispose();
    super.dispose();
  }

  void _onChanged(String value) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 400), () => _search(value));
  }

  Future<void> _search(String query) async {
    if (query.trim().isEmpty) {
      setState(() {
        _results = [];
        _searched = false;
        _loading = false;
      });
      return;
    }
    setState(() {
      _loading = true;
      _searched = true;
    });
    try {
      final results = await SocialService.searchUsers(query);
      if (!mounted) return;
      setState(() {
        _results = results;
        _loading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _results = [];
        _loading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Search failed', style: GoogleFonts.dmSans()),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.bg,
      appBar: AppBar(
        title: Text(
          'Find Travellers',
          style: GoogleFonts.playfairDisplay(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: AppTheme.darkBrown,
          ),
        ),
        backgroundColor: AppTheme.bg,
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(AppTheme.space4),
            child: TextField(
              controller: _controller,
              autofocus: true,
              onChanged: _onChanged,
              decoration: const InputDecoration(
                hintText: 'Search by username or name',
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(child: _buildResults()),
        ],
      ),
    );
  }

  Widget _buildResults() {
    if (_loading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (!_searched) {
      return const Center(
        child: Text(
          'Start typing to find other travellers',
          style: TextStyle(color: AppTheme.warmGray),
        ),
      );
    }
    if (_results.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.person_search,
              size: 64,
              color: AppTheme.warmGray.withValues(alpha: 0.3),
            ),
            const SizedBox(height: AppTheme.space3),
            Text(
              'No travellers found',
              style: GoogleFonts.dmSans(color: AppTheme.warmGray),
            ),
          ],
        ),
      );
    }
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: AppTheme.space4),
      itemCount: _results.length,
      itemBuilder: (context, index) {
        final user = _results[index];
        return Card(
          margin: const EdgeInsets.only(bottom: AppTheme.space2),
          child: ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UserPageScreen(user: user),
                ),
              );
            },
            leading: CircleAvatar(
              backgroundColor: AppTheme.card,
              backgroundImage: user.profilePicture != null
                  ? NetworkImage(user.profilePicture!)
                  : null,
              child: user.profilePicture == null
                  ? Text(
                      user.username.isNotEmpty
                          ? user.username[0].toUpperCase()
                          : '?',
                      style: GoogleFonts.playfairDisplay(
                        color: AppTheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  : null,
            ),
            title: Text(
              user.displayName,
              style: GoogleFonts.dmSans(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: AppTheme.darkBrown,
              ),
            ),
            subtitle: Text(
              '@${user.username}',
              style: GoogleFonts.dmSans(
                fontSize: 12,
                color: AppTheme.warmGray,
              ),
            ),
            trailing: Icon(
              Icons.chevron_right,
              color: AppTheme.warmGray.withValues(alpha: 0.5),
            ),
          ),
        );
      },
    );
  }
}
