// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReviewDetail _$ReviewDetailFromJson(Map<String, dynamic> json) => ReviewDetail(
      id: json['id'] as String?,
      requestAiId: json['requestAiId'] as String?,
      no: (json['no'] as num?)?.toInt(),
      ansStudent: json['ansStudent'] as String?,
      ansAi: json['ansAi'] as String?,
      conclusion: (json['conclusion'] as num?)?.toInt(),
      solution: json['solution'] as String?,
      knowledges: (json['knowledges'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      suggestions: json['suggestions'] as String?,
    );

Map<String, dynamic> _$ReviewDetailToJson(ReviewDetail instance) =>
    <String, dynamic>{
      'id': instance.id,
      'requestAiId': instance.requestAiId,
      'no': instance.no,
      'ansStudent': instance.ansStudent,
      'ansAi': instance.ansAi,
      'conclusion': instance.conclusion,
      'solution': instance.solution,
      'knowledges': instance.knowledges,
      'suggestions': instance.suggestions,
    };
