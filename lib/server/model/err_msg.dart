import 'package:json_annotation/json_annotation.dart';

part 'err_msg.g.dart';

@JsonSerializable()
class ErrMsg {
  String? code;
  String? msg;

  ErrMsg({
    this.code,
    this.msg,
  });

  factory ErrMsg.fromJson(Map<String, dynamic> json) => _$ErrMsgFromJson(json);

  Map<String, dynamic> toJson() => _$ErrMsgToJson(this);
}
