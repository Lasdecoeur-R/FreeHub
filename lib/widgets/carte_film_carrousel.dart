import 'package:flutter/material.dart';
import '../models/movie.dart';
import '../services/favorites_service.dart';
import 'bouton_lecture.dart';
import 'bouton_favori.dart';

class CarteFilmCarrousel extends StatefulWidget {
  final Movie film;
  final String userId;

  const CarteFilmCarrousel({
    super.key,
    required this.film,
    this.userId = 'default_user',
  });

  @override
  State<CarteFilmCarrousel> createState() => _CarteFilmCarrouselState();
}

class _CarteFilmCarrouselState extends State<CarteFilmCarrousel> {
  bool _estFavori = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _checkFavoriteStatus();
  }

  Future<void> _checkFavoriteStatus() async {
    if (widget.film.id != null) {
      final isFavorite = await FavoritesService.isFavorite(
        widget.userId,
        widget.film.id!,
      );
      setState(() {
        _estFavori = isFavorite;
      });
    }
  }

  Future<void> _toggleFavorite() async {
    if (_isLoading || widget.film.id == null) {
      print(
        '⚠️ Impossible d\'ajouter aux favoris: isLoading=$_isLoading, filmId=${widget.film.id}',
      );
      return;
    }

    print(
      '🔄 Toggle favori pour: ${widget.film.title} (ID: ${widget.film.id})',
    );
    print('📊 État actuel: ${_estFavori ? "Favori" : "Pas favori"}');

    setState(() {
      _isLoading = true;
    });

    try {
      if (_estFavori) {
        print('🗑️ Suppression du favori...');
        final success = await FavoritesService.removeFromFavorites(
          widget.userId,
          widget.film.id!,
        );
        if (success) {
          setState(() {
            _estFavori = false;
          });
          print('✅ Favori supprimé avec succès');
        } else {
          print('❌ Échec de la suppression du favori');
        }
      } else {
        print('➕ Ajout aux favoris...');
        final success = await FavoritesService.addToFavorites(
          widget.userId,
          widget.film,
        );
        if (success) {
          setState(() {
            _estFavori = true;
          });
          print('✅ Favori ajouté avec succès');
        } else {
          print('❌ Échec de l\'ajout aux favoris');
        }
      }
    } catch (e) {
      print('❌ Erreur lors de la modification des favoris: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(widget.film.image),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
                ),
              ),
            ),
            Positioned(
              top: 15,
              right: 15,
              child: BoutonFavori(
                estFavori: _estFavori,
                onTap: _toggleFavorite,
                taille: 40,
              ),
            ),
            Positioned(
              bottom: 20,
              left: 20,
              right: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.film.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                          color: Colors.black,
                          offset: Offset(1, 1),
                          blurRadius: 3,
                        ),
                      ],
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  if (widget.film.rating != null)
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.yellow, size: 16),
                        const SizedBox(width: 4),
                        Text(
                          '${widget.film.rating!.toStringAsFixed(1)}/10',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            shadows: [
                              Shadow(
                                color: Colors.black,
                                offset: Offset(1, 1),
                                blurRadius: 2,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  const SizedBox(height: 8),
                  if (widget.film.releaseDate != null)
                    Text(
                      'Sortie: ${_formatDate(widget.film.releaseDate!)}',
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                        shadows: [
                          Shadow(
                            color: Colors.black,
                            offset: Offset(1, 1),
                            blurRadius: 2,
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
            const Positioned(bottom: 20, right: 20, child: BoutonLecture()),
          ],
        ),
      ),
    );
  }

  String _formatDate(String dateString) {
    try {
      final date = DateTime.parse(dateString);
      return '${date.day}/${date.month}/${date.year}';
    } catch (e) {
      return dateString;
    }
  }
}
