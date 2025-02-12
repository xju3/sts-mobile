import 'package:json_annotation/json_annotation.dart';

part 'login_history.g.dart';

@JsonSerializable()
class LoginHistory {
  String? parentId;
  String? notificationId;
  String? deviceId;

  LoginHistory({
    this.parentId,
    this.notificationId,
    this.deviceId,
  });

  factory LoginHistory.fromJson(Map<String, dynamic> json) =>
      _$LoginHistoryFromJson(json);

  Map<String, dynamic> toJson() => _$LoginHistoryToJson(this);
}
