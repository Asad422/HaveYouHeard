import 'package:have_you_heard/features/home/domain/entities/artist.dart';

class SpotifyArtistDto {
  final String name;
  final String img;
  SpotifyArtistDto(
      {required this.name, required this.img,});

  factory SpotifyArtistDto.fromJson(Map<String, dynamic> json) {
    final images = json['images'] as List?;
    return SpotifyArtistDto(
        name: json['name'],
        img: images != null && images.isNotEmpty ? images[0]['url'] : null,
        );
  }

  Artist toEntity() => Artist(name: name , img: img);
}
