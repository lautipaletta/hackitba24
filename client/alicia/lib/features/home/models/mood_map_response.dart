import 'package:freezed_annotation/freezed_annotation.dart';

part 'mood_map_response.g.dart';

@JsonSerializable()
class MoodMapResponse {
  MoodMapResponse({
    required this.feliz, required this.enojado, required this.ansioso, required this.triste, required this.calmo, 
  });

  final int feliz;
  final int enojado;
  final int ansioso;
  final int triste;
  final int calmo;

  factory MoodMapResponse.fromJson(Map<String, dynamic> json) => _$MoodMapResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MoodMapResponseToJson(this);
}
