import 'package:dio/dio.dart';
import 'package:have_you_heard/core/constants/app_contstants.dart';
import 'package:have_you_heard/features/game/data/models/dezzer_track_model.dart';

class DeezerDataSource {
  final Dio _dio = Dio();

  Future<String?> getPreviewUrl(String trackName, String artistName) async {
    final response = await _dio.get(
      '${ApiConstants.deezerBaseUrl}/search',
      queryParameters: {
        'q': '$artistName $trackName',
        'limit': 1,
      },
    );
    final items = response.data['data'] as List;
    if (items.isEmpty) return null;

    final track = DeezerTrackModel.fromJson(items[0]);
    return track.previewUrl;
  }
}