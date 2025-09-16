import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/api_config.dart';
import '../models/movie.dart';

class TmdbService {
  static Map<String, String> get _headers => {
    'Authorization': 'Bearer ${ApiConfig.accessToken}',
    'Content-Type': 'application/json',
  };

  static Future<List<Movie>> getPopularMovies({int page = 1}) async {
    try {
      final url = Uri.parse(
        '${ApiConfig.baseUrl}${ApiConfig.popularMoviesEndpoint}?api_key=${ApiConfig.apiKey}&page=$page',
      );

      final response = await http.get(url, headers: _headers);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<dynamic> movies = data['results'];

        return movies.map((movie) => Movie.fromTmdbJson(movie)).toList();
      } else {
        throw Exception(
          'Erreur lors de la récupération des films: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Erreur de connexion: $e');
    }
  }

  static Future<List<Movie>> getTopRatedMovies({int page = 1}) async {
    try {
      final url = Uri.parse(
        '${ApiConfig.baseUrl}${ApiConfig.topRatedMoviesEndpoint}?api_key=${ApiConfig.apiKey}&page=$page',
      );

      final response = await http.get(url, headers: _headers);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<dynamic> movies = data['results'];

        return movies.map((movie) => Movie.fromTmdbJson(movie)).toList();
      } else {
        throw Exception(
          'Erreur lors de la récupération des films: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Erreur de connexion: $e');
    }
  }

  static Future<List<Movie>> getNowPlayingMovies({int page = 1}) async {
    try {
      final url = Uri.parse(
        '${ApiConfig.baseUrl}${ApiConfig.nowPlayingMoviesEndpoint}?api_key=${ApiConfig.apiKey}&page=$page',
      );

      final response = await http.get(url, headers: _headers);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<dynamic> movies = data['results'];

        return movies.map((movie) => Movie.fromTmdbJson(movie)).toList();
      } else {
        throw Exception(
          'Erreur lors de la récupération des films: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Erreur de connexion: $e');
    }
  }

  static Future<List<Movie>> getUpcomingMovies({int page = 1}) async {
    try {
      final url = Uri.parse(
        '${ApiConfig.baseUrl}${ApiConfig.upcomingMoviesEndpoint}?api_key=${ApiConfig.apiKey}&page=$page',
      );

      final response = await http.get(url, headers: _headers);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<dynamic> movies = data['results'];

        return movies.map((movie) => Movie.fromTmdbJson(movie)).toList();
      } else {
        throw Exception(
          'Erreur lors de la récupération des films: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Erreur de connexion: $e');
    }
  }

  static Future<Movie> getMovieById(int movieId) async {
    try {
      final url = Uri.parse(
        '${ApiConfig.baseUrl}/movie/$movieId?api_key=${ApiConfig.apiKey}',
      );

      final response = await http.get(url, headers: _headers);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return Movie.fromTmdbJson(data);
      } else {
        throw Exception(
          'Erreur lors de la récupération du film: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Erreur de connexion: $e');
    }
  }
}
