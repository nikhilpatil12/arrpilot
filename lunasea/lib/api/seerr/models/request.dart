import 'package:json_annotation/json_annotation.dart';
import 'package:arrpilot/api/seerr/types.dart';

part 'request.g.dart';

@JsonSerializable(explicitToJson: true)
class SeerrRequest {
  @JsonKey(name: 'id')
  final int id;

  @JsonKey(name: 'status')
  final SeerrRequestStatus status;

  @JsonKey(name: 'media')
  final SeerrRequestMedia media;

  @JsonKey(name: 'requestedBy')
  final SeerrRequestUser requestedBy;

  @JsonKey(name: 'modifiedBy')
  final SeerrRequestUser? modifiedBy;

  @JsonKey(name: 'createdAt')
  final String createdAt;

  @JsonKey(name: 'updatedAt')
  final String updatedAt;

  @JsonKey(name: 'type')
  final String type;

  @JsonKey(name: 'is4k')
  final bool is4k;

  @JsonKey(name: 'serverId')
  final int? serverId;

  @JsonKey(name: 'profileId')
  final int? profileId;

  @JsonKey(name: 'rootFolder')
  final String? rootFolder;

  SeerrRequest({
    required this.id,
    required this.status,
    required this.media,
    required this.requestedBy,
    this.modifiedBy,
    required this.createdAt,
    required this.updatedAt,
    required this.type,
    required this.is4k,
    this.serverId,
    this.profileId,
    this.rootFolder,
  });

  factory SeerrRequest.fromJson(Map<String, dynamic> json) =>
      _$SeerrRequestFromJson(json);
  Map<String, dynamic> toJson() => _$SeerrRequestToJson(this);
}

@JsonSerializable()
class SeerrRequestMedia {
  @JsonKey(name: 'id')
  final int id;

  @JsonKey(name: 'tmdbId')
  final int tmdbId;

  @JsonKey(name: 'mediaType')
  final String mediaType;

  @JsonKey(name: 'status')
  final SeerrMediaStatus status;

  SeerrRequestMedia({
    required this.id,
    required this.tmdbId,
    required this.mediaType,
    required this.status,
  });

  factory SeerrRequestMedia.fromJson(Map<String, dynamic> json) =>
      _$SeerrRequestMediaFromJson(json);
  Map<String, dynamic> toJson() => _$SeerrRequestMediaToJson(this);
}

@JsonSerializable()
class SeerrRequestUser {
  @JsonKey(name: 'id')
  final int id;

  @JsonKey(name: 'displayName')
  final String displayName;

  @JsonKey(name: 'avatar')
  final String? avatar;

  SeerrRequestUser({
    required this.id,
    required this.displayName,
    this.avatar,
  });

  factory SeerrRequestUser.fromJson(Map<String, dynamic> json) =>
      _$SeerrRequestUserFromJson(json);
  Map<String, dynamic> toJson() => _$SeerrRequestUserToJson(this);
}

@JsonSerializable(explicitToJson: true)
class SeerrRequestResults {
  @JsonKey(name: 'pageInfo')
  final SeerrPageInfo pageInfo;

  @JsonKey(name: 'results')
  final List<SeerrRequest> results;

  SeerrRequestResults({
    required this.pageInfo,
    required this.results,
  });

  factory SeerrRequestResults.fromJson(Map<String, dynamic> json) =>
      _$SeerrRequestResultsFromJson(json);
  Map<String, dynamic> toJson() => _$SeerrRequestResultsToJson(this);
}

@JsonSerializable()
class SeerrPageInfo {
  @JsonKey(name: 'pages')
  final int pages;

  @JsonKey(name: 'pageSize')
  final int pageSize;

  @JsonKey(name: 'results')
  final int results;

  @JsonKey(name: 'page')
  final int page;

  SeerrPageInfo({
    required this.pages,
    required this.pageSize,
    required this.results,
    required this.page,
  });

  factory SeerrPageInfo.fromJson(Map<String, dynamic> json) =>
      _$SeerrPageInfoFromJson(json);
  Map<String, dynamic> toJson() => _$SeerrPageInfoToJson(this);
}
