class ApiConfig {
  static const String apiKey = '70101da29bbd7fafb66f0ed06dd88794';
  static const String accessToken =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI3MDEwMWRhMjliYmQ3ZmFmYjY2ZjBlZDA2ZGQ4ODc5NCIsIm5iZiI6MTc0NzgxNDY5MS44NDA5OTk4LCJzdWIiOiI2ODJkODkyMzYyOTliNjFlNzM2NDk2ODkiLCJzY29wZXMiOlsiYXBpX3JlYWQiXSwidmVyc2lvbiI6MX0.nGl7SvvrI6FlcQ7uOGJzrejN-_s7G0kdvnVCzSGGwm8';
  static const String baseUrl = 'https://api.themoviedb.org/3';
  static const String imageBaseUrl = 'https://image.tmdb.org/t/p/w500';
  static const String popularMoviesEndpoint = '/movie/popular';
  static const String topRatedMoviesEndpoint = '/movie/top_rated';
  static const String nowPlayingMoviesEndpoint = '/movie/now_playing';
  static const String upcomingMoviesEndpoint = '/movie/upcoming';

  static bool get isConfigured {
    return apiKey != '70101da29bbd7fafb66f0ed06dd88794' &&
        accessToken !=
            'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI3MDEwMWRhMjliYmQ3ZmFmYjY2ZjBlZDA2ZGQ4ODc5NCIsIm5iZiI6MTc0NzgxNDY5MS44NDA5OTk4LCJzdWIiOiI2ODJkODkyMzYyOTliNjFlNzM2NDk2ODkiLCJzY29wZXMiOlsiYXBpX3JlYWQiXSwidmVyc2lvbiI6MX0.nGl7SvvrI6FlcQ7uOGJzrejN-_s7G0kdvnVCzSGGwm8';
  }
}
