// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'registration.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Registration _$RegistrationFromJson(Map<String, dynamic> json) => Registration(
      schoolId: json['schoolId'] as String?,
      school: json['school'] as String?,
      parent: json['parent'] as String?,
      mobile: json['mobile'] as String?,
      student: json['student'] as String?,
      grade: json['grade'] as String?,
    );

Map<String, dynamic> _$RegistrationToJson(Registration instance) =>
    <String, dynamic>{
      'parent': instance.parent,
      'mobile': instance.mobile,
      'student': instance.student,
      'grade': instance.grade,
      'schoolId': instance.schoolId,
      'school': instance.school,
    };
