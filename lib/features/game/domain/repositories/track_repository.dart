import '../entities/track.dart';

abstract class TrackRepository {
  Future<List<Track>> getTopTracks();
  Future<String?> getPreviewUrl(String trackName, String artistName);
}