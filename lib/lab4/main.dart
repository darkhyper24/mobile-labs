import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home_screen.dart';
import 'settings_screen.dart';

void main() {
  runApp(const NewsReaderApp());
}

class NewsReaderApp extends StatefulWidget {
  const NewsReaderApp({super.key});

  @override
  State<NewsReaderApp> createState() => _NewsReaderAppState();
}

class _NewsReaderAppState extends State<NewsReaderApp> {
  bool _darkMode = false;

  @override
  void initState() {
    super.initState();
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _darkMode = prefs.getBool('darkMode') ?? false;
    });
  }

  void toggleTheme(bool isDark) {
    setState(() {
      _darkMode = isDark;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'News Reader',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
        brightness: Brightness.dark,
      ),
      themeMode: _darkMode ? ThemeMode.dark : ThemeMode.light,
      home: MainScreen(onThemeChanged: toggleTheme),
    );
  }
}

class MainScreen extends StatefulWidget {
  final Function(bool) onThemeChanged;
  
  const MainScreen({super.key, required this.onThemeChanged});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> _screens = [
      const HomeScreen(),
      SettingsScreen(onThemeChanged: widget.onThemeChanged),
    ];

    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}