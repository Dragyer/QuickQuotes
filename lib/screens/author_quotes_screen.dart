import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../widgets/app_drawer.dart';

class AuthorQuotesScreen extends StatefulWidget {
  final String author;

  const AuthorQuotesScreen({super.key, required this.author});

  @override
  State<AuthorQuotesScreen> createState() => _AuthorQuotesScreenState();
}

class _AuthorQuotesScreenState extends State<AuthorQuotesScreen> {
  List<Map<String, String>> _quotes = [];
  bool _isLoading = true;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    fetchAuthorQuotes();
  }

  Future<void> fetchAuthorQuotes() async {
    final encodedAuthor = Uri.encodeComponent(widget.author);
    final url = Uri.parse('https://zenquotes.io/api/quotes/author/$encodedAuthor');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data is List) {
          setState(() {
            _quotes = List<Map<String, String>>.from(
              data.map((q) => {
                    'quote': q['q'],
                    'author': q['a'],
                  }),
            );
            _isLoading = false;
          });
        } else {
          setState(() {
            _hasError = true;
            _isLoading = false;
          });
        }
      } else {
        setState(() {
          _hasError = true;
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _hasError = true;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.author)),
      drawer: AppDrawer(),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _hasError
              ? Center(child: Text('Error al cargar citas.'))
              : _quotes.isEmpty
                  ? Center(child: Text('No se encontraron citas para este autor.'))
                  : ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: _quotes.length,
                      itemBuilder: (context, index) {
                        final q = _quotes[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          child: ListTile(
                            title: Text('"${q['quote']}"'),
                            subtitle: Text('— ${q['author']}'),
                          ),
                        );
                      },
                    ),
    );
  }
}
