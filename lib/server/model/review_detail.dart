import 'package:json_annotation/json_annotation.dart';

part 'review_detail.g.dart';

@JsonSerializable()
class ReviewDetail {
  final String? id;
  @JsonKey(name: 'requestAiId')
  final String? requestAiId;
  final int? no;
  @JsonKey(name: 'ansStudent')
  final String? ansStudent;
  @JsonKey(name: 'ansAi')
  final String? ansAi;
  final int? conclusion;
  final String? solution;
  final List<String>? knowledges;
  final String? suggestions;

  ReviewDetail(
      {this.id,
      this.requestAiId,
      this.no,
      this.ansStudent,
      this.ansAi,
      this.conclusion,
      this.solution,
      this.knowledges,
      this.suggestions});

  factory ReviewDetail.fromJson(Map<String, dynamic> json) =>
      _$ReviewDetailFromJson(json);

  Map<String, dynamic> toJson() => _$ReviewDetailToJson(this);
}
