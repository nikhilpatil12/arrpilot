import 'package:dio/dio.dart';
import 'package:arrpilot/api/seerr/models.dart';

/// Command handler for `/user` endpoints
class SeerrCommandHandlerUser {
  final Dio _client;

  SeerrCommandHandlerUser(this._client);

  /// Get all users
  ///
  /// Optional Parameters:
  /// - `take`: Number of results to return (default: 20)
  /// - `skip`: Number of results to skip (for pagination)
  Future<SeerrUserResults> getAll({
    int? take,
    int? skip,
  }) async {
    Response response = await _client.get(
      'user',
      queryParameters: {
        if (take != null) 'take': take,
        if (skip != null) 'skip': skip,
      },
    );
    return SeerrUserResults.fromJson(response.data);
  }

  /// Get a specific user by ID
  Future<SeerrUser> get(int userId) async {
    Response response = await _client.get('user/$userId');
    return SeerrUser.fromJson(response.data);
  }

  /// Get the current authenticated user
  Future<SeerrUser> getMe() async {
    Response response = await _client.get('auth/me');
    return SeerrUser.fromJson(response.data);
  }
}
