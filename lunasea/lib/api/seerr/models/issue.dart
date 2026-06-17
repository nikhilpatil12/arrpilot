import 'package:json_annotation/json_annotation.dart';
import 'package:arrpilot/api/seerr/types.dart';
import 'package:arrpilot/api/seerr/models/request.dart';

part 'issue.g.dart';

@JsonSerializable(explicitToJson: true)
class SeerrIssue {
  @JsonKey(name: 'id')
  final int id;

  @JsonKey(name: 'issueType')
  final SeerrIssueType issueType;

  @JsonKey(name: 'status')
  final SeerrIssueStatus status;

  @JsonKey(name: 'message')
  final String message;

  @JsonKey(name: 'createdBy')
  final SeerrRequestUser createdBy;

  @JsonKey(name: 'createdAt')
  final String createdAt;

  @JsonKey(name: 'updatedAt')
  final String updatedAt;

  @JsonKey(name: 'media')
  final SeerrIssueMedia media;

  SeerrIssue({
    required this.id,
    required this.issueType,
    required this.status,
    required this.message,
    required this.createdBy,
    required this.createdAt,
    required this.updatedAt,
    required this.media,
  });

  factory SeerrIssue.fromJson(Map<String, dynamic> json) =>
      _$SeerrIssueFromJson(json);
  Map<String, dynamic> toJson() => _$SeerrIssueToJson(this);
}

@JsonSerializable()
class SeerrIssueMedia {
  @JsonKey(name: 'id')
  final int id;

  @JsonKey(name: 'tmdbId')
  final int tmdbId;

  @JsonKey(name: 'mediaType')
  final String mediaType;

  SeerrIssueMedia({
    required this.id,
    required this.tmdbId,
    required this.mediaType,
  });

  factory SeerrIssueMedia.fromJson(Map<String, dynamic> json) =>
      _$SeerrIssueMediaFromJson(json);
  Map<String, dynamic> toJson() => _$SeerrIssueMediaToJson(this);
}

@JsonSerializable(explicitToJson: true)
class SeerrIssueResults {
  @JsonKey(name: 'pageInfo')
  final SeerrPageInfo pageInfo;

  @JsonKey(name: 'results')
  final List<SeerrIssue> results;

  SeerrIssueResults({
    required this.pageInfo,
    required this.results,
  });

  factory SeerrIssueResults.fromJson(Map<String, dynamic> json) =>
      _$SeerrIssueResultsFromJson(json);
  Map<String, dynamic> toJson() => _$SeerrIssueResultsToJson(this);
}
