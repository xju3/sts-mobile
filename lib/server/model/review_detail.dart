import 'package:json_annotation/json_annotation.dart';

part 'review_detail.g.dart';

@JsonSerializable()
class ReviewDetail {
  final String? id;
  final String? aiReviewId;
  final String? no;
  final String? ansStudent;
  final String? ansAi;
  final int? conclusion;
  final String? reason;
  final String? solution;
  final String? knowledge;
  final String? suggestion;

  ReviewDetail(
      {this.id,
      this.aiReviewId,
      this.no,
      this.ansStudent,
      this.ansAi,
      this.conclusion,
      this.reason,
      this.solution,
      this.knowledge,
      this.suggestion});

  factory ReviewDetail.fromJson(Map<String, dynamic> json) =>
      _$ReviewDetailFromJson(json);

  Map<String, dynamic> toJson() => _$ReviewDetailToJson(this);
}
