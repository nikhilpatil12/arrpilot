import 'package:json_annotation/json_annotation.dart';
import 'package:arrpilot/api/seerr/types.dart';

part 'media.g.dart';

@JsonSerializable()
class SeerrMovie {
  @JsonKey(name: 'id')
  final int id;

  @JsonKey(name: 'title')
  final String title;

  @JsonKey(name: 'originalTitle')
  final String? originalTitle;

  @JsonKey(name: 'overview')
  final String? overview;

  @JsonKey(name: 'releaseDate')
  final String? releaseDate;

  @JsonKey(name: 'posterPath')
  final String? posterPath;

  @JsonKey(name: 'backdropPath')
  final String? backdropPath;

  @JsonKey(name: 'voteAverage')
  final double? voteAverage;

  @JsonKey(name: 'voteCount')
  final int? voteCount;

  @JsonKey(name: 'mediaInfo')
  final SeerrMediaInfo? mediaInfo;

  SeerrMovie({
    required this.id,
    required this.title,
    this.originalTitle,
    this.overview,
    this.releaseDate,
    this.posterPath,
    this.backdropPath,
    this.voteAverage,
    this.voteCount,
    this.mediaInfo,
  });

  factory SeerrMovie.fromJson(Map<String, dynamic> json) =>
      _$SeerrMovieFromJson(json);
  Map<String, dynamic> toJson() => _$SeerrMovieToJson(this);
}

@JsonSerializable()
class SeerrTVShow {
  @JsonKey(name: 'id')
  final int id;

  @JsonKey(name: 'name')
  final String name;

  @JsonKey(name: 'originalName')
  final String? originalName;

  @JsonKey(name: 'overview')
  final String? overview;

  @JsonKey(name: 'firstAirDate')
  final String? firstAirDate;

  @JsonKey(name: 'posterPath')
  final String? posterPath;

  @JsonKey(name: 'backdropPath')
  final String? backdropPath;

  @JsonKey(name: 'voteAverage')
  final double? voteAverage;

  @JsonKey(name: 'voteCount')
  final int? voteCount;

  @JsonKey(name: 'numberOfSeasons')
  final int? numberOfSeasons;

  @JsonKey(name: 'numberOfEpisodes')
  final int? numberOfEpisodes;

  @JsonKey(name: 'mediaInfo')
  final SeerrMediaInfo? mediaInfo;

  SeerrTVShow({
    required this.id,
    required this.name,
    this.originalName,
    this.overview,
    this.firstAirDate,
    this.posterPath,
    this.backdropPath,
    this.voteAverage,
    this.voteCount,
    this.numberOfSeasons,
    this.numberOfEpisodes,
    this.mediaInfo,
  });

  factory SeerrTVShow.fromJson(Map<String, dynamic> json) =>
      _$SeerrTVShowFromJson(json);
  Map<String, dynamic> toJson() => _$SeerrTVShowToJson(this);
}

@JsonSerializable()
class SeerrMediaInfo {
  @JsonKey(name: 'id')
  final int id;

  @JsonKey(name: 'tmdbId')
  final int tmdbId;

  @JsonKey(name: 'status')
  final SeerrMediaStatus status;

  @JsonKey(name: 'requests')
  final List<int>? requests;

  SeerrMediaInfo({
    required this.id,
    required this.tmdbId,
    required this.status,
    this.requests,
  });

  factory SeerrMediaInfo.fromJson(Map<String, dynamic> json) =>
      _$SeerrMediaInfoFromJson(json);
  Map<String, dynamic> toJson() => _$SeerrMediaInfoToJson(this);
}

@JsonSerializable()
class SeerrSearchResult {
  @JsonKey(name: 'id')
  final int id;

  @JsonKey(name: 'mediaType')
  final String mediaType;

  @JsonKey(name: 'title')
  final String? title;

  @JsonKey(name: 'name')
  final String? name;

  @JsonKey(name: 'posterPath')
  final String? posterPath;

  @JsonKey(name: 'releaseDate')
  final String? releaseDate;

  @JsonKey(name: 'firstAirDate')
  final String? firstAirDate;

  @JsonKey(name: 'mediaInfo')
  final SeerrMediaInfo? mediaInfo;

  SeerrSearchResult({
    required this.id,
    required this.mediaType,
    this.title,
    this.name,
    this.posterPath,
    this.releaseDate,
    this.firstAirDate,
    this.mediaInfo,
  });

  factory SeerrSearchResult.fromJson(Map<String, dynamic> json) =>
      _$SeerrSearchResultFromJson(json);
  Map<String, dynamic> toJson() => _$SeerrSearchResultToJson(this);
}

@JsonSerializable(explicitToJson: true)
class SeerrSearchResults {
  @JsonKey(name: 'page')
  final int page;

  @JsonKey(name: 'totalPages')
  final int totalPages;

  @JsonKey(name: 'totalResults')
  final int totalResults;

  @JsonKey(name: 'results')
  final List<SeerrSearchResult> results;

  SeerrSearchResults({
    required this.page,
    required this.totalPages,
    required this.totalResults,
    required this.results,
  });

  factory SeerrSearchResults.fromJson(Map<String, dynamic> json) =>
      _$SeerrSearchResultsFromJson(json);
  Map<String, dynamic> toJson() => _$SeerrSearchResultsToJson(this);
}
