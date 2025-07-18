import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
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
  Future<void> _handleOfflineFallback() async {
    final continuar = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Text(_language == 'es' ? 'Sin conexión' : 'No Connection'),
          content: Text(_language == 'es'
              ? 'No se pudo conectar a internet.\n¿Deseas continuar en modo sin conexión?'
              : 'Internet connection failed.\nDo you want to continue in offline mode?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text(_language == 'es' ? 'Cancelar' : 'Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text(_language == 'es' ? 'Continuar' : 'Continue'),
            ),
          ],
        );
      },
    );

    if (continuar == true) {
      final prefs = await SharedPreferences.getInstance();
      final lastQuote = prefs.getString('last_quote') ?? '';
      final lastAuthor = prefs.getString('last_author') ?? '';
      setState(() {
        _quote = lastQuote;
        _author = lastAuthor;
      });
    }
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
  final url = Uri.parse('https://zenquotes.io/api/today');
  try {
    final response = await http.get(url).timeout(const Duration(seconds: 5));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final quote = data[0]['q'];
      final author = data[0]['a'];
      setState(() {
        _quote = quote;
        _author = author;
      });
      await saveQuote(quote, author);
    } else {
      await _handleOfflineFallback();
    }
  } catch (e) {
    await _handleOfflineFallback();
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
                    final textToShare = '''
                      ✨ ${_language == 'es' ? 'Una cita inspiradora desde QuickQuotes:' : 'An inspiring quote from QuickQuotes:'}

                      "$_quote"
                      — $_author

                      ${_language == 'es' 
                        ? '📱 Descárgala en tu móvil y guarda tus citas favoritas.' 
                        : '📱 Save and discover more quotes in your mobile.'}
                      ''';

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
