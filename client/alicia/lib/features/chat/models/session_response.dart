import 'package:alicia/core/common/models/message.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'session_response.g.dart';

@JsonSerializable()
class SessionResponse {
  final String prevSessionId;
  final List<Message> messages;

  SessionResponse({
    required this.prevSessionId,
    required this.messages,
  });

  factory SessionResponse.fromJson(Map<String, dynamic> json) => _$SessionResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SessionResponseToJson(this);
}
