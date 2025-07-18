import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:share_plus/share_plus.dart';

import '../providers/quote_provider.dart';
import '../widgets/app_drawer.dart';

class QuoteHistoryScreen extends StatefulWidget {
  const QuoteHistoryScreen({super.key});

  @override
  State<QuoteHistoryScreen> createState() => _QuoteHistoryScreenState();
}

class _QuoteHistoryScreenState extends State<QuoteHistoryScreen> {
  String _language = 'es';

  @override
  void initState() {
    super.initState();
    loadLanguage();
  }

  Future<void> loadLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _language = prefs.getString('language') ?? 'es';
    });
  }

  @override
  Widget build(BuildContext context) {
    final quoteProvider = Provider.of<QuoteProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(_language == 'es' ? 'Historial de citas' : 'Quote History'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_forever),
            onPressed: () async {
              await quoteProvider.clearHistory();
              if (mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      _language == 'es'
                          ? 'Historial eliminado'
                          : 'History cleared',
                    ),
                  ),
                );
              }
            },
          )
        ],
      ),
      drawer: AppDrawer(),
      body: quoteProvider.history.isEmpty
          ? Center(
              child: Text(
                _language == 'es'
                    ? 'No hay citas guardadas aún.'
                    : 'No saved quotes yet.',
              ),
            )
          : ListView.builder(
            itemCount: quoteProvider.history.length,
            itemBuilder: (context, index) {
              final quote = quoteProvider.history[index];
              return Card(
                key: ValueKey(quote.id), // ✅ clave única por cita
                child: ListTile(
                  title: Text('"${quote.quote}"'),
                  subtitle: Text('— ${quote.author}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.share),
                    onPressed: () {
                      Share.share('"${quote.quote}"\n— ${quote.author}');
                    },
                  ),
                ),
              );
            },
          )
    );
  }
}
