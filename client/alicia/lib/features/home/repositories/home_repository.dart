import 'package:alicia/core/common/models/app_exception.dart';
import 'package:alicia/features/chat/models/session_response.dart';
import 'package:alicia/features/home/models/attendance_response.dart';
import 'package:alicia/features/home/models/mood.dart';
import 'package:alicia/features/home/models/mood_map_response.dart';
import 'package:alicia/features/home/models/report_response.dart';
import 'package:alicia/features/home/services/home_service.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final homeRepositoryProvider = Provider<HomeRepository>((ref) {
  return HomeRepository(ref: ref);
});

class HomeRepository {
  HomeRepository({required this.ref});

  final Ref ref;

  Future<Either<AppException, ReportResponse>> getReport({required String userId}) async {
    try {
      final response = await ref.read(homeServiceProvider).getReport(userId: userId);
      return Right(response);
    } catch (e) {
      return Left(AppException(message: e.toString()));
    }
  }

  Future<Either<AppException, AttendanceResponse>> getAttendance({required String userId}) async {
    try {
      final response = await ref.read(homeServiceProvider).getAttendance(userId: userId);
      return Right(response);
    } catch (e) {
      return Left(AppException(message: e.toString()));
    }
  }

  Future<Either<AppException, Map<Mood, int>>> getMoodMap({required String userId}) async {
    try {
      final response = await ref.read(homeServiceProvider).getMoodMap(userId: userId);
      return Right({
        Mood.HAPPY: response.feliz,
        Mood.ANGRY: response.enojado,
        Mood.ANXIOUS: response.ansioso,
        Mood.SAD: response.triste,
        Mood.CALM: response.calmo,
      });
    } catch (e) {
      return Left(AppException(message: e.toString()));
    }
  }
}
