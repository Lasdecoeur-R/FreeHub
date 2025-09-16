import 'package:flutter/material.dart';

class PuceCategorie extends StatelessWidget {
  final String texte;
  final bool estSelectionnee;

  const PuceCategorie({
    super.key,
    required this.texte,
    required this.estSelectionnee,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: estSelectionnee ? Colors.purple : Colors.transparent,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: Text(
          texte,
          style: TextStyle(
            color: estSelectionnee ? Colors.white : Colors.white70,
            fontSize: 14,
            fontWeight: estSelectionnee ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
