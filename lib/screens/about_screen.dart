import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/app_drawer.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
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
    return Scaffold(
      appBar: AppBar(
        title: Text(_language == 'es' ? 'Acerca de' : 'About'),
      ),
      drawer: AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            ListTile(
              title: Text(_language == 'es' ? 'QuickQuotes' : 'QuickQuotes'),
              subtitle: const Text('Versión 1.0.0'),
              leading: const Icon(Icons.info_outline),
            ),
            const Divider(),
            ListTile(
              title: Text(_language == 'es' ? 'Desarrollado por' : 'Developed by'),
              subtitle: const Text('Daniel Arias Silva (@das)'),
              leading: const Icon(Icons.person),
            ),
            const Divider(),
            ListTile(
              title: Text(_language == 'es' ? 'Descripción' : 'Description'),
              subtitle: Text(
                _language == 'es'
                    ? 'App educativa de prueba de conceptos desarrollada en Flutter. Permite consultar y compartir citas motivacionales de figuras públicas.'
                    : 'Educational proof-of-concept app built with Flutter. Lets you explore and share motivational quotes from public figures.',
              ),
              leading: const Icon(Icons.description),
            ),
            const Divider(),
            ListTile(
              title: Text(_language == 'es' ? 'API utilizada' : 'API used'),
              subtitle: const Text('ZenQuotes.io — https://zenquotes.io'),
              leading: const Icon(Icons.api),
            ),
          ],
        ),
      ),
    );
  }
}
