import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travel_journal_app/theme/app_theme.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String _selectedGender = 'Prefer not to say';

  final List<String> _genderOptions = [
    'Male',
    'Female',
    'Non-binary',
    'Prefer not to say',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.bg,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppTheme.space6),
          child: Column(
            children: [
              const SizedBox(height: AppTheme.space12),
              // Logo
              Container(
                padding: const EdgeInsets.all(AppTheme.space6),
                decoration: BoxDecoration(
                  color: AppTheme.card,
                  shape: BoxShape.circle,
                  boxShadow: AppTheme.shadowLg,
                ),
                child: Icon(
                  Icons.place,
                  size: 60,
                  color: AppTheme.primary,
                ),
              ),
              const SizedBox(height: AppTheme.space6),
              // Welcome text
              Text(
                'Create Account',
                style: GoogleFonts.playfairDisplay(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.darkBrown,
                ),
              ),
              const SizedBox(height: AppTheme.space2),
              Text(
                'Start your travel journal',
                style: GoogleFonts.dmSans(
                  fontSize: 14,
                  color: AppTheme.warmGray,
                ),
              ),
              const SizedBox(height: AppTheme.space8),
              // Registration Card
              Container(
                padding: const EdgeInsets.all(AppTheme.space6),
                decoration: BoxDecoration(
                  color: AppTheme.card,
                  borderRadius: BorderRadius.circular(AppTheme.radiusLg),
                  boxShadow: AppTheme.shadowMd,
                ),
                child: Column(
                  children: [
                    // Name field
                    TextField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                        hintText: 'Full Name',
                        prefixIcon: Icon(Icons.person_outline),
                      ),
                    ),
                    const SizedBox(height: AppTheme.space4),
                    // Email field
                    TextField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        hintText: 'Email',
                        prefixIcon: Icon(Icons.email_outlined),
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: AppTheme.space4),
                    // Password field
                    TextField(
                      controller: _passwordController,
                      decoration: const InputDecoration(
                        hintText: 'Password',
                        prefixIcon: Icon(Icons.lock_outline),
                      ),
                      obscureText: true,
                    ),
                    const SizedBox(height: AppTheme.space4),
                    // Gender dropdown
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: AppTheme.space4),
                      decoration: BoxDecoration(
                        color: AppTheme.card,
                        borderRadius:
                            BorderRadius.circular(AppTheme.radiusMd),
                        border: Border.all(color: AppTheme.lightGray),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: _selectedGender,
                          isExpanded: true,
                          icon: Icon(Icons.arrow_drop_down,
                              color: AppTheme.warmGray),
                          items: _genderOptions.map((String gender) {
                            return DropdownMenuItem<String>(
                              value: gender,
                              child: Text(
                                gender,
                                style: GoogleFonts.dmSans(
                                  color: AppTheme.darkBrown,
                                  fontSize: 14,
                                ),
                              ),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              _selectedGender = newValue!;
                            });
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: AppTheme.space6),
                    // Sign up button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          final name = _nameController.text;
                          final email = _emailController.text;
                          final password = _passwordController.text;
                          if (name.isNotEmpty &&
                              email.contains('@') &&
                              password.isNotEmpty) {
                            Navigator.of(context).pushNamedAndRemoveUntil(
                              '/home',
                              (route) => false,
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Please fill all required fields')),
                            );
                          }
                        },
                        child: const Text('Sign Up'),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppTheme.space6),
              // Login link
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have an account? ',
                    style: GoogleFonts.dmSans(
                      color: AppTheme.warmGray,
                      fontSize: 14,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Log In',
                      style: GoogleFonts.dmSans(
                        color: AppTheme.primary,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
