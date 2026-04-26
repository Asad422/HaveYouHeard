import '../repositories/track_repository.dart';

class GetPreviewUrl {
  final TrackRepository repository;

  GetPreviewUrl(this.repository);

  Future<String?> call(String trackName, String artistName) async {
    return await repository.getPreviewUrl(trackName, artistName);
  }
}