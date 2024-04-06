// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageBody _$MessageBodyFromJson(Map<String, dynamic> json) => MessageBody(
      content: json['content'] as String,
      userId: json['userId'] as String,
    );

Map<String, dynamic> _$MessageBodyToJson(MessageBody instance) =>
    <String, dynamic>{
      'content': instance.content,
      'userId': instance.userId,
    };
