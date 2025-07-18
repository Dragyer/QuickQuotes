// === lib/main.dart ===

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'screens/home_screen.dart';
import 'screens/preferences_screen.dart';
import 'screens/about_screen.dart';
import 'screens/quotes_library_screen.dart';
import 'screens/quote_history_screen.dart';
import 'theme/app_theme.dart';
import 'providers/quote_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => QuoteProvider()..loadQuotesFromDb()),
      ],
      child: const QuickQuotesApp(),
    ),
  );
}

class QuickQuotesApp extends StatefulWidget {
  const QuickQuotesApp({super.key});

  @override
  State<QuickQuotesApp> createState() => _QuickQuotesAppState();
}

class _QuickQuotesAppState extends State<QuickQuotesApp> {
  ThemeMode _themeMode = ThemeMode.light;

  @override
  void initState() {
    super.initState();
    _loadThemePreference();
  }

  Future<void> _loadThemePreference() async {
    final prefs = await SharedPreferences.getInstance();
    final isDark = prefs.getBool('darkMode') ?? false;
    setState(() {
      _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    });
  }

  void _toggleTheme(bool isDarkMode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('darkMode', isDarkMode);
    setState(() {
      _themeMode = isDarkMode ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QuickQuotes',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: _themeMode,
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/preferences': (context) => PreferencesScreen(onThemeChanged: _toggleTheme),
        '/about': (context) => const AboutScreen(),
        '/library': (context) => const QuotesLibraryScreen(),
        '/history': (context) => const QuoteHistoryScreen(),
      },
    );
  }
}
