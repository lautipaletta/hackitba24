// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mood_map_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MoodMapResponse _$MoodMapResponseFromJson(Map<String, dynamic> json) =>
    MoodMapResponse(
      feliz: json['feliz'] as int,
      enojado: json['enojado'] as int,
      ansioso: json['ansioso'] as int,
      triste: json['triste'] as int,
      calmo: json['calmo'] as int,
    );

Map<String, dynamic> _$MoodMapResponseToJson(MoodMapResponse instance) =>
    <String, dynamic>{
      'feliz': instance.feliz,
      'enojado': instance.enojado,
      'ansioso': instance.ansioso,
      'triste': instance.triste,
      'calmo': instance.calmo,
    };
