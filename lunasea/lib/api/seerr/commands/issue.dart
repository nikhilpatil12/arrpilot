import 'package:dio/dio.dart';
import 'package:arrpilot/api/seerr/models.dart';

/// Command handler for `/issue` endpoints
class SeerrCommandHandlerIssue {
  final Dio _client;

  SeerrCommandHandlerIssue(this._client);

  /// Get all issues with optional filtering
  ///
  /// Optional Parameters:
  /// - `take`: Number of results to return (default: 20)
  /// - `skip`: Number of results to skip (for pagination)
  /// - `filter`: Filter by status (open, resolved)
  Future<SeerrIssueResults> getAll({
    int? take,
    int? skip,
    String? filter,
  }) async {
    Response response = await _client.get(
      'issue',
      queryParameters: {
        if (take != null) 'take': take,
        if (skip != null) 'skip': skip,
        if (filter != null) 'filter': filter,
      },
    );
    return SeerrIssueResults.fromJson(response.data);
  }

  /// Get a specific issue by ID
  Future<SeerrIssue> get(int issueId) async {
    Response response = await _client.get('issue/$issueId');
    return SeerrIssue.fromJson(response.data);
  }

  /// Create a new issue
  ///
  /// Required Parameters:
  /// - `issueType`: Type of issue (video, audio, subtitle, other)
  /// - `message`: Issue description
  /// - `mediaId`: ID of the media this issue is for
  Future<SeerrIssue> create({
    required String issueType,
    required String message,
    required int mediaId,
  }) async {
    Response response = await _client.post(
      'issue',
      data: {
        'issueType': issueType,
        'message': message,
        'mediaId': mediaId,
      },
    );
    return SeerrIssue.fromJson(response.data);
  }

  /// Resolve an issue
  Future<SeerrIssue> resolve(int issueId) async {
    Response response = await _client.post('issue/$issueId/resolved');
    return SeerrIssue.fromJson(response.data);
  }

  /// Delete an issue
  Future<void> delete(int issueId) async {
    await _client.delete('issue/$issueId');
  }
}
