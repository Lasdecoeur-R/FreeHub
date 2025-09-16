# 🎬 Configuration de l'API TMDB

## 📋 Prérequis

Pour utiliser l'API TMDB, vous devez :

1. **Créer un compte TMDB** : Allez sur [themoviedb.org](https://www.themoviedb.org) et créez un compte
2. **Obtenir votre clé API** : Dans votre profil, allez dans "API" et demandez une clé API
3. **Obtenir votre token d'accès** : Créez un token d'accès dans la section API

## 🔧 Configuration

### 1. Modifier le fichier de configuration

Ouvrez le fichier `lib/config/api_config.dart` et remplacez :

```dart
// Remplacez par votre clé API TMDB
static const String apiKey = 'VOTRE_CLE_API_TMDB_ICI';

// Remplacez par votre token d'accès TMDB
static const String accessToken = 'VOTRE_TOKEN_TMDB_ICI';
```

Par vos vraies clés :

```dart
// Votre vraie clé API TMDB
static const String apiKey = 'votre_cle_api_ici';

// Votre vrai token d'accès TMDB
static const String accessToken = 'votre_token_ici';
```

### 2. Installer les dépendances

Exécutez la commande suivante dans le terminal :

```bash
flutter pub get
```

## 🚀 Fonctionnalités

### 📱 Catégories de Films

- **TOUS** : Films populaires
- **POPULAIRES** : Films les plus populaires
- **MIEUX NOTÉS** : Films les mieux notés
- **EN SALLE** : Films actuellement en salle
- **À VENIR** : Films à venir

### 🎯 Informations Affichées

Pour chaque film, l'application affiche :

- **Titre** du film
- **Affiche** du film
- **Description** complète
- **Note** sur 10
- **Date de sortie**
- **Genres** du film

### 🔄 Gestion des Erreurs

L'application gère automatiquement :

- **Erreurs de connexion** : Affiche un message d'erreur avec bouton de retry
- **Clés API manquantes** : Affiche un message pour configurer les clés
- **Films non trouvés** : Affiche un message approprié

## 📊 Structure des Données

### Modèle Movie

```dart
class Movie {
  final String title;        // Titre du film
  final String bio;          // Description du film
  final String image;        // URL de l'affiche
  final int? id;            // ID TMDB
  final double? rating;     // Note sur 10
  final String? releaseDate; // Date de sortie
  final List<String>? genres; // Genres du film
}
```

### Service TMDB

Le service `TmdbService` fournit les méthodes suivantes :

- `getPopularMovies()` : Films populaires
- `getTopRatedMovies()` : Films les mieux notés
- `getNowPlayingMovies()` : Films en salle
- `getUpcomingMovies()` : Films à venir
- `getMovieById(id)` : Film spécifique

## 🎨 Interface Utilisateur

### Widgets Créés

- **IndicateurChargement** : Spinner de chargement
- **MessageErreur** : Affichage des erreurs avec retry
- **SectionCategories** : Navigation entre catégories
- **CarteFilm** : Affichage d'un film avec informations

### Thème

- **Couleur principale** : Violet
- **Fond** : Noir
- **Texte** : Blanc/Gris clair
- **Accents** : Rouge pour les boutons de lecture

## 🔒 Sécurité

⚠️ **Important** : Ne commitez jamais vos clés API dans le code source !

Pour la production, utilisez :

1. **Variables d'environnement**
2. **Fichiers de configuration séparés**
3. **Services de gestion des secrets**

## 🐛 Dépannage

### Erreur "API Key not found"

- Vérifiez que vous avez bien remplacé les clés dans `api_config.dart`
- Vérifiez que vos clés sont valides sur le site TMDB

### Erreur de connexion

- Vérifiez votre connexion internet
- Vérifiez que l'API TMDB est accessible

### Films non affichés

- Vérifiez que vos clés API ont les bonnes permissions
- Vérifiez les logs de l'application pour plus de détails

## 📚 Ressources

- [Documentation API TMDB](https://developers.themoviedb.org/3)
- [Guide d'authentification TMDB](https://developers.themoviedb.org/3/authentication)
- [Flutter HTTP Package](https://pub.dev/packages/http)

## 🎯 Prochaines Étapes

- [ ] Ajouter la recherche de films
- [ ] Implémenter la pagination
- [ ] Ajouter les détails d'un film
- [ ] Sauvegarder les favoris
- [ ] Ajouter les bandes-annonces
