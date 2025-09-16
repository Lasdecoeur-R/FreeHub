import 'package:flutter/material.dart';
import '../models/movie.dart';
import '../services/favorites_service.dart';
import '../widgets/carte_film.dart';
import '../widgets/indicateur_chargement.dart';
import '../widgets/message_erreur.dart';

class PageFavoris extends StatefulWidget {
  final String userId;

  const PageFavoris({super.key, this.userId = 'default_user'});

  @override
  State<PageFavoris> createState() => _PageFavorisState();
}

class _PageFavorisState extends State<PageFavoris> {
  List<Movie> _favoris = [];
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final favorites = await FavoritesService.getFavorites(widget.userId);
      setState(() {
        _favoris = favorites;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Erreur lors du chargement des favoris: $e';
      });
    }
  }

  Future<void> _insertTestData() async {
    setState(() {
      _isLoading = true;
    });

    try {
      await FavoritesService.insertTestData();
      await _loadFavorites();
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Erreur lors de l\'insertion des données de test: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const IndicateurChargement(
        message: 'Chargement de vos favoris...',
      );
    }

    if (_errorMessage != null) {
      return MessageErreur(message: _errorMessage!, onRetry: _loadFavorites);
    }

    if (_favoris.isEmpty) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const MessageErreur(message: 'Aucun film en favori'),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: _insertTestData,
            icon: const Icon(Icons.add),
            label: const Text('Ajouter des données de test'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.purple,
              foregroundColor: Colors.white,
            ),
          ),
        ],
      );
    }

    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 20),
          ..._favoris.map(
            (film) => CarteFilm(film: film, userId: widget.userId),
          ),
        ],
      ),
    );
  }
}
