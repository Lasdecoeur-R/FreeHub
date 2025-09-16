import 'package:flutter/material.dart';
import '../models/movie.dart';
import '../services/tmdb_service.dart';
import '../widgets/carrousel_films.dart';
import '../widgets/carte_film.dart';
import '../widgets/indicateur_chargement.dart';
import '../widgets/message_erreur.dart';

class PageMieuxNotes extends StatefulWidget {
  const PageMieuxNotes({super.key});

  @override
  State<PageMieuxNotes> createState() => _PageMieuxNotesState();
}

class _PageMieuxNotesState extends State<PageMieuxNotes> {
  List<Movie> _films = [];
  List<Movie> _filmsCarrousel = [];
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadMovies();
  }

  Future<void> _loadMovies() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final movies = await TmdbService.getTopRatedMovies();
      setState(() {
        _films = movies;
        _filmsCarrousel = movies.take(5).toList();
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Erreur lors du chargement des films mieux notés: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const IndicateurChargement(
        message: 'Chargement des films mieux notés...',
      );
    }

    if (_errorMessage != null) {
      return MessageErreur(message: _errorMessage!, onRetry: _loadMovies);
    }

    if (_films.isEmpty) {
      return const MessageErreur(message: 'Aucun film mieux noté trouvé');
    }

    return SingleChildScrollView(
      child: Column(
        children: [
          CarrouselFilms(films: _filmsCarrousel),
          const SizedBox(height: 20),
          ..._films.map((film) => CarteFilm(film: film)),
        ],
      ),
    );
  }
}
