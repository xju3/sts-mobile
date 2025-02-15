import 'package:json_annotation/json_annotation.dart';

part 'parent.g.dart';

@JsonSerializable()
class Parent {
  String? id;
  String? accountId;
  String? name;
  String? accountName;
  String? role;
  String? password;

  Parent(
      {this.id,
      this.name,
      this.accountId,
      this.accountName,
      this.role,
      this.password});

  factory Parent.fromJson(Map<String, dynamic> json) => _$ParentFromJson(json);

  Map<String, dynamic> toJson() => _$ParentToJson(this);
}
