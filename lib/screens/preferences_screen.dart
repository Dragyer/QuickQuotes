import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/app_drawer.dart';

class PreferencesScreen extends StatefulWidget {
  final Function(bool) onThemeChanged;

  const PreferencesScreen({super.key, required this.onThemeChanged});

  @override
  State<PreferencesScreen> createState() => _PreferencesScreenState();
}

class _PreferencesScreenState extends State<PreferencesScreen> {
  bool _isDarkMode = false;
  String _selectedLanguage = 'es';
  bool _soundEnabled = true;
  bool _rememberLastScreen = false;

  final List<Map<String, String>> _languages = [
    {'code': 'es', 'name': 'Español'},
    {'code': 'en', 'name': 'English'},
  ];

  @override
  void initState() {
    super.initState();
    loadPreferences();
  }

  Future<void> loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _isDarkMode = prefs.getBool('darkMode') ?? false;
      _selectedLanguage = prefs.getString('language') ?? 'es';
      _soundEnabled = prefs.getBool('soundEnabled') ?? true;
      _rememberLastScreen = prefs.getBool('rememberLastScreen') ?? false;
    });
  }

  Future<void> savePreferences() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('darkMode', _isDarkMode);
    await prefs.setString('language', _selectedLanguage);
    await prefs.setBool('soundEnabled', _soundEnabled);
    await prefs.setBool('rememberLastScreen', _rememberLastScreen);
    widget.onThemeChanged(_isDarkMode);
  }

  Future<void> resetPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    await loadPreferences();
    widget.onThemeChanged(false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_selectedLanguage == 'es' ? 'Preferencias' : 'Preferences')),
      drawer: AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            SwitchListTile(
              title: Text(_selectedLanguage == 'es' ? 'Tema oscuro' : 'Dark mode'),
              value: _isDarkMode,
              onChanged: (value) {
                setState(() => _isDarkMode = value);
                savePreferences();
              },
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Text(
                  _selectedLanguage == 'es' ? 'Idioma:' : 'Language:',
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(width: 10),
                DropdownButton<String>(
                  value: _selectedLanguage,
                  items: _languages
                      .map((lang) => DropdownMenuItem(
                            value: lang['code'],
                            child: Text(lang['name']!),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() => _selectedLanguage = value!);
                    savePreferences();
                  },
                )
              ],
            ),
            const Divider(height: 40),
            SwitchListTile(
              title: Text(_selectedLanguage == 'es' ? 'Activar sonido' : 'Enable sound'),
              value: _soundEnabled,
              onChanged: (value) {
                setState(() => _soundEnabled = value);
                savePreferences();
              },
            ),
            SwitchListTile(
              title: Text(_selectedLanguage == 'es' ? 'Recordar última pantalla' : 'Remember last screen'),
              value: _rememberLastScreen,
              onChanged: (value) {
                setState(() => _rememberLastScreen = value);
                savePreferences();
              },
            ),
            const SizedBox(height: 30),
            ElevatedButton.icon(
              icon: const Icon(Icons.refresh),
              label: Text(_selectedLanguage == 'es' ? 'Restablecer ajustes' : 'Reset settings'),
              onPressed: () => resetPreferences(),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.brown[300],
              ),
            )
          ],
        ),
      ),
    );
  }
}
