// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'http_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HttpResponse _$HttpResponseFromJson(Map<String, dynamic> json) => HttpResponse(
      code: json['code'] as String?,
      message: json['message'] as String?,
    );

Map<String, dynamic> _$HttpResponseToJson(HttpResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
    };
