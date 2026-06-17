import 'package:json_annotation/json_annotation.dart';

enum SeerrIssueStatus {
  @JsonValue(1)
  OPEN,

  @JsonValue(2)
  RESOLVED,
}

extension SeerrIssueStatusExtension on SeerrIssueStatus {
  String get name {
    switch (this) {
      case SeerrIssueStatus.OPEN:
        return 'Open';
      case SeerrIssueStatus.RESOLVED:
        return 'Resolved';
    }
  }

  String get key {
    switch (this) {
      case SeerrIssueStatus.OPEN:
        return 'seerr.Open';
      case SeerrIssueStatus.RESOLVED:
        return 'seerr.Resolved';
    }
  }
}
