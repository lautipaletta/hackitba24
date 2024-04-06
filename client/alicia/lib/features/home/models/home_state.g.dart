// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$HomeStateImpl _$$HomeStateImplFromJson(Map<String, dynamic> json) =>
    _$HomeStateImpl(
      userName: json['userName'] as String,
      userId: json['userId'] as String,
      moodMap: (json['moodMap'] as Map<String, dynamic>).map(
        (k, e) => MapEntry($enumDecode(_$MoodEnumMap, k), e as int),
      ),
      isLoading: json['isLoading'] as bool? ?? false,
      isGeneratingReport: json['isGeneratingReport'] as bool? ?? false,
      attendance: (json['attendance'] as List<dynamic>?)
              ?.map((e) => e as bool)
              .toList() ??
          null,
    );

Map<String, dynamic> _$$HomeStateImplToJson(_$HomeStateImpl instance) =>
    <String, dynamic>{
      'userName': instance.userName,
      'userId': instance.userId,
      'moodMap': instance.moodMap.map((k, e) => MapEntry(_$MoodEnumMap[k]!, e)),
      'isLoading': instance.isLoading,
      'isGeneratingReport': instance.isGeneratingReport,
      'attendance': instance.attendance,
    };

const _$MoodEnumMap = {
  Mood.HAPPY: 'HAPPY',
  Mood.ANGRY: 'ANGRY',
  Mood.ANXIOUS: 'ANXIOUS',
  Mood.SAD: 'SAD',
  Mood.CALM: 'CALM',
};
