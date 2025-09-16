import 'package:flutter/material.dart';

class TitreFilm extends StatelessWidget {
  const TitreFilm({super.key});

  @override
  Widget build(BuildContext context) {
    return const Positioned(
      bottom: 90,
      left: 25,
      child: Text(
        'THE MOVIE',
        style: TextStyle(
          color: Colors.white,
          fontSize: 32,
          fontWeight: FontWeight.w900,
          letterSpacing: 3.0,
          height: 0.9,
          shadows: [
            Shadow(color: Colors.black54, offset: Offset(2, 2), blurRadius: 4),
          ],
        ),
      ),
    );
  }
}
