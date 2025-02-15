// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Question _$QuestionFromJson(Map<String, dynamic> json) => Question(
      id: json['id'] as String?,
      no: json['no'] as String?,
      question: json['question'] as String?,
      points: (json['points'] as num?)?.toDouble(),
      level: json['level'] as String?,
      options:
          (json['options'] as List<dynamic>?)?.map((e) => e as String).toList(),
      ansStudent: json['ansStudent'] as String?,
      ansAi: json['ansAi'] as String?,
      solution: json['solution'] as String?,
      genTime: json['genTime'] as String?,
      submitTime: json['submitTime'] as String?,
      status: json['status'] as String?,
      assignmentId: json['assignmentId'] as String?,
    );

Map<String, dynamic> _$QuestionToJson(Question instance) => <String, dynamic>{
      'id': instance.id,
      'no': instance.no,
      'question': instance.question,
      'points': instance.points,
      'level': instance.level,
      'options': instance.options,
      'ansStudent': instance.ansStudent,
      'ansAi': instance.ansAi,
      'solution': instance.solution,
      'genTime': instance.genTime,
      'submitTime': instance.submitTime,
      'status': instance.status,
      'assignmentId': instance.assignmentId,
    };
