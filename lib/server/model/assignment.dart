import 'package:json_annotation/json_annotation.dart';

part 'assignment.g.dart';

@JsonSerializable()
class Assignment {
  String? id;
  String? studentId;
  String? subject;
  String? points;
  int? yearId;
  int? weekId;
  int? total;
  int? easy;
  int? medium;
  int? hard;
  int? correct;
  int? status;

  Assignment({
    this.id,
    this.studentId,
    this.subject,
    this.points,
    this.yearId,
    this.weekId,
    this.total,
    this.easy,
    this.medium,
    this.hard,
    this.correct,
    this.status,
  });

  factory Assignment.fromJson(Map<String, dynamic> json) =>
      _$AssignmentFromJson(json);

  Map<String, dynamic> toJson() => _$AssignmentToJson(this);
}
