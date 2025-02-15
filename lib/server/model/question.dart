import 'package:json_annotation/json_annotation.dart';

part 'question.g.dart';

@JsonSerializable()
class Question {
  String? id;
  String? no;
  String? question;
  double? points;
  String? level;
  List<String>? options;
  String? ansStudent;
  String? ansAi;
  String? solution;
  String? genTime;
  String? submitTime;
  String? status;
  String? assignmentId;

  Question({
    this.id,
    this.no,
    this.question,
    this.points,
    this.level,
    this.options,
    this.ansStudent,
    this.ansAi,
    this.solution,
    this.genTime,
    this.submitTime,
    this.status,
    this.assignmentId,
  });

  factory Question.fromJson(Map<String, dynamic> json) =>
      _$QuestionFromJson(json);

  Map<String, dynamic> toJson() => _$QuestionToJson(this);
}

