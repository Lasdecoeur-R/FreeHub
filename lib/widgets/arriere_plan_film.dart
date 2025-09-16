import 'package:flutter/material.dart';

class ArrierePlanFilm extends StatelessWidget {
  const ArrierePlanFilm({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.grey[800],
      ),
      child: const Center(
        child: Icon(Icons.movie, size: 80, color: Colors.white54),
      ),
    );
  }
}
