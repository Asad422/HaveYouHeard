
import 'package:equatable/equatable.dart';
class Track extends Equatable {
  final String id;
  final String title;
  final String artistName;
  final String coverUrl;
  final String? previewUrl;

  const Track({
    required this.id,
    required this.title,
    required this.artistName,
    required this.coverUrl,
    this.previewUrl,
  });

  Track copyWith({
    String? id,
    String? title,
    String? artistName,
    String? coverUrl,
    String? previewUrl,
  }) {
    return Track(
      id: id ?? this.id,
      title: title ?? this.title,
      artistName: artistName ?? this.artistName,
      coverUrl: coverUrl ?? this.coverUrl,
      previewUrl: previewUrl ?? this.previewUrl,
    );
  }

  @override
  List<Object?> get props => [id, title, artistName, coverUrl, previewUrl];
}