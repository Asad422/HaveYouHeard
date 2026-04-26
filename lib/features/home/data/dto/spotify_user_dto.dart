import 'package:have_you_heard/features/home/domain/entities/user.dart';

class SpotifyUserDto {
  final String? name;
  final String? img;
  final String? country;
  SpotifyUserDto(
      {required this.name, required this.img, required this.country});

  factory SpotifyUserDto.fromJson(Map<String, dynamic> json) {
    final images = json['images'] as List?;
    return SpotifyUserDto(
        name: json['display_name'],
        img: images != null && images.isNotEmpty ? images[0]['url'] : null,
        country: json['country']);
  }

  User toEntity() => User(img: img, name: name ?? "-", country: country);
}
