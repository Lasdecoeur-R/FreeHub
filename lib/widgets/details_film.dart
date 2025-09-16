import 'package:flutter/material.dart';

class DetailsFilm extends StatelessWidget {
  const DetailsFilm({super.key});

  @override
  Widget build(BuildContext context) {
    return const Positioned(
      bottom: 25,
      left: 25,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'ONLY IN THEATERS',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 11,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.8,
              height: 1.3,
            ),
          ),
          SizedBox(height: 2),
          Text(
            'JUNE 27',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 11,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.8,
              height: 1.3,
            ),
          ),
          SizedBox(height: 2),
          Text(
            'FILMED FOR IMAX',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 11,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.8,
              height: 1.3,
            ),
          ),
        ],
      ),
    );
  }
}
