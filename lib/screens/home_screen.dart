import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:share_plus/share_plus.dart';
import 'package:provider/provider.dart';

import '../widgets/app_drawer.dart';
import '../services/quote_service.dart';
import '../models/quote.dart';
import '../providers/quote_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _quote = 'Cargando...';
  String _author = '';
  String _language = 'es';

  @override
  void initState() {
    super.initState();
    loadPreferences().then((_) => fetchQuote());
  }

  Future<void> loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _language = prefs.getString('language') ?? 'es';
      _quote = prefs.getString('last_quote') ?? 'Cargando...';
      _author = prefs.getString('last_author') ?? '';
    });
  }

  Future<void> saveQuote(String quote, String author) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('last_quote', quote);
    await prefs.setString('last_author', author);
  }

  Future<void> fetchQuote() async {
    final result = await QuoteService.getQuoteOfTheDay();
    if (result != null) {
      setState(() {
        _quote = result['quote']!;
        _author = result['author']!;
      });
      await saveQuote(_quote, _author);
      Provider.of<QuoteProvider>(context, listen: false).addQuote(
        QuoteModel(quote: _quote, author: _author),
      );
    } else {
      setState(() {
        _quote = _language == 'es'
            ? 'Error al obtener la cita'
            : 'Error retrieving quote';
      });
    }
  }

  String _getTodayDate() {
    final now = DateTime.now();
    return '${_getMonthName(now.month)} ${now.day}, ${now.year}';
  }

  String _getMonthName(int month) {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return months[month - 1];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QuickQuotes'),
      ),
      drawer: AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.spa, size: 48, color: Colors.indigo),
                const SizedBox(height: 10),
                Text(
                  _language == 'es' ? 'Cita del Día' : 'Quote of the Day',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
                Text(
                  _getTodayDate(),
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 30),
                Text(
                  '"$_quote"',
                  style: const TextStyle(
                    fontSize: 22,
                    fontStyle: FontStyle.italic,
                    height: 1.4,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                Text(
                  '— $_author',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 20),
                Text(
                  _language == 'es'
                      ? '(nueva cita disponible a las 00:00 UTC)'
                      : '(new quote generates at 00:00 UTC)',
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
                const SizedBox(height: 30),
                ElevatedButton.icon(
                  onPressed: () {
                    final textToShare = '"$_quote"\n— $_author';
                    Share.share(textToShare);
                  },
                  icon: const Icon(Icons.share),
                  label: Text(_language == 'es' ? 'Compartir' : 'Share'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
