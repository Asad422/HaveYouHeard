
import 'package:have_you_heard/features/game/domain/entities/track.dart';
import 'package:have_you_heard/features/game/domain/repositories/track_repository.dart';

class GetTopTracks {
  final TrackRepository repository;

  GetTopTracks(this.repository);

  Future<List<Track>> call() async {
    return await repository.getTopTracks();
  }
}