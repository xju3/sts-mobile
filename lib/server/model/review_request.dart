import 'package:json_annotation/json_annotation.dart';

part 'review_request.g.dart';

@JsonSerializable()
class ReviewRequest {
  String? id;
  String? studentId;
  int? images;

  ReviewRequest({this.id, this.studentId, this.images});

  factory ReviewRequest.fromJson(Map<String, dynamic> json) =>
      _$ReviewRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ReviewRequestToJson(this);
}
