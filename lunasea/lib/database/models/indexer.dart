import 'package:arrpilot/core.dart';

part 'indexer.g.dart';

@JsonSerializable()
@HiveType(typeId: 1, adapterName: 'ArrPilotIndexerAdapter')
class ArrPilotIndexer extends HiveObject {
  @JsonKey()
  @HiveField(0, defaultValue: '')
  String displayName;

  @JsonKey()
  @HiveField(1, defaultValue: '')
  String host;

  @JsonKey(name: 'key')
  @HiveField(2, defaultValue: '')
  String apiKey;

  @JsonKey()
  @HiveField(3, defaultValue: <String, String>{})
  Map<String, String> headers;

  ArrPilotIndexer._internal({
    required this.displayName,
    required this.host,
    required this.apiKey,
    required this.headers,
  });

  factory ArrPilotIndexer({
    String? displayName,
    String? host,
    String? apiKey,
    Map<String, String>? headers,
  }) {
    return ArrPilotIndexer._internal(
      displayName: displayName ?? '',
      host: host ?? '',
      apiKey: apiKey ?? '',
      headers: headers ?? {},
    );
  }

  @override
  String toString() => json.encode(this.toJson());

  Map<String, dynamic> toJson() => _$ArrPilotIndexerToJson(this);

  factory ArrPilotIndexer.fromJson(Map<String, dynamic> json) {
    return _$ArrPilotIndexerFromJson(json);
  }

  factory ArrPilotIndexer.clone(ArrPilotIndexer profile) {
    return ArrPilotIndexer.fromJson(profile.toJson());
  }

  factory ArrPilotIndexer.get(String key) {
    return ArrPilotBox.indexers.read(key)!;
  }
}
