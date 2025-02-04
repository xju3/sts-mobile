
import 'package:json_annotation/json_annotation.dart';

part 'http_response.g.dart';

@JsonSerializable()
class HttpResponse {
  String? code;
  String? message;


  HttpResponse({this.code, this.message,});
  factory HttpResponse.fromJson(Map<String, dynamic> json) => _$HttpResponseFromJson(json);
  Map<String, dynamic> toJson() => _$HttpResponseToJson(this);
}