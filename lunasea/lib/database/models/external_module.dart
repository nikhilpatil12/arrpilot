import 'package:arrpilot/core.dart';

part 'external_module.g.dart';

@JsonSerializable()
@HiveType(typeId: 26, adapterName: 'ArrPilotExternalModuleAdapter')
class ArrPilotExternalModule extends HiveObject {
  @JsonKey()
  @HiveField(0, defaultValue: '')
  String displayName;

  @JsonKey()
  @HiveField(1, defaultValue: '')
  String host;

  ArrPilotExternalModule({
    this.displayName = '',
    this.host = '',
  });

  @override
  String toString() => json.encode(this.toJson());

  Map<String, dynamic> toJson() => _$ArrPilotExternalModuleToJson(this);

  factory ArrPilotExternalModule.fromJson(Map<String, dynamic> json) {
    return _$ArrPilotExternalModuleFromJson(json);
  }

  factory ArrPilotExternalModule.clone(ArrPilotExternalModule profile) {
    return ArrPilotExternalModule.fromJson(profile.toJson());
  }

  factory ArrPilotExternalModule.get(String key) {
    return ArrPilotBox.externalModules.read(key)!;
  }
}
