// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccountInfo _$AccountInfoFromJson(Map<String, dynamic> json) => AccountInfo(
      id: json['id'] as String?,
      parentId: json['parentId'] as String?,
      parentName: json['parentName'] as String?,
      students: (json['students'] as List<dynamic>?)
          ?.map((e) => Student.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AccountInfoToJson(AccountInfo instance) =>
    <String, dynamic>{
      'id': instance.id,
      'parentId': instance.parentId,
      'parentName': instance.parentName,
      'students': instance.students,
    };
