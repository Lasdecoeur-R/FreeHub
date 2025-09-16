import 'movie.dart';

class Favorite {
  final String id;
  final String userId;
  final Movie movie;
  final DateTime addedAt;

  const Favorite({
    required this.id,
    required this.userId,
    required this.movie,
    required this.addedAt,
  });

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'userId': userId,
      'movie': movie.toJson(),
      'addedAt': addedAt.toIso8601String(),
    };
  }

  factory Favorite.fromJson(Map<String, dynamic> json) {
    return Favorite(
      id: json['_id'] ?? json['id'],
      userId: json['userId'],
      movie: Movie.fromJson(json['movie']),
      addedAt: DateTime.parse(json['addedAt']),
    );
  }

  Favorite copyWith({
    String? id,
    String? userId,
    Movie? movie,
    DateTime? addedAt,
  }) {
    return Favorite(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      movie: movie ?? this.movie,
      addedAt: addedAt ?? this.addedAt,
    );
  }
}
