import 'package:alicia/core/common/models/message.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'session_response.g.dart';

@JsonSerializable()
class SessionResponse {
  @JsonKey(name: 'prev_session_id')
  final String? prevSessionId;
  final List<Message> messages;

  SessionResponse({
    required this.messages,
    this.prevSessionId,
  });

  factory SessionResponse.fromJson(Map<String, dynamic> json) => _$SessionResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SessionResponseToJson(this);
}
