// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Result _$ResultFromJson(Map<String, dynamic> json) => Result(
      err: json['err'] == null
          ? null
          : ErrMsg.fromJson(json['err'] as Map<String, dynamic>),
      data: json['data'],
    );

Map<String, dynamic> _$ResultToJson(Result instance) => <String, dynamic>{
      'err': instance.err,
      'data': instance.data,
    };
