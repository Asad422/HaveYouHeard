import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConstants {
  // Spotify
  static String get spotifyClientId => dotenv.env['SPOTIFY_CLIENT_ID']!;
  static String get spotifyClientSecret => dotenv.env['SPOTIFY_CLIENT_SECRET']!;
  static const String spotifyRedirectUri = 'haveyouheard://callback';
  static const String spotifyBaseUrl = 'https://api.spotify.com/v1';
  static const String spotifyAuthUrl = 'https://accounts.spotify.com/api/token';

  // Deezer
  static const String deezerBaseUrl = 'https://api.deezer.com';
}
