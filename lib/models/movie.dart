class Movie {
  final String title;
  final String bio;
  final String image;
  final int? id;
  final double? rating;
  final String? releaseDate;
  final List<String>? genres;

  const Movie({
    required this.title,
    required this.bio,
    required this.image,
    this.id,
    this.rating,
    this.releaseDate,
    this.genres,
  });

  factory Movie.fromTmdbJson(Map<String, dynamic> json) {
    List<String>? genresList;
    if (json['genre_ids'] != null) {
      final List<dynamic> genreIds = json['genre_ids'];
      genresList = genreIds.map((id) => _getGenreName(id as int)).toList();
    }

    return Movie(
      id: json['id'],
      title: json['title'] ?? json['original_title'] ?? 'Titre inconnu',
      bio: json['overview'] ?? 'Aucune description disponible',
      image: json['poster_path'] != null
          ? 'https://image.tmdb.org/t/p/w500${json['poster_path']}'
          : 'https://via.placeholder.com/500x750?text=Image+non+disponible',
      rating: json['vote_average']?.toDouble(),
      releaseDate: json['release_date'],
      genres: genresList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'bio': bio,
      'image': image,
      'rating': rating,
      'releaseDate': releaseDate,
      'genres': genres,
    };
  }

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'],
      title: json['title'],
      bio: json['bio'],
      image: json['image'],
      rating: json['rating']?.toDouble(),
      releaseDate: json['releaseDate'],
      genres: json['genres']?.cast<String>(),
    );
  }

  static String _getGenreName(int genreId) {
    const genreMap = {
      28: 'Action',
      12: 'Aventure',
      16: 'Animation',
      35: 'Comédie',
      80: 'Crime',
      99: 'Documentaire',
      18: 'Drame',
      10751: 'Famille',
      14: 'Fantasy',
      36: 'Histoire',
      27: 'Horreur',
      10402: 'Musique',
      9648: 'Mystère',
      10749: 'Romance',
      878: 'Science-Fiction',
      10770: 'Téléfilm',
      53: 'Thriller',
      10752: 'Guerre',
      37: 'Western',
    };
    return genreMap[genreId] ?? 'Inconnu';
  }

  String get formattedDescription {
    String description = bio;

    if (rating != null) {
      description += '\n\n⭐ Note: ${rating!.toStringAsFixed(1)}/10';
    }

    if (releaseDate != null) {
      description += '\n📅 Sortie: ${_formatDate(releaseDate!)}';
    }

    if (genres != null && genres!.isNotEmpty) {
      description += '\n🎭 Genres: ${genres!.join(', ')}';
    }

    return description;
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
