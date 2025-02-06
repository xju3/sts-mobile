
import 'package:json_annotation/json_annotation.dart';

part 'request_info.g.dart';

@JsonSerializable()
class RequestInfo {
  final String? id;
  final String? studentId;
  @JsonKey(name: 'transTime')
  final DateTime? transTime;
  final String? status;

  RequestInfo({this.id, this.studentId, this.transTime, this.status});

  factory RequestInfo.fromJson(Map<String, dynamic> json) =>
      _$RequestInfoFromJson(json);

  Map<String, dynamic> toJson() => _$RequestInfoToJson(this);
}
