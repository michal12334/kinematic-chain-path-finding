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
      (json['obstacles'] as List<dynamic>)
          .map((e) => Obstacle.fromJson(e as Map<String, dynamic>))
          .toList(),
      $enumDecode(_$RobotPositionTypeEnumMap, json['positionType']),
      $enumDecode(_$RobotPositionTypeEnumMap, json['endPositionType']),
    );

Map<String, dynamic> _$AppStateDataToJson(AppStateData instance) =>
    <String, dynamic>{
      'l1': instance.l1,
      'l2': instance.l2,
      'x': instance.x,
      'y': instance.y,
      'positionType': _$RobotPositionTypeEnumMap[instance.positionType]!,
      'endX': instance.endX,
      'endY': instance.endY,
      'endPositionType': _$RobotPositionTypeEnumMap[instance.endPositionType]!,
      'obstacles': instance.obstacles,
    };

const _$RobotPositionTypeEnumMap = {
  RobotPositionType.basic: 'basic',
  RobotPositionType.alternative: 'alternative',
};

PathFindingResult _$PathFindingResultFromJson(Map<String, dynamic> json) =>
    PathFindingResult(
      (json['pixels'] as List<dynamic>).map((e) => (e as num).toInt()).toList(),
      (json['path'] as List<dynamic>?)
          ?.map((e) => _$recordConvert(
                e,
                ($jsonValue) => (
                  ($jsonValue[r'$1'] as num).toInt(),
                  ($jsonValue[r'$2'] as num).toInt(),
                ),
              ))
          .toList(),
    );

Map<String, dynamic> _$PathFindingResultToJson(PathFindingResult instance) =>
    <String, dynamic>{
      'pixels': instance.pixels,
      'path': instance.path
          ?.map((e) => <String, dynamic>{
                r'$1': e.$1,
                r'$2': e.$2,
              })
          .toList(),
    };

$Rec _$recordConvert<$Rec>(
  Object? value,
  $Rec Function(Map) convert,
) =>
    convert(value as Map<String, dynamic>);
