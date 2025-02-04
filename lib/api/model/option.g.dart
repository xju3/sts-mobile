// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'option.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Option _$OptionFromJson(Map<String, dynamic> json) => Option(
      label: json['label'] as String?,
      value: json['value'] as String?,
      children: (json['children'] as List<dynamic>?)
          ?.map((e) => Option.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$OptionToJson(Option instance) => <String, dynamic>{
      'label': instance.label,
      'value': instance.value,
      'children': instance.children,
    };
