
import 'package:alicia/core/common/models/app_exception.dart';
import 'package:alicia/features/chat/models/session_response.dart';
import 'package:alicia/features/home/models/report_response.dart';
import 'package:alicia/features/home/services/report_service.dart';
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
      final response = await ref.read(reportServiceProvider).getReport(userId: userId);
      return Right(response);
    } catch (e) {
      return Left(AppException(message: e.toString()));
    }
  }
}
