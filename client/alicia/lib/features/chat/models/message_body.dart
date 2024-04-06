import 'package:freezed_annotation/freezed_annotation.dart';

part 'message_body.g.dart';

@JsonSerializable()
class MessageBody {
  final String content;
  @JsonKey(name: 'user_id')
  final String userId;

  MessageBody({required this.content, required this.userId});

  factory MessageBody.fromJson(Map<String, dynamic> json) => _$MessageBodyFromJson(json);

  Map<String, dynamic> toJson() => _$MessageBodyToJson(this);
}
