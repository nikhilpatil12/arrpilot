import 'package:dio/dio.dart';
import 'package:arrpilot/api/seerr/models.dart';

/// Command handler for `/request` endpoints
class SeerrCommandHandlerRequest {
  final Dio _client;

  SeerrCommandHandlerRequest(this._client);

  /// Get all requests with optional filtering
  ///
  /// Optional Parameters:
  /// - `take`: Number of results to return (default: 20)
  /// - `skip`: Number of results to skip (for pagination)
  /// - `filter`: Filter by status (all, approved, available, pending, processing, unavailable)
  /// - `sort`: Sort order (added, modified)
  Future<SeerrRequestResults> getAll({
    int? take,
    int? skip,
    String? filter,
    String? sort,
  }) async {
    Response response = await _client.get(
      'request',
      queryParameters: {
        if (take != null) 'take': take,
        if (skip != null) 'skip': skip,
        if (filter != null) 'filter': filter,
        if (sort != null) 'sort': sort,
      },
    );
    return SeerrRequestResults.fromJson(response.data);
  }

  /// Get a specific request by ID
  Future<SeerrRequest> get(int requestId) async {
    Response response = await _client.get('request/$requestId');
    return SeerrRequest.fromJson(response.data);
  }

  /// Create a new media request
  ///
  /// Required Parameters:
  /// - `mediaType`: Type of media ('movie' or 'tv')
  /// - `mediaId`: TMDB ID of the media
  ///
  /// Optional Parameters:
  /// - `seasons`: List of season numbers to request (TV only)
  /// - `is4k`: Request 4K quality
  /// - `serverId`: Specific server to use for Radarr/Sonarr
  /// - `profileId`: Specific quality profile to use
  /// - `rootFolder`: Specific root folder to use
  Future<SeerrRequest> create({
    required String mediaType,
    required int mediaId,
    List<int>? seasons,
    bool? is4k,
    int? serverId,
    int? profileId,
    String? rootFolder,
  }) async {
    Response response = await _client.post(
      'request',
      data: {
        'mediaType': mediaType,
        'mediaId': mediaId,
        if (seasons != null) 'seasons': seasons,
        if (is4k != null) 'is4k': is4k,
        if (serverId != null) 'serverId': serverId,
        if (profileId != null) 'profileId': profileId,
        if (rootFolder != null) 'rootFolder': rootFolder,
      },
    );
    return SeerrRequest.fromJson(response.data);
  }

  /// Delete a request
  Future<void> delete(int requestId) async {
    await _client.delete('request/$requestId');
  }

  /// Approve a request
  Future<SeerrRequest> approve(int requestId) async {
    Response response = await _client.post('request/$requestId/approve');
    return SeerrRequest.fromJson(response.data);
  }

  /// Decline a request
  Future<SeerrRequest> decline(int requestId) async {
    Response response = await _client.post('request/$requestId/decline');
    return SeerrRequest.fromJson(response.data);
  }

  /// Retry a failed request
  Future<SeerrRequest> retry(int requestId) async {
    Response response = await _client.post('request/$requestId/retry');
    return SeerrRequest.fromJson(response.data);
  }
}
