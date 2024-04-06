import 'package:alicia/core/common/providers/dio_provider.dart';
import 'package:alicia/features/home/models/attendance_response.dart';
import 'package:alicia/features/home/models/mood_map_response.dart';
import 'package:alicia/features/home/models/report_response.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';
import 'package:riverpod/riverpod.dart';

part 'home_service.g.dart';

final homeServiceProvider = Provider<HomeService>((ref) {
  return HomeService(ref.watch(dioProvider));
});

@RestApi()
abstract class HomeService {
  factory HomeService(Dio dio, {String baseUrl}) = _HomeService;

  @GET('/get_report')
  Future<ReportResponse> getReport({
    @Query('user_id') required String userId,
  });

  @GET('/get_attendance')
  Future<AttendanceResponse> getAttendance({
    @Query('user_id') required String userId,
  });

  @GET('/get_emotions')
  Future<MoodMapResponse> getMoodMap({
    @Query('user_id') required String userId,
  });
}
