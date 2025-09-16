import 'package:flutter/material.dart';

class ElementNavigationBas extends StatelessWidget {
  final IconData icone;
  final bool estSelectionnee;

  const ElementNavigationBas(
    this.icone, {
    super.key,
    required this.estSelectionnee,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icone,
          color: estSelectionnee ? Colors.purple : Colors.grey,
          size: 24,
        ),
        if (estSelectionnee)
          Container(
            margin: const EdgeInsets.only(top: 4),
            width: 20,
            height: 2,
            color: Colors.purple,
          ),
      ],
    );
  }
}
