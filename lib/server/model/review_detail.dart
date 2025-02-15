import 'package:json_annotation/json_annotation.dart';

part 'review_detail.g.dart';

@JsonSerializable()
class ReviewDetail {
   String? id;
   String? aiReviewId;
   String? no;
   String? ansStudent;
   String? question;
   String? options;
   String? ansAi;
   int? conclusion;
   String? reason;
   String? solution;
   String? knowledge;
   String? suggestion;
   int? err;

  ReviewDetail(
      {this.id,
      this.aiReviewId,
      this.no,
      this.question,
      this.options,
      this.ansStudent,
      this.ansAi,
      this.conclusion,
      this.reason,
      this.solution,
      this.knowledge,
        this.err,
      this.suggestion});

  factory ReviewDetail.fromJson(Map<String, dynamic> json) =>
      _$ReviewDetailFromJson(json);

  Map<String, dynamic> toJson() => _$ReviewDetailToJson(this);
}
