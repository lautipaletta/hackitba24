import 'package:alicia/core/common/models/message.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'report_response.g.dart';

@JsonSerializable()
class ReportResponse {
  @JsonKey(name: 'url')
  final String url;

  ReportResponse({
    required this.url
  });

  factory ReportResponse.fromJson(Map<String, dynamic> json) => _$ReportResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ReportResponseToJson(this);
}