import 'package:json_annotation/json_annotation.dart';

enum SeerrRequestStatus {
  @JsonValue(1)
  PENDING,

  @JsonValue(2)
  APPROVED,

  @JsonValue(3)
  DECLINED,

  @JsonValue(4)
  PROCESSING,

  @JsonValue(5)
  AVAILABLE,
}

extension SeerrRequestStatusExtension on SeerrRequestStatus {
  String get name {
    switch (this) {
      case SeerrRequestStatus.PENDING:
        return 'Pending';
      case SeerrRequestStatus.APPROVED:
        return 'Approved';
      case SeerrRequestStatus.DECLINED:
        return 'Declined';
      case SeerrRequestStatus.PROCESSING:
        return 'Processing';
      case SeerrRequestStatus.AVAILABLE:
        return 'Available';
    }
  }

  String get key {
    switch (this) {
      case SeerrRequestStatus.PENDING:
        return 'seerr.Pending';
      case SeerrRequestStatus.APPROVED:
        return 'seerr.Approved';
      case SeerrRequestStatus.DECLINED:
        return 'seerr.Declined';
      case SeerrRequestStatus.PROCESSING:
        return 'seerr.Processing';
      case SeerrRequestStatus.AVAILABLE:
        return 'seerr.Available';
    }
  }
}
