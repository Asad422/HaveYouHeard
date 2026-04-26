import 'package:have_you_heard/features/game/data/ds/deezer_data_source.dart';
import 'package:have_you_heard/features/game/data/ds/spotify_data_source.dart';

import '../../domain/entities/track.dart';
import '../../domain/repositories/track_repository.dart';

class TrackRepositoryImpl implements TrackRepository {
  final SpotifyDataSource _spotifyDataSource;
  final DeezerDataSource _deezerDataSource;

  TrackRepositoryImpl({
    required SpotifyDataSource spotifyDataSource,
    required DeezerDataSource deezerDataSource,
  })  : _spotifyDataSource = spotifyDataSource,
        _deezerDataSource = deezerDataSource;

  @override
  Future<List<Track>> getTopTracks() async {
    final spotifyTracks = await _spotifyDataSource.getTopTracks();
    return spotifyTracks.map((t) => t.toEntity()).toList();
  }

  @override
  Future<String?> getPreviewUrl(String trackName, String artistName) async {
    return await _deezerDataSource.getPreviewUrl(trackName, artistName);
  }
}