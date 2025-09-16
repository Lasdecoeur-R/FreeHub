import 'package:flutter/material.dart';
import '../models/movie.dart';
import '../services/favorites_service.dart';
import 'affiche_film.dart';
import 'infos_film.dart';
import 'bouton_favori.dart';

class CarteFilm extends StatefulWidget {
  final Movie film;
  final String userId;

  const CarteFilm({
    super.key,
    required this.film,
    this.userId = 'default_user',
  });

  @override
  State<CarteFilm> createState() => _CarteFilmState();
}

class _CarteFilmState extends State<CarteFilm> {
  bool _estFavori = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _checkFavoriteStatus();
  }

  Future<void> _checkFavoriteStatus() async {
    if (widget.film.id != null) {
      final isFavorite = await FavoritesService.isFavorite(widget.userId, widget.film.id!);
      setState(() {
        _estFavori = isFavorite;
      });
    }
  }

  Future<void> _toggleFavorite() async {
    if (_isLoading || widget.film.id == null) return;

    setState(() {
      _isLoading = true;
    });

    try {
      if (_estFavori) {
        final success = await FavoritesService.removeFromFavorites(widget.userId, widget.film.id!);
        if (success) {
          setState(() {
            _estFavori = false;
          });
        }
      } else {
        final success = await FavoritesService.addToFavorites(widget.userId, widget.film);
        if (success) {
          setState(() {
            _estFavori = true;
          });
        }
      }
    } catch (e) {
      print('Erreur lors de la modification des favoris: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              AfficheFilm(image: widget.film.image),
              Positioned(
                top: 8,
                right: 8,
                child: BoutonFavori(
                  estFavori: _estFavori,
                  onTap: _toggleFavorite,
                  taille: 32,
                ),
              ),
            ],
          ),
          const SizedBox(width: 15),
          Expanded(
            child: InfosFilm(
              titre: widget.film.title,
              bio: widget.film.formattedDescription,
            ),
          ),
        ],
      ),
    );
  }
}