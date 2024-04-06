import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_up_body.g.dart';

@JsonSerializable()
class SignUpBody {
  final String name;

  const SignUpBody({
    required this.name,
  });

  factory SignUpBody.fromJson(Map<String, dynamic> json) => _$SignUpBodyFromJson(json);

  Map<String, dynamic> toJson() => _$SignUpBodyToJson(this);
}
