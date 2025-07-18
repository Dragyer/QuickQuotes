class QuoteModel {
  final int? id;
  final String quote;
  final String author;

  QuoteModel({this.id, required this.quote, required this.author});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'quote': quote,
      'author': author,
    };
  }

  factory QuoteModel.fromMap(Map<String, dynamic> map) {
    return QuoteModel(
      id: map['id'],
      quote: map['quote'],
      author: map['author'],
    );
  }
}
