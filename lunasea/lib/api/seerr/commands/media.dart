import 'package:dio/dio.dart';
import 'package:arrpilot/api/seerr/models.dart';

/// Command handler for media search and details endpoints
class SeerrCommandHandlerMedia {
  final Dio _client;

  SeerrCommandHandlerMedia(this._client);

  /// Search for media
  ///
  /// Required Parameters:
  /// - `query`: Search query string
  ///
  /// Optional Parameters:
  /// - `page`: Page number for pagination (default: 1)
  /// - `language`: Language code for results (default: en)
  Future<SeerrSearchResults> search({
    required String query,
    int? page,
    String? language,
  }) async {
    Response response = await _client.get(
      'search',
      queryParameters: {
        'query': query,
        if (page != null) 'page': page,
        if (language != null) 'language': language,
      },
    );
    return SeerrSearchResults.fromJson(response.data);
  }

  /// Get movie details by TMDB ID
  Future<SeerrMovie> getMovie(int movieId, {String? language}) async {
    Response response = await _client.get(
      'movie/$movieId',
      queryParameters: {
        if (language != null) 'language': language,
      },
    );
    return SeerrMovie.fromJson(response.data);
  }

  /// Get TV show details by TMDB ID
  Future<SeerrTVShow> getTVShow(int tvId, {String? language}) async {
    Response response = await _client.get(
      'tv/$tvId',
      queryParameters: {
        if (language != null) 'language': language,
      },
    );
    return SeerrTVShow.fromJson(response.data);
  }

  /// Get trending media
  ///
  /// Optional Parameters:
  /// - `page`: Page number for pagination (default: 1)
  /// - `language`: Language code for results (default: en)
  Future<SeerrSearchResults> getTrending({
    int? page,
    String? language,
  }) async {
    Response response = await _client.get(
      'discover/trending',
      queryParameters: {
        if (page != null) 'page': page,
        if (language != null) 'language': language,
      },
    );
    return SeerrSearchResults.fromJson(response.data);
  }
}
