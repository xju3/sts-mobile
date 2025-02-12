// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReviewDetail _$ReviewDetailFromJson(Map<String, dynamic> json) => ReviewDetail(
      id: json['id'] as String?,
      aiReviewId: json['aiReviewId'] as String?,
      no: json['no'] as String?,
      question: json['question'] as String?,
      options: json['options'] as String?,
      ansStudent: json['ansStudent'] as String?,
      ansAi: json['ansAi'] as String?,
      conclusion: (json['conclusion'] as num?)?.toInt(),
      reason: json['reason'] as String?,
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
      'question': instance.question,
      'options': instance.options,
      'ansAi': instance.ansAi,
      'conclusion': instance.conclusion,
      'reason': instance.reason,
      'solution': instance.solution,
      'knowledge': instance.knowledge,
      'suggestion': instance.suggestion,
    };
