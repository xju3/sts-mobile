// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'school.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

School _$SchoolFromJson(Map<String, dynamic> json) => School(
      id: json['id'] as String?,
      shortName: json['shortName'] as String?,
      fullName: json['fullName'] as String?,
      addr: json['addr'] as String?,
      lat: (json['lat'] as num?)?.toDouble(),
      lng: (json['lng'] as num?)?.toDouble(),
      phone: json['phone'] as String?,
    );

Map<String, dynamic> _$SchoolToJson(School instance) => <String, dynamic>{
      'id': instance.id,
      'shortName': instance.shortName,
      'fullName': instance.fullName,
      'addr': instance.addr,
      'lat': instance.lat,
      'lng': instance.lng,
      'phone': instance.phone,
    };
