import 'package:aurora/pages/Anime/streaming_page.dart';
import 'package:aurora/pages/Manga/details_page.dart';
import 'package:aurora/pages/Manga/home_page.dart';
import 'package:aurora/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:aurora/pages/Anime/home_page.dart';
import 'package:aurora/pages/Anime/details_page.dart';
import 'package:aurora/theme/theme.dart';
import 'package:crystal_navigation_bar/crystal_navigation_bar.dart';
import 'package:iconly/iconly.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  int _selectedIndex = 2;

  final routes = [
    const MangaHomePage(),
    const HomePage(),
    const AnimeHomePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: lightMode,
          darkTheme: darkMode,
          onGenerateRoute: (settings) {
            final args = settings.arguments as Map<String, dynamic>?;

            switch (settings.name) {
              case '/details':
                final id = args?['id'] ?? '';
                return MaterialPageRoute(
                  builder: (context) => DetailsPage(id: id),
                );
              case '/watch':
                final id = args?['id'] ?? '';
                return MaterialPageRoute(
                  builder: (context) => StreamingPage(id: id),
                );
              case '/manga/details':
                final id = args?['id'] ?? '';
                return MaterialPageRoute(
                  builder: (context) => MangaDetailsPage(id: id),
                );
              case '/manga/read':
                final id = args?['id'] ?? '';
                return MaterialPageRoute(
                  builder: (context) => MangaDetailsPage(id: id),
                );
              default:
                return MaterialPageRoute(
                  builder: (context) => const Scaffold(
                    body: Center(child: Text('Page not found')),
                  ),
                );
            }
          },
          home: Scaffold(
            extendBody: true,
            body: routes[_selectedIndex],
            bottomNavigationBar: CrystalNavigationBar(
              marginR: const EdgeInsets.symmetric(horizontal: 80, vertical: 20),
              currentIndex: _selectedIndex,
              unselectedItemColor: Colors.white70,
              backgroundColor: Colors.black.withOpacity(0.1),
              onTap: _onItemTapped,
              items: [
                CrystalNavigationBarItem(
                  icon: Icons.menu_book_rounded,
                  unselectedIcon: Icons.menu_book_outlined,
                  selectedColor: Colors.indigo,
                ),
                CrystalNavigationBarItem(
                  icon: IconlyBold.home,
                  unselectedIcon: IconlyLight.home,
                  selectedColor: Colors.indigo,
                ),
                CrystalNavigationBarItem(
                  icon: Icons.movie_filter_rounded,
                  unselectedIcon: Icons.movie_filter_outlined,
                  selectedColor: Colors.indigo,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
