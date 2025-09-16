import 'package:flutter/material.dart';
import '../models/movie.dart';
import 'carte_film_carrousel.dart';

class CarrouselFilms extends StatelessWidget {
  final List<Movie> films;

  const CarrouselFilms({super.key, required this.films});

  @override
  Widget build(BuildContext context) {
    if (films.isEmpty) {
      return const SizedBox.shrink();
    }

    return SizedBox(
      height: 300,
      child: PageView.builder(
        controller: PageController(viewportFraction: 0.85),
        itemCount: films.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: CarteFilmCarrousel(film: films[index]),
          );
        },
      ),
    );
  }
}
