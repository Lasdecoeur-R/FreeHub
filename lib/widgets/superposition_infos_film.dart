import 'package:flutter/material.dart';

class SuperpositionInfosFilm extends StatelessWidget {
  const SuperpositionInfosFilm({super.key});

  @override
  Widget build(BuildContext context) {
    return const Positioned(
      top: 25,
      left: 25,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'FROM THE DIRECTOR OF TOP GUN: MAVERICK',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 11,
              fontWeight: FontWeight.w400,
              letterSpacing: 0.5,
              height: 1.2,
            ),
          ),
          SizedBox(height: 4),
          Text(
            'BRAD PITT',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.0,
              height: 1.1,
            ),
          ),
        ],
      ),
    );
  }
}
