// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SessionResponse _$SessionResponseFromJson(Map<String, dynamic> json) =>
    SessionResponse(
      messages: (json['messages'] as List<dynamic>)
          .map((e) => Message.fromJson(e as Map<String, dynamic>))
          .toList(),
      prevSessionId: json['prev_session_id'] as String?,
    );

Map<String, dynamic> _$SessionResponseToJson(SessionResponse instance) =>
    <String, dynamic>{
      'prev_session_id': instance.prevSessionId,
      'messages': instance.messages,
    };
