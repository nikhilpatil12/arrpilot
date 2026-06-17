/// Dart library package to facilitate communication with [Seerr](https://seerr.dev)'s API:
/// A media request management tool for Plex, Jellyfin, and Emby.
///
/// This library gives access to [seerr_commands], and is needed as the only entrypoint.

// Imports
import 'package:dio/dio.dart';
import 'package:arrpilot/api/seerr/commands.dart';

/// The core class to handle all connections to Seerr.
/// Gives you easy access to all implemented command handlers, initialized and ready to call.
///
/// [SeerrAPI] handles the creation of the initial [Dio] HTTP client & command handlers.
/// You can optionally use the factory `.from()` to define your own [Dio] HTTP client.
class SeerrAPI {
  /// Internal constructor
  SeerrAPI._internal({
    required this.httpClient,
    required this.request,
    required this.media,
    required this.user,
    required this.issue,
    required this.settings,
  });

  /// Create a new Seerr API connection manager to connect to your instance.
  /// This default factory/constructor will create the [Dio] HTTP client for you given the parameters.
  ///
  /// Required Parameters:
  /// - `host`: String that contains the protocol (http:// or https://), the host itself, and the base URL (if applicable)
  /// - `apiKey`: The API key fetched from Seerr's web interface
  ///
  /// Optional Parameters:
  /// - `headers`: Map that contains additional headers that should be attached to all requests
  /// - `followRedirects`: If the HTTP client should follow URL redirects
  /// - `maxRedirects`: The maximum amount of redirects the client should follow (does nothing if `followRedirects` is false)
  factory SeerrAPI({
    required String host,
    required String apiKey,
    Map<String, dynamic>? headers,
    bool followRedirects = true,
    int maxRedirects = 5,
  }) {
    // Build the HTTP client
    Dio _dio = Dio(
      BaseOptions(
        baseUrl: host.endsWith('/') ? '${host}api/v1/' : '$host/api/v1/',
        headers: {
          'X-Api-Key': apiKey,
          ...?headers,
        },
        followRedirects: followRedirects,
        maxRedirects: maxRedirects,
        contentType: Headers.jsonContentType,
        responseType: ResponseType.json,
      ),
    );
    return SeerrAPI._internal(
      httpClient: _dio,
      request: SeerrCommandHandlerRequest(_dio),
      media: SeerrCommandHandlerMedia(_dio),
      user: SeerrCommandHandlerUser(_dio),
      issue: SeerrCommandHandlerIssue(_dio),
      settings: SeerrCommandHandlerSettings(_dio),
    );
  }

  /// Create a new Seerr API connection manager with a pre-configured [Dio] HTTP client.
  ///
  /// Required Parameters:
  /// - `client`: A pre-configured [Dio] HTTP client
  factory SeerrAPI.from({
    required Dio client,
  }) {
    return SeerrAPI._internal(
      httpClient: client,
      request: SeerrCommandHandlerRequest(client),
      media: SeerrCommandHandlerMedia(client),
      user: SeerrCommandHandlerUser(client),
      issue: SeerrCommandHandlerIssue(client),
      settings: SeerrCommandHandlerSettings(client),
    );
  }

  /// The [Dio] HTTP client built during initialization.
  ///
  /// Making changes to the [Dio] client should propagate to the command handlers, but is not recommended.
  final Dio httpClient;

  /// Command handler for `/request`: Request management
  final SeerrCommandHandlerRequest request;

  /// Command handler for `/search`, `/movie`, `/tv`: Media search and details
  final SeerrCommandHandlerMedia media;

  /// Command handler for `/user`: User management
  final SeerrCommandHandlerUser user;

  /// Command handler for `/issue`: Issue tracking
  final SeerrCommandHandlerIssue issue;

  /// Command handler for `/settings`: Settings management
  final SeerrCommandHandlerSettings settings;
}
