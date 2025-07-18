import 'package:flutter/material.dart';
import '../db/quote_database_helper.dart';
import '../models/quote.dart';

class QuoteProvider with ChangeNotifier {
  List<QuoteModel> _history = [];

  List<QuoteModel> get history => _history;

  Future<void> loadQuotesFromDb() async {
    _history = await QuoteDatabaseHelper.instance.getAllQuotes();
    notifyListeners();
  }

  Future<void> addQuote(QuoteModel quote) async {
    await QuoteDatabaseHelper.instance.insertQuote(quote);
    await loadQuotesFromDb();
  }

  Future<void> clearHistory() async {
    await QuoteDatabaseHelper.instance.deleteAll();
    _history = [];
    notifyListeners();
  }
}
