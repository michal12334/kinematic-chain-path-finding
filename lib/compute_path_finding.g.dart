// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'compute_path_finding.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppStateData _$AppStateDataFromJson(Map<String, dynamic> json) => AppStateData(
      (json['l1'] as num).toDouble(),
      (json['l2'] as num).toDouble(),
      (json['x'] as num).toDouble(),
      (json['y'] as num).toDouble(),
      (json['endX'] as num).toDouble(),
      (json['endY'] as num).toDouble(),
    );

Map<String, dynamic> _$AppStateDataToJson(AppStateData instance) =>
    <String, dynamic>{
      'l1': instance.l1,
      'l2': instance.l2,
      'x': instance.x,
      'y': instance.y,
      'endX': instance.endX,
      'endY': instance.endY,
    };

PathFindingResult _$PathFindingResultFromJson(Map<String, dynamic> json) =>
    PathFindingResult(
      (json['pixels'] as List<dynamic>).map((e) => (e as num).toInt()).toList(),
    );

Map<String, dynamic> _$PathFindingResultToJson(PathFindingResult instance) =>
    <String, dynamic>{
      'pixels': instance.pixels,
    };
