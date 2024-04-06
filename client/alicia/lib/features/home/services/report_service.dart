import 'package:alicia/core/common/providers/dio_provider.dart';
import 'package:alicia/features/home/models/report_response.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';
import 'package:riverpod/riverpod.dart';

part 'report_service.g.dart';

final reportServiceProvider = Provider<ReportService>((ref) {
  return ReportService(ref.watch(dioProvider));
});

@RestApi()
abstract class ReportService {
  factory ReportService(Dio dio, {String baseUrl}) = _ReportService;

  @GET('/get_report')
  Future<ReportResponse> getReport({
    @Query('user_id') required String userId,
  });
}
