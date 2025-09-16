import 'package:mongo_dart/mongo_dart.dart';
import '../config/database_config.dart';
import '../models/favorite.dart';
import '../models/movie.dart';

class FavoritesService {
  static Db? _db;
  static DbCollection? _collection;
  static final Map<String, List<Movie>> _localFavorites = {};

  static Future<void> _initializeDatabase() async {
    try {
      if (_db == null) {
        _db = Db(DatabaseConfig.fullConnectionString);
        await _db!.open();
        _collection = _db!.collection(DatabaseConfig.favoritesCollection);

        // Créer la collection si elle n'existe pas
        await _createCollectionIfNotExists();

        print('✅ Connexion MongoDB réussie !');
        print('📊 Base de données: ${DatabaseConfig.databaseName}');
        print('📁 Collection: ${DatabaseConfig.favoritesCollection}');
      }
    } catch (e) {
      print('❌ Erreur de connexion MongoDB: $e');
      _db = null;
      _collection = null;
    }
  }

  static Future<void> _createCollectionIfNotExists() async {
    try {
      // Vérifier si la collection existe en essayant de compter les documents
      final count = await _collection!.count();
      print(
        '✅ Collection "${DatabaseConfig.favoritesCollection}" accessible !',
      );
      print('📊 Nombre de documents actuels: $count');
    } catch (e) {
      print(
        '⚠️ Collection "${DatabaseConfig.favoritesCollection}" créée automatiquement au premier document inséré',
      );
    }
  }

  static Future<void> closeDatabase() async {
    if (_db != null) {
      await _db!.close();
      _db = null;
      _collection = null;
    }
  }

  static Future<bool> addToFavorites(String userId, Movie movie) async {
    print('🔄 FavoritesService.addToFavorites appelé');
    print('📊 userId: $userId, movie: ${movie.title} (ID: ${movie.id})');
    
    try {
      await _initializeDatabase();
      print('📡 Initialisation base de données terminée');

      if (_collection != null) {
        print('✅ Collection MongoDB disponible');
        final existingFavorite = await _collection!.findOne({
          'userId': userId,
          'movie.id': movie.id,
        });

        if (existingFavorite != null) {
          print('⚠️ Film déjà en favori');
          return false;
        }

        final favorite = Favorite(
          id: ObjectId().toString(),
          userId: userId,
          movie: movie,
          addedAt: DateTime.now(),
        );

        await _collection!.insertOne(favorite.toJson());
        print('✅ Film ajouté à MongoDB');
        return true;
      } else {
        print('📱 Utilisation du stockage local (MongoDB non disponible)');
        _addToLocalFavorites(userId, movie);
        print('✅ Film ajouté au stockage local');
        return true;
      }
    } catch (e) {
      print('❌ Erreur lors de l\'ajout aux favoris: $e');
      print('📱 Fallback vers le stockage local');
      _addToLocalFavorites(userId, movie);
      print('✅ Film ajouté au stockage local (fallback)');
      return true;
    }
  }

  static Future<bool> removeFromFavorites(String userId, int movieId) async {
    try {
      await _initializeDatabase();

      if (_collection != null) {
        final result = await _collection!.deleteOne({
          'userId': userId,
          'movie.id': movieId,
        });

        return result.isSuccess && result.nRemoved > 0;
      } else {
        _removeFromLocalFavorites(userId, movieId);
        return true;
      }
    } catch (e) {
      print('Erreur lors de la suppression des favoris: $e');
      _removeFromLocalFavorites(userId, movieId);
      return true;
    }
  }

  static Future<List<Movie>> getFavorites(String userId) async {
    try {
      await _initializeDatabase();

      if (_collection != null) {
        final cursor = _collection!.find(where.eq('userId', userId));
        final favorites = await cursor.toList();

        favorites.sort(
          (a, b) => DateTime.parse(
            b['addedAt'],
          ).compareTo(DateTime.parse(a['addedAt'])),
        );

        return favorites.map((doc) => Favorite.fromJson(doc).movie).toList();
      } else {
        return _getLocalFavorites(userId);
      }
    } catch (e) {
      print('Erreur lors de la récupération des favoris: $e');
      return _getLocalFavorites(userId);
    }
  }

  static Future<bool> isFavorite(String userId, int movieId) async {
    try {
      await _initializeDatabase();

      if (_collection != null) {
        final favorite = await _collection!.findOne({
          'userId': userId,
          'movie.id': movieId,
        });

        return favorite != null;
      } else {
        return _isLocalFavorite(userId, movieId);
      }
    } catch (e) {
      print('Erreur lors de la vérification des favoris: $e');
      return _isLocalFavorite(userId, movieId);
    }
  }

  static Future<int> getFavoritesCount(String userId) async {
    try {
      await _initializeDatabase();

      if (_collection != null) {
        final count = await _collection!.count(where.eq('userId', userId));
        return count;
      } else {
        return _getLocalFavorites(userId).length;
      }
    } catch (e) {
      print('Erreur lors du comptage des favoris: $e');
      return _getLocalFavorites(userId).length;
    }
  }

  static void _addToLocalFavorites(String userId, Movie movie) {
    if (!_localFavorites.containsKey(userId)) {
      _localFavorites[userId] = [];
    }

    if (!_isLocalFavorite(userId, movie.id!)) {
      _localFavorites[userId]!.add(movie);
    }
  }

  static void _removeFromLocalFavorites(String userId, int movieId) {
    if (_localFavorites.containsKey(userId)) {
      _localFavorites[userId]!.removeWhere((movie) => movie.id == movieId);
    }
  }

  static List<Movie> _getLocalFavorites(String userId) {
    return _localFavorites[userId] ?? [];
  }

  static bool _isLocalFavorite(String userId, int movieId) {
    if (!_localFavorites.containsKey(userId)) {
      return false;
    }
    return _localFavorites[userId]!.any((movie) => movie.id == movieId);
  }

  // Méthode pour insérer des données de test
  static Future<void> insertTestData() async {
    try {
      await _initializeDatabase();

      if (_collection != null) {
        // Vérifier si des données existent déjà
        final existingCount = await _collection!.count();
        if (existingCount > 0) {
          print('📊 Données de test déjà présentes: $existingCount documents');
          return;
        }

        // Créer des films de test
        final testMovies = [
          {
            '_id': ObjectId().toString(),
            'userId': 'default_user',
            'movie': {
              'id': 1,
              'title': 'War of the Worlds',
              'image': 'https://image.tmdb.org/t/p/w500/example1.jpg',
              'rating': 4.4,
              'releaseDate': '2025-07-29',
              'genres': ['Action', 'Sci-Fi'],
            },
            'addedAt': DateTime.now().toIso8601String(),
          },
          {
            '_id': ObjectId().toString(),
            'userId': 'default_user',
            'movie': {
              'id': 2,
              'title': 'The Conjuring: Last Rites',
              'image': 'https://image.tmdb.org/t/p/w500/example2.jpg',
              'rating': 3.8,
              'releaseDate': '2024-12-15',
              'genres': ['Horror', 'Thriller'],
            },
            'addedAt': DateTime.now().toIso8601String(),
          },
          {
            '_id': ObjectId().toString(),
            'userId': 'default_user',
            'movie': {
              'id': 3,
              'title': 'Nobody 2',
              'image': 'https://image.tmdb.org/t/p/w500/example3.jpg',
              'rating': 4.2,
              'releaseDate': '2025-03-21',
              'genres': ['Action', 'Comedy'],
            },
            'addedAt': DateTime.now().toIso8601String(),
          },
        ];

        // Insérer les données de test
        await _collection!.insertMany(testMovies);
        print('✅ Données de test insérées avec succès !');
        print('📊 ${testMovies.length} films ajoutés à la base de données');
      }
    } catch (e) {
      print('❌ Erreur lors de l\'insertion des données de test: $e');
    }
  }
}
