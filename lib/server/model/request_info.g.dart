// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RequestInfo _$RequestInfoFromJson(Map<String, dynamic> json) => RequestInfo(
      id: json['id'] as String?,
      studentId: json['studentId'] as String?,
      transTime: json['transTime'] == null
          ? null
          : DateTime.parse(json['transTime'] as String),
      status: json['status'] as String?,
    );

Map<String, dynamic> _$RequestInfoToJson(RequestInfo instance) =>
    <String, dynamic>{
      'id': instance.id,
      'studentId': instance.studentId,
      'transTime': instance.transTime?.toIso8601String(),
      'status': instance.status,
    };
