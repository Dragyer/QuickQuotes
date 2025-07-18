import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quickquotes/models/quote.dart';
import 'package:quickquotes/providers/quote_provider.dart';
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

      final provider = Provider.of<QuoteProvider>(context, listen: false);
      final newQuote = QuoteModel(
        quote: _randomQuote,
        author: _randomAuthor,
      );
      await provider.addQuote(newQuote);
    }
  }


  Future<void> fetchQuoteList() async {
    List<Map<String, String>> quotes = [];
    final provider = Provider.of<QuoteProvider>(context, listen: false);

    for (int i = 0; i < 10; i++) {
      final result = await QuoteService.getRandomQuote();
      if (result != null) {
        quotes.add(result);

        // Guardar en historial
        final newQuote = QuoteModel(
          quote: result['quote']!,
          author: result['author']!,
        );
        await provider.addQuote(newQuote);
      }
    }

    setState(() {
      _quoteList = quotes;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text(_language == 'es' ? 'Explorar citas' : 'Explore Quotes'),
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
              style:
                  const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '"$_randomQuote"',
                      style: const TextStyle(
                          fontSize: 18, fontStyle: FontStyle.italic),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '— $_randomAuthor',
                      style:
                          const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Align(
                      alignment: Alignment.centerRight,
                      child: IconButton(
                        icon: const Icon(Icons.share),
                        onPressed: () {
                          final textToShare = '''
                      ✨ ${_language == 'es' ? 'Una cita inspiradora desde QuickQuotes:' : 'An inspiring quote from QuickQuotes:'}

                      "$_randomQuote"
                      — $_randomAuthor

                      ${_language == 'es' 
                        ? '📱 Descárgala en tu móvil y guarda tus citas favoritas.' 
                        : '📱 Save and discover more quotes in your mobile.'}
                      ''';
                          Share.share(textToShare);
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
              style:
                  const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                      final textToShare = '''
                  ✨ ${_language == 'es' ? 'Una cita inspiradora desde QuickQuotes:' : 'An inspiring quote from QuickQuotes:'}

                  "${q['quote']}"
                  — ${q['author']}

                  ${_language == 'es' 
                    ? '📱 Descárgala en tu móvil y guarda tus citas favoritas.' 
                    : '📱 Save and discover more quotes in your mobile.'}
                  ''';
                      Share.share(textToShare);
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
