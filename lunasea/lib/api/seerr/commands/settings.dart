import 'package:dio/dio.dart';
import 'package:arrpilot/api/seerr/models.dart';

/// Command handler for `/settings` endpoints
class SeerrCommandHandlerSettings {
  final Dio _client;

  SeerrCommandHandlerSettings(this._client);

  /// Get public settings (no authentication required)
  Future<SeerrPublicSettings> getPublic() async {
    Response response = await _client.get('settings/public');
    return SeerrPublicSettings.fromJson(response.data);
  }

  /// Get main settings
  Future<SeerrSettings> getMain() async {
    Response response = await _client.get('settings/main');
    return SeerrSettings.fromJson(response.data);
  }

  /// Get status/about information
  Future<SeerrStatus> getStatus() async {
    Response response = await _client.get('status');
    return SeerrStatus.fromJson(response.data);
  }
}
