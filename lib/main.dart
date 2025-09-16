import 'package:flutter/material.dart';
import 'pages/page_accueil.dart';

void main() {
  runApp(const ApplicationFilms());
}

class ApplicationFilms extends StatelessWidget {
  const ApplicationFilms({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Application Films',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        scaffoldBackgroundColor: Colors.black,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.purple,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
      ),
      home: const PageAccueil(),
      debugShowCheckedModeBanner: false,
    );
  }
}
