import 'package:json_annotation/json_annotation.dart';

part 'student.g.dart';

@JsonSerializable()
class Student {
  String? id;
  String? name;
  String? schoolId;
  String? schoolName;
  int? grade;

  Student({this.id, this.name, this.schoolId, this.schoolName, this.grade});

  factory Student.fromJson(Map<String, dynamic> json) =>
      _$StudentFromJson(json);

  Map<String, dynamic> toJson() => _$StudentToJson(this);
}
