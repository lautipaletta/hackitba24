import 'package:alicia/features/home/models/mood.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_state.freezed.dart';
part 'home_state.g.dart';

@freezed
class HomeState with _$HomeState {
  @JsonSerializable(explicitToJson: true)
  const factory HomeState({
    required String userName,
    required String userId,
    required Map<Mood, int> moodMap,
    @Default(false) bool isLoading,
    @Default(false) bool isGeneratingReport,
    @Default(null) List<bool>? attendance,
  }) = _HomeState;

  factory HomeState.fromJson(Map<String, dynamic> json) => _$HomeStateFromJson(json);
}
