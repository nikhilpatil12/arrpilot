import 'package:json_annotation/json_annotation.dart';

enum SeerrIssueType {
  @JsonValue(1)
  VIDEO,

  @JsonValue(2)
  AUDIO,

  @JsonValue(3)
  SUBTITLE,

  @JsonValue(4)
  OTHER,
}

extension SeerrIssueTypeExtension on SeerrIssueType {
  String get name {
    switch (this) {
      case SeerrIssueType.VIDEO:
        return 'Video';
      case SeerrIssueType.AUDIO:
        return 'Audio';
      case SeerrIssueType.SUBTITLE:
        return 'Subtitle';
      case SeerrIssueType.OTHER:
        return 'Other';
    }
  }

  String get key {
    switch (this) {
      case SeerrIssueType.VIDEO:
        return 'seerr.Video';
      case SeerrIssueType.AUDIO:
        return 'seerr.Audio';
      case SeerrIssueType.SUBTITLE:
        return 'seerr.Subtitle';
      case SeerrIssueType.OTHER:
        return 'seerr.Other';
    }
  }
}
