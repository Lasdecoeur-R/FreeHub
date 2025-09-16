import 'package:flutter/material.dart';
import 'bouton_lecture.dart';
import 'arriere_plan_film.dart';
import 'superposition_infos_film.dart';
import 'titre_film.dart';
import 'logo_film.dart';
import 'details_film.dart';

class CarteFilmVedette extends StatelessWidget {
  const CarteFilmVedette({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      height: 250,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.black87, Colors.grey],
        ),
      ),
      child: Stack(
        children: [
          const ArrierePlanFilm(),
          const SuperpositionInfosFilm(),
          const TitreFilm(),
          const LogoFilm(),
          const DetailsFilm(),
          const Positioned(bottom: 20, right: 20, child: BoutonLecture()),
        ],
      ),
    );
  }
}
