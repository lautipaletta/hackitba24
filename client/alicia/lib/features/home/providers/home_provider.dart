import 'package:alicia/core/common/models/app_exception.dart';
import 'package:alicia/core/common/providers/dio_provider.dart';
import 'package:alicia/core/common/repositories/hive_repository.dart';
import 'package:alicia/features/home/models/home_state.dart';
import 'package:alicia/features/home/repositories/home_repository.dart';
import 'package:alicia/features/home/services/report_service.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';

final homeProvider = StateNotifierProvider<HomeNotifier, HomeState>((ref) {
  return HomeNotifier(ref: ref);
});

class HomeNotifier extends StateNotifier<HomeState> {
  HomeNotifier({required this.ref}) : super(const HomeState(
    moodMap: {},
    userName: '',
    userId: '',
  ));

  final Ref ref;

  Future<Either<AppException, void>> init() async {
    state = state.copyWith(isLoading: true);
    var response = await ref.read(hiveRepositoryProvider).read(boxName: AliciaHiveBox.ALICIA_BOX, key: AliciaHiveBox.USER_ID);
    if (response.isLeft) {
      state = state.copyWith(isLoading: false);
      return Left(response.left);
    } else {
      state = state.copyWith(userId: response.right);
      response = await ref.read(hiveRepositoryProvider).read(boxName: AliciaHiveBox.ALICIA_BOX, key: AliciaHiveBox.USER_NAME);
      if (response.isLeft) {
        state = state.copyWith(isLoading: false);
        return Left(response.left);
      } else {
        state = state.copyWith(userName: response.right);
      }
      state = state.copyWith(isLoading: false);
      print("User ID: ${state.userId}, User Name: ${state.userName}");
      return const Right(null);
    }
  }

  Future<Either<AppException, String>> getReportUrl() async {
    state = state.copyWith(isLoading: true);
    final response = await ref.read(homeRepositoryProvider).getReport(userId: state.userId);
    if (response.isLeft) {
      state = state.copyWith(isLoading: false);
      return Left(response.left);
    } else {
      state = state.copyWith(isLoading: false);
      final dio = ref.read(dioProvider);
      var dir = await getApplicationDocumentsDirectory();
      await dio.download(response.right.url, "${dir.path}/report${DateTime.now().millisecondsSinceEpoch}.pdf");
      return Right(response.right.url);
    }
  }

}
