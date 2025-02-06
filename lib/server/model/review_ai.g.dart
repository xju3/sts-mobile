// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review_ai.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReviewAi _$ReviewAiFromJson(Map<String, dynamic> json) => ReviewAi(
      id: json['id'] as String?,
      requestId: json['requestId'] as String?,
      startTime: json['startTime'] == null
          ? null
          : DateTime.parse(json['startTime'] as String),
      endTime: json['endTime'] == null
          ? null
          : DateTime.parse(json['endTime'] as String),
      subject: json['subject'] as String?,
      total: (json['total'] as num?)?.toInt(),
      correct: (json['correct'] as num?)?.toInt(),
      incorrect: (json['incorrect'] as num?)?.toInt(),
      uncertain: (json['uncertain'] as num?)?.toInt(),
      summary: json['summary'] as String?,
      details: (json['details'] as List<dynamic>?)
          ?.map((e) => ReviewDetail.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ReviewAiToJson(ReviewAi instance) => <String, dynamic>{
      'id': instance.id,
      'requestId': instance.requestId,
      'startTime': instance.startTime?.toIso8601String(),
      'endTime': instance.endTime?.toIso8601String(),
      'subject': instance.subject,
      'total': instance.total,
      'correct': instance.correct,
      'incorrect': instance.incorrect,
      'uncertain': instance.uncertain,
      'summary': instance.summary,
      'details': instance.details,
    };
