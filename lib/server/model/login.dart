import 'package:json_annotation/json_annotation.dart';

part 'login.g.dart';

@JsonSerializable()
class Login {
  String? account;
  String? password;

  Login({this.account, this.password});

  factory Login.fromJson(Map<String, dynamic> json) => _$LoginFromJson(json);

  Map<String, dynamic> toJson() => _$LoginToJson(this);
}
