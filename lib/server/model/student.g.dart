// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'student.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Student _$StudentFromJson(Map<String, dynamic> json) => Student(
      id: json['id'] as String?,
      name: json['name'] as String?,
      schoolId: json['schoolId'] as String?,
      schoolName: json['schoolName'] as String?,
      grade: (json['grade'] as num?)?.toInt(),
    );

Map<String, dynamic> _$StudentToJson(Student instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'schoolId': instance.schoolId,
      'schoolName': instance.schoolName,
      'grade': instance.grade,
    };
