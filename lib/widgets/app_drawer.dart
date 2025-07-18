import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({super.key});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
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
    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/bg_drawer.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: Text(
              'QuickQuotes',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontFamily: 'Georgia',
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: Text(_language == 'es' ? 'Inicio' : 'Home'),
            onTap: () => Navigator.pushReplacementNamed(context, '/'),
          ),
          ListTile(
            leading: const Icon(Icons.format_quote),
            title: Text(_language == 'es' ? 'Explorar citas' : 'Explore Quotes'),
            onTap: () => Navigator.pushReplacementNamed(context, '/library'),
          ),
          ListTile(
            leading: const Icon(Icons.history),
            title: Text(_language == 'es' ? 'Historial' : 'History'),
            onTap: () => Navigator.pushReplacementNamed(context, '/history'),
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: Text(_language == 'es' ? 'Preferencias' : 'Preferences'),
            onTap: () => Navigator.pushReplacementNamed(context, '/preferences'),
          ),
          ListTile(
            leading: const Icon(Icons.info),
            title: Text(_language == 'es' ? 'Acerca de' : 'About'),
            onTap: () => Navigator.pushReplacementNamed(context, '/about'),
          ),
        ],
      ),
    );
  }
}
