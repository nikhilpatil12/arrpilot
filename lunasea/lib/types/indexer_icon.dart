import 'package:flutter/material.dart';
import 'package:arrpilot/core.dart';

part 'indexer_icon.g.dart';

const _GENERIC = 'generic';
const _DOGNZB = 'dognzb';
const _DRUNKENSLUG = 'drunkenslug';
const _NZBFINDER = 'nzbfinder';
const _NZBGEEK = 'nzbgeek';
const _NZBHYDRA = 'nzbhydra';
const _NZBSU = 'nzbsu';

@JsonEnum()
@HiveType(typeId: 22, adapterName: 'ArrPilotIndexerIconAdapter')
enum ArrPilotIndexerIcon {
  @JsonValue(_GENERIC)
  @HiveField(0)
  GENERIC(_GENERIC),

  @JsonValue(_DOGNZB)
  @HiveField(1)
  DOGNZB(_DOGNZB),

  @JsonValue(_DRUNKENSLUG)
  @HiveField(2)
  DRUNKENSLUG(_DRUNKENSLUG),

  @JsonValue(_NZBFINDER)
  @HiveField(3)
  NZBFINDER(_NZBFINDER),

  @JsonValue(_NZBGEEK)
  @HiveField(4)
  NZBGEEK(_NZBGEEK),

  @JsonValue(_NZBHYDRA)
  @HiveField(5)
  NZBHYDRA(_NZBHYDRA),

  @JsonValue(_NZBSU)
  @HiveField(6)
  NZBSU(_NZBSU);

  final String key;
  const ArrPilotIndexerIcon(this.key);

  static ArrPilotIndexerIcon fromKey(String key) {
    switch (key) {
      case _DOGNZB:
        return ArrPilotIndexerIcon.DOGNZB;
      case _DRUNKENSLUG:
        return ArrPilotIndexerIcon.DRUNKENSLUG;
      case _NZBFINDER:
        return ArrPilotIndexerIcon.NZBFINDER;
      case _NZBGEEK:
        return ArrPilotIndexerIcon.NZBGEEK;
      case _NZBHYDRA:
        return ArrPilotIndexerIcon.NZBHYDRA;
      case _NZBSU:
        return ArrPilotIndexerIcon.NZBSU;
      default:
        return ArrPilotIndexerIcon.GENERIC;
    }
  }

  String get name {
    switch (this) {
      case ArrPilotIndexerIcon.GENERIC:
        return 'Generic';
      case ArrPilotIndexerIcon.DOGNZB:
        return 'DOGnzb';
      case ArrPilotIndexerIcon.DRUNKENSLUG:
        return 'DrunkenSlug';
      case ArrPilotIndexerIcon.NZBFINDER:
        return 'NZBFinder';
      case ArrPilotIndexerIcon.NZBGEEK:
        return 'NZBGeek';
      case ArrPilotIndexerIcon.NZBHYDRA:
        return 'NZBHydra2';
      case ArrPilotIndexerIcon.NZBSU:
        return 'NZB.su';
    }
  }

  IconData get icon {
    switch (this) {
      case ArrPilotIndexerIcon.GENERIC:
        return Icons.rss_feed_rounded;
      case ArrPilotIndexerIcon.DOGNZB:
        return Icons.rss_feed_rounded;
      case ArrPilotIndexerIcon.DRUNKENSLUG:
        return Icons.rss_feed_rounded;
      case ArrPilotIndexerIcon.NZBFINDER:
        return Icons.rss_feed_rounded;
      case ArrPilotIndexerIcon.NZBGEEK:
        return Icons.rss_feed_rounded;
      case ArrPilotIndexerIcon.NZBHYDRA:
        return Icons.rss_feed_rounded;
      case ArrPilotIndexerIcon.NZBSU:
        return Icons.rss_feed_rounded;
    }
  }
}
