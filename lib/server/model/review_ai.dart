import 'package:json_annotation/json_annotation.dart';
import 'package:jiwa/server/model/review_detail.dart';

part 'review_ai.g.dart';

@JsonSerializable()
class ReviewAi {
  String? id;
  String? requestId;
  @JsonKey(name: 'startTime')
  DateTime? startTime;
  @JsonKey(name: 'endTime')
  DateTime? endTime;
  String? subject;
  int? total;
  int? correct;
  int? incorrect;
  int? uncertain;
  String? summary;
  List<ReviewDetail>? details;

  ReviewAi(
      {this.id,
      this.requestId,
      this.startTime,
      this.endTime,
      this.subject,
      this.total,
      this.correct,
      this.incorrect,
      this.uncertain,
      this.summary,
      this.details});

  factory ReviewAi.fromJson(Map<String, dynamic> json) =>
      _$ReviewAiFromJson(json);

  Map<String, dynamic> toJson() => _$ReviewAiToJson(this);
}
