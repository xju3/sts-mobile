import 'package:json_annotation/json_annotation.dart';

part 'school.g.dart';

@JsonSerializable()
class School {
  final String? id;
  final String? shortName;
  final String? fullName;
  final String? addr;
  final double? lat;
  final double? lng;
  final String? phone;

  School(
      {this.id,
      this.shortName,
      this.fullName,
      this.addr,
      this.lat,
      this.lng,
      this.phone});

  factory School.fromJson(Map<String, dynamic> json) => _$SchoolFromJson(json);

  Map<String, dynamic> toJson() => _$SchoolToJson(this);
}
