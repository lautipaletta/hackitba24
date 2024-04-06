import 'package:freezed_annotation/freezed_annotation.dart';

part 'attendance_response.g.dart';

@JsonSerializable()
class AttendanceResponse {
  AttendanceResponse({
    required this.attendance,
  });

  final List<bool> attendance;

  factory AttendanceResponse.fromJson(Map<String, dynamic> json) => _$AttendanceResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AttendanceResponseToJson(this);
}
