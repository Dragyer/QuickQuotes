import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quickquotes/screens/authors_screen.dart';

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

class QuickQuotesApp extends StatelessWidget {
  const QuickQuotesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QuickQuotes',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme, // Solo tema claro
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/preferences': (context) => const PreferencesScreen(),
        '/about': (context) => const AboutScreen(),
        '/library': (context) => const QuotesLibraryScreen(),
        '/history': (context) => const QuoteHistoryScreen(),
        '/authors': (context) => AuthorsScreen(),
      },
    );
  }
}
