import 'package:json_annotation/json_annotation.dart';

part 'registration.g.dart';

@JsonSerializable()
class Registration {
  String? parent;
  String? mobile;
  String? student;
  String? grade;
  String? schoolId;
  String? school;

  Registration({
    this.schoolId,
    this.school,
    this.parent,
    this.mobile,
    this.student,
    this.grade,
  });

  factory Registration.fromJson(Map<String, dynamic> json) =>
      _$RegistrationFromJson(json);

  Map<String, dynamic> toJson() => _$RegistrationToJson(this);
}
