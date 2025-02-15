
import 'package:json_annotation/json_annotation.dart';
part 'app_version.g.dart';
@JsonSerializable()
class AppVersion {
  String? version;
  String? changeLog;

  AppVersion(this.version, this.changeLog);

  factory AppVersion.fromJson(Map<String, dynamic> json) => _$AppVersionFromJson(json);

  Map<String, dynamic> toJson() => _$AppVersionToJson(this);
}