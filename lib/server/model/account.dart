import 'package:duowoo/server/model/student.dart';
import 'package:json_annotation/json_annotation.dart';

part 'account.g.dart';

@JsonSerializable()
class AccountInfo {
  final String? id;
  final String? parentId;
  final String? parentName;
  final List<Student>? students;

  AccountInfo({this.id, this.parentId, this.parentName, this.students});

  factory AccountInfo.fromJson(Map<String, dynamic> json) =>
      _$AccountInfoFromJson(json);

  Map<String, dynamic> toJson() => _$AccountInfoToJson(this);
}
