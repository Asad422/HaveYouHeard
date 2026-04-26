class DeezerTrackModel {
  final String title;
  final String artistName;
  final String? previewUrl;

  DeezerTrackModel({
    required this.title,
    required this.artistName,
    this.previewUrl,
  });

  factory DeezerTrackModel.fromJson(Map<String, dynamic> json) {
    return DeezerTrackModel(
      title: json['title'],
      artistName: json['artist']['name'],
      previewUrl: json['preview'],
    );
  }
}