class DatabaseConfig {
  // Essai avec une connexion simplifiée
  static const String connectionString =
      'mongodb://ludovicrassaby_db_user:3o20N6tMw2UTzZej@clusterfreehub.g6u3vyu.mongodb.net:27017/frehub_db?ssl=true&authSource=admin&connectTimeoutMS=5000&serverSelectionTimeoutMS=5000';

  static const String databaseName = 'frehub_db';
  static const String favoritesCollection = 'favorites';

  static String get fullConnectionString => connectionString;
}
