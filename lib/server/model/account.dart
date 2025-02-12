import 'package:duowoo/server/model/parent.dart';
import 'package:duowoo/server/model/student.dart';
import 'package:json_annotation/json_annotation.dart';

part 'account.g.dart';

@JsonSerializable()
class AccountInfo {
  final Parent? parent;
  final List<Student>? students;

  AccountInfo({this.parent, this.students});

  factory AccountInfo.fromJson(Map<String, dynamic> json) =>
      _$AccountInfoFromJson(json);

  Map<String, dynamic> toJson() => _$AccountInfoToJson(this);
}
