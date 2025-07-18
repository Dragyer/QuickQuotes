import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:share_plus/share_plus.dart';

import '../services/quote_service.dart';
import '../widgets/app_drawer.dart';

class QuotesLibraryScreen extends StatefulWidget {
  const QuotesLibraryScreen({super.key});

  @override
  State<QuotesLibraryScreen> createState() => _QuotesLibraryScreenState();
}

class _QuotesLibraryScreenState extends State<QuotesLibraryScreen> {
  String _randomQuote = '';
  String _randomAuthor = '';
  List<Map<String, String>> _quoteList = [];
  String _language = 'es';

  @override
  void initState() {
    super.initState();
    loadPreferences().then((_) {
      fetchRandomQuote();
      fetchQuoteList();
    });
  }

  Future<void> loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _language = prefs.getString('language') ?? 'es';
    });
  }

  Future<void> fetchRandomQuote() async {
    final result = await QuoteService.getRandomQuote();
    if (result != null) {
      setState(() {
        _randomQuote = result['quote']!;
        _randomAuthor = result['author']!;
      });
    } else {
      setState(() {
        _randomQuote = _language == 'es'
            ? 'Error de conexión'
            : 'Connection error';
        _randomAuthor = '';
      });
    }
  }

  Future<void> fetchQuoteList() async {
    List<Map<String, String>> quotes = [];
    for (int i = 0; i < 10; i++) {
      final result = await QuoteService.getRandomQuote();
      if (result != null) {
        quotes.add(result);
      }
      await Future.delayed(const Duration(milliseconds: 100));
    }
    setState(() {
      _quoteList = quotes;
    });
    print('Se cargaron ${_quoteList.length} citas aleatorias');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_language == 'es' ? 'Explorar citas' : 'Explore Quotes'),
      ),
      drawer: AppDrawer(),
      body: RefreshIndicator(
        onRefresh: () async {
          await fetchRandomQuote();
          await fetchQuoteList();
        },
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Text(
              _language == 'es' ? 'Cita aleatoria' : 'Random Quote',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '"$_randomQuote"',
                      style: const TextStyle(
                        fontSize: 18,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '— $_randomAuthor',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Align(
                      alignment: Alignment.centerRight,
                      child: IconButton(
                        icon: const Icon(Icons.share),
                        onPressed: () {
                          Share.share('"$_randomQuote"\n— $_randomAuthor');
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              _language == 'es' ? 'Lista de citas' : 'Quote List',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            ..._quoteList.map(
              (q) => Card(
                key: ValueKey(q['quote']),
                child: ListTile(
                  title: Text('"${q['quote']}"'),
                  subtitle: Text('— ${q['author']}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.share),
                    onPressed: () {
                      Share.share('"${q['quote']}"\n— ${q['author']}');
                    },
                  ),
                ),
              ),
            ).toList(),
          ],
        ),
      ),
    );
  }
}
