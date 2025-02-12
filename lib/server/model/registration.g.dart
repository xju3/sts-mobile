// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'registration.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Registration _$RegistrationFromJson(Map<String, dynamic> json) => Registration(
      parent: json['parent'] as String?,
      account: json['account'] as String?,
      student: json['student'] as String?,
      grade: json['grade'] as String?,
      schoolId: json['schoolId'] as String?,
      schoolName: json['schoolName'] as String?,
    );

Map<String, dynamic> _$RegistrationToJson(Registration instance) =>
    <String, dynamic>{
      'parent': instance.parent,
      'account': instance.account,
      'student': instance.student,
      'grade': instance.grade,
      'schoolId': instance.schoolId,
      'schoolName': instance.schoolName,
    };
