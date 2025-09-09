import 'package:flutter/material.dart';

void main() {
  runApp(const MoviesApp());
}

class MoviesApp extends StatelessWidget {
  const MoviesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movies App',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        scaffoldBackgroundColor: Colors.black,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.purple,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
      ),
      home: const MoviesHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MoviesHomePage extends StatefulWidget {
  const MoviesHomePage({super.key});

  @override
  State<MoviesHomePage> createState() => _MoviesHomePageState();
}

class _MoviesHomePageState extends State<MoviesHomePage> {
  final List<String> categories = [
    'TOUS',
    'WESTERN',
    'HORREUR',
    'COMÉDIE',
    'ACTION',
    'DRAME',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Header violet simple
          Container(
            color: Colors.purple,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
            child: const Center(
              child: Text(
                'MOVIES',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
              ),
            ),
          ),

          // Categories navigation (non-interactive)
          Container(
            color: Colors.black,
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: SizedBox(
              height: 40,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final isSelected = index == 0; // TOUS toujours sélectionné
                  return Container(
                    margin: const EdgeInsets.only(right: 20),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.purple : Colors.transparent,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text(
                        categories[index],
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.white70,
                          fontSize: 14,
                          fontWeight: isSelected
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),

          // Main content area (black background)
          Expanded(
            child: Container(
              color: Colors.black,
              child: const Center(
                child: Text(
                  'Contenu principal',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
          ),

          // Bottom white section with navigation (non-interactive)
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildBottomNavItem(Icons.emoji_events, 0),
                _buildBottomNavItem(Icons.home, 1, isSelected: true),
                _buildBottomNavItem(Icons.person, 2),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavItem(
    IconData icon,
    int index, {
    bool isSelected = false,
  }) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Icon(
        icon,
        color: isSelected ? Colors.purple : Colors.grey[600],
        size: isSelected ? 28 : 24,
      ),
    );
  }
}
