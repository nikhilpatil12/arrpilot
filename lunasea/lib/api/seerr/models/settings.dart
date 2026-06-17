import 'package:json_annotation/json_annotation.dart';

part 'settings.g.dart';

@JsonSerializable()
class SeerrPublicSettings {
  @JsonKey(name: 'initialized')
  final bool initialized;

  @JsonKey(name: 'applicationTitle')
  final String applicationTitle;

  @JsonKey(name: 'applicationUrl')
  final String applicationUrl;

  @JsonKey(name: 'hideAvailable')
  final bool hideAvailable;

  @JsonKey(name: 'movie4kEnabled')
  final bool movie4kEnabled;

  @JsonKey(name: 'series4kEnabled')
  final bool series4kEnabled;

  SeerrPublicSettings({
    required this.initialized,
    required this.applicationTitle,
    required this.applicationUrl,
    required this.hideAvailable,
    required this.movie4kEnabled,
    required this.series4kEnabled,
  });

  factory SeerrPublicSettings.fromJson(Map<String, dynamic> json) =>
      _$SeerrPublicSettingsFromJson(json);
  Map<String, dynamic> toJson() => _$SeerrPublicSettingsToJson(this);
}

@JsonSerializable()
class SeerrSettings {
  @JsonKey(name: 'id')
  final int id;

  @JsonKey(name: 'applicationTitle')
  final String applicationTitle;

  @JsonKey(name: 'applicationUrl')
  final String applicationUrl;

  @JsonKey(name: 'hideAvailable')
  final bool hideAvailable;

  SeerrSettings({
    required this.id,
    required this.applicationTitle,
    required this.applicationUrl,
    required this.hideAvailable,
  });

  factory SeerrSettings.fromJson(Map<String, dynamic> json) =>
      _$SeerrSettingsFromJson(json);
  Map<String, dynamic> toJson() => _$SeerrSettingsToJson(this);
}

@JsonSerializable()
class SeerrStatus {
  @JsonKey(name: 'version')
  final String version;

  @JsonKey(name: 'commitTag')
  final String? commitTag;

  @JsonKey(name: 'updateAvailable')
  final bool updateAvailable;

  @JsonKey(name: 'commitsBehind')
  final int commitsBehind;

  SeerrStatus({
    required this.version,
    this.commitTag,
    required this.updateAvailable,
    required this.commitsBehind,
  });

  factory SeerrStatus.fromJson(Map<String, dynamic> json) =>
      _$SeerrStatusFromJson(json);
  Map<String, dynamic> toJson() => _$SeerrStatusToJson(this);
}
