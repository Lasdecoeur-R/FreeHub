import 'package:flutter/material.dart';
import 'bouton_lecture.dart';

class AfficheFilm extends StatelessWidget {
  final String image;

  const AfficheFilm({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(image: NetworkImage(image), fit: BoxFit.cover),
      ),
      child: const Stack(
        children: [
          Positioned(
            bottom: 8,
            right: 8,
            child: BoutonLecture(taille: 24, tailleIcone: 16),
          ),
        ],
      ),
    );
  }
}
