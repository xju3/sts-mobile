// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parent.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Parent _$ParentFromJson(Map<String, dynamic> json) => Parent(
      id: json['id'] as String?,
      name: json['name'] as String?,
      accountId: json['accountId'] as String?,
      accountName: json['accountName'] as String?,
      role: json['role'] as String?,
      password: json['password'] as String?,
    );

Map<String, dynamic> _$ParentToJson(Parent instance) => <String, dynamic>{
      'id': instance.id,
      'accountId': instance.accountId,
      'name': instance.name,
      'accountName': instance.accountName,
      'role': instance.role,
      'password': instance.password,
    };
