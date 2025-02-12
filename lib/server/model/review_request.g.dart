// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReviewRequest _$ReviewRequestFromJson(Map<String, dynamic> json) =>
    ReviewRequest(
      id: json['id'] as String?,
      studentId: json['studentId'] as String?,
      images: (json['images'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ReviewRequestToJson(ReviewRequest instance) =>
    <String, dynamic>{
      'id': instance.id,
      'studentId': instance.studentId,
      'images': instance.images,
    };
