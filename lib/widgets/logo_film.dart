import 'package:flutter/material.dart';

class LogoFilm extends StatelessWidget {
  const LogoFilm({super.key});

  @override
  Widget build(BuildContext context) {
    return const Positioned(
      bottom: 50,
      left: 20,
      child: Text(
        'F1',
        style: TextStyle(
          color: Colors.red,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
