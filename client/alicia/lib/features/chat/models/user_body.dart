import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_body.g.dart';

@JsonSerializable()
class UserBody {
  @JsonKey(name: 'user_id')
  final String userId;

  UserBody({required this.userId});

  factory UserBody.fromJson(Map<String, dynamic> json) => _$UserBodyFromJson(json);

  Map<String, dynamic> toJson() => _$UserBodyToJson(this);
}
