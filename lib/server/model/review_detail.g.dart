// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReviewDetail _$ReviewDetailFromJson(Map<String, dynamic> json) => ReviewDetail(
      id: json['id'] as String?,
      aiReviewId: json['aiReviewId'] as String?,
      no: json['no'] as String?,
      ansStudent: json['ansStudent'] as String?,
      ansAi: json['ansAi'] as String?,
      conclusion: (json['conclusion'] as num?)?.toInt(),
      solution: json['solution'] as String?,
      knowledge: json['knowledge'] as String?,
      suggestion: json['suggestion'] as String?,
    );

Map<String, dynamic> _$ReviewDetailToJson(ReviewDetail instance) =>
    <String, dynamic>{
      'id': instance.id,
      'aiReviewId': instance.aiReviewId,
      'no': instance.no,
      'ansStudent': instance.ansStudent,
      'ansAi': instance.ansAi,
      'conclusion': instance.conclusion,
      'solution': instance.solution,
      'knowledge': instance.knowledge,
      'suggestion': instance.suggestion,
    };
