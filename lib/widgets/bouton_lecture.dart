import 'package:flutter/material.dart';

class BoutonLecture extends StatelessWidget {
  final double taille;
  final double tailleIcone;
  final VoidCallback? onTap;

  const BoutonLecture({
    super.key,
    this.taille = 50,
    this.tailleIcone = 30,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: taille,
        height: taille,
        decoration: const BoxDecoration(
          color: Colors.red,
          shape: BoxShape.circle,
        ),
        child: Icon(Icons.play_arrow, color: Colors.white, size: tailleIcone),
      ),
    );
  }
}
