import 'package:jiwa/server/model/err_msg.dart';
import 'package:json_annotation/json_annotation.dart';

part 'single_value.g.dart';

@JsonSerializable()
class SingleValue {
  dynamic content;

  SingleValue({
    this.content
  });

  factory SingleValue.fromJson(Map<String, dynamic> json) => _$SingleValueFromJson(json);

  Map<String, dynamic> toJson() => _$SingleValueToJson(this);
}
