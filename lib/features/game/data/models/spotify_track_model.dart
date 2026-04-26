

import 'package:have_you_heard/features/game/domain/entities/track.dart';

class SpotifyTrackModel {
  final String id;
  final String title;
  final String artistName;
  final String coverUrl;

  SpotifyTrackModel({
    required this.id,
    required this.title,
    required this.artistName,
    required this.coverUrl,
  });

  factory SpotifyTrackModel.fromJson(Map<String, dynamic> json) {
    return SpotifyTrackModel(
      id: json['id'],
      title: json['name'],
      artistName: json['artists'][0]['name'],
      coverUrl: json['album']['images'][0]['url'],
    );
  }

  Track toEntity() => Track(
        id: id,
        title: title,
        artistName: artistName,
        coverUrl: coverUrl,
      );
}