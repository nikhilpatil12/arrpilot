import 'package:json_annotation/json_annotation.dart';

enum SeerrMediaStatus {
  @JsonValue(1)
  UNKNOWN,

  @JsonValue(2)
  PENDING,

  @JsonValue(3)
  PROCESSING,

  @JsonValue(4)
  PARTIALLY_AVAILABLE,

  @JsonValue(5)
  AVAILABLE,
}

extension SeerrMediaStatusExtension on SeerrMediaStatus {
  String get name {
    switch (this) {
      case SeerrMediaStatus.UNKNOWN:
        return 'Unknown';
      case SeerrMediaStatus.PENDING:
        return 'Pending';
      case SeerrMediaStatus.PROCESSING:
        return 'Processing';
      case SeerrMediaStatus.PARTIALLY_AVAILABLE:
        return 'Partially Available';
      case SeerrMediaStatus.AVAILABLE:
        return 'Available';
    }
  }

  String get key {
    switch (this) {
      case SeerrMediaStatus.UNKNOWN:
        return 'seerr.Unknown';
      case SeerrMediaStatus.PENDING:
        return 'seerr.Pending';
      case SeerrMediaStatus.PROCESSING:
        return 'seerr.Processing';
      case SeerrMediaStatus.PARTIALLY_AVAILABLE:
        return 'seerr.PartiallyAvailable';
      case SeerrMediaStatus.AVAILABLE:
        return 'seerr.Available';
    }
  }
}
