import 'package:json_annotation/json_annotation.dart';

part 'registration.g.dart';

@JsonSerializable()
class Registration {
  String? parent;
  String? account;
  String? student;
  String? grade;
  String? schoolId;
  String? schoolName;

  Registration({
    this.parent,
    this.account,
    this.student,
    this.grade,
    this.schoolId,
    this.schoolName,
  });

  factory Registration.fromJson(Map<String, dynamic> json) =>
      _$RegistrationFromJson(json);

  Map<String, dynamic> toJson() => _$RegistrationToJson(this);
}
