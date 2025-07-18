import 'dart:convert';
import 'package:http/http.dart' as http;

class QuoteService {
  static const String baseUrl = 'https://zenquotes.io/api';

  static Future<Map<String, String>?> getQuoteOfTheDay() async {
    final url = Uri.parse('$baseUrl/today');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return {
          'quote': data[0]['q'],
          'author': data[0]['a'],
        };
      }
    } catch (e) {
      return null;
    }
    return null;
  }

  static Future<Map<String, String>?> getRandomQuote() async {
    final url = Uri.parse('$baseUrl/random');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return {
          'quote': data[0]['q'],
          'author': data[0]['a'],
        };
      }
    } catch (e) {
      return null;
    }
    return null;
  }

  static Future<List<Map<String, String>>> getQuoteList() async {
    final url = Uri.parse('$baseUrl/quotes');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return List<Map<String, String>>.from(
          data.map((q) => {
                'quote': q['q'],
                'author': q['a'],
              }),
        );
      }
    } catch (e) {
      return [];
    }
    return [];
  }
}
