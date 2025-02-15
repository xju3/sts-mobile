// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assignment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Assignment _$AssignmentFromJson(Map<String, dynamic> json) => Assignment(
      id: json['id'] as String?,
      studentId: json['studentId'] as String?,
      subject: json['subject'] as String?,
      points: json['points'] as String?,
      yearId: (json['yearId'] as num?)?.toInt(),
      weekId: (json['weekId'] as num?)?.toInt(),
      total: (json['total'] as num?)?.toInt(),
      easy: (json['easy'] as num?)?.toInt(),
      medium: (json['medium'] as num?)?.toInt(),
      hard: (json['hard'] as num?)?.toInt(),
      correct: (json['correct'] as num?)?.toInt(),
      status: (json['status'] as num?)?.toInt(),
    );

Map<String, dynamic> _$AssignmentToJson(Assignment instance) =>
    <String, dynamic>{
      'id': instance.id,
      'studentId': instance.studentId,
      'subject': instance.subject,
      'points': instance.points,
      'yearId': instance.yearId,
      'weekId': instance.weekId,
      'total': instance.total,
      'easy': instance.easy,
      'medium': instance.medium,
      'hard': instance.hard,
      'correct': instance.correct,
      'status': instance.status,
    };
