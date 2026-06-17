import 'package:json_annotation/json_annotation.dart';
import 'package:arrpilot/api/seerr/models/request.dart';

part 'user.g.dart';

@JsonSerializable()
class SeerrUser {
  @JsonKey(name: 'id')
  final int id;

  @JsonKey(name: 'email')
  final String email;

  @JsonKey(name: 'displayName')
  final String displayName;

  @JsonKey(name: 'avatar')
  final String? avatar;

  @JsonKey(name: 'permissions')
  final int permissions;

  @JsonKey(name: 'createdAt')
  final String createdAt;

  @JsonKey(name: 'updatedAt')
  final String updatedAt;

  @JsonKey(name: 'requestCount')
  final int? requestCount;

  SeerrUser({
    required this.id,
    required this.email,
    required this.displayName,
    this.avatar,
    required this.permissions,
    required this.createdAt,
    required this.updatedAt,
    this.requestCount,
  });

  factory SeerrUser.fromJson(Map<String, dynamic> json) =>
      _$SeerrUserFromJson(json);
  Map<String, dynamic> toJson() => _$SeerrUserToJson(this);
}

@JsonSerializable(explicitToJson: true)
class SeerrUserResults {
  @JsonKey(name: 'pageInfo')
  final SeerrPageInfo pageInfo;

  @JsonKey(name: 'results')
  final List<SeerrUser> results;

  SeerrUserResults({
    required this.pageInfo,
    required this.results,
  });

  factory SeerrUserResults.fromJson(Map<String, dynamic> json) =>
      _$SeerrUserResultsFromJson(json);
  Map<String, dynamic> toJson() => _$SeerrUserResultsToJson(this);
}
