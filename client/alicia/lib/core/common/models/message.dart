import 'package:freezed_annotation/freezed_annotation.dart';

part 'message.g.dart';

@JsonSerializable()
class Message {
  final String content;
  final int timestamp;
  final String? userId;

  Message({
    required this.content,
    required this.timestamp,
    this.userId,
  });

  factory Message.fromJson(Map<String, dynamic> json) => _$MessageFromJson(json);

  Map<String, dynamic> toJson() => _$MessageToJson(this);
}
