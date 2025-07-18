import 'package:flutter/material.dart';
import '../widgets/app_drawer.dart';
import 'author_quotes_screen.dart';

class AuthorsScreen extends StatelessWidget {
  final List<Map<String, String>> authors = [
    {'name': 'Albert Einstein', 'image': 'assets/images/einstein.jpg'},
    {'name': 'Benjamin Franklin', 'image': 'assets/images/franklin.jpg'},
    {'name': 'Barack Obama', 'image': 'assets/images/obama.jpg'},
    {'name': 'Ayn Rand', 'image': 'assets/images/ayn_rand.jpg'},
    {'name': 'Anne Frank', 'image': 'assets/images/anne_frank.jpg'},
  ];

  AuthorsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Autores')),
      drawer: AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.builder(
          itemCount: authors.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.9,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          itemBuilder: (context, index) {
            final author = authors[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => AuthorQuotesScreen(author: author['name']!),
                  ),
                );
              },
              child: Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 35,
                      backgroundImage: AssetImage(author['image']!),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      author['name']!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
