import 'package:alicia/core/common/models/app_exception.dart';
import 'package:alicia/core/common/providers/dio_provider.dart';
import 'package:alicia/core/common/repositories/hive_repository.dart';
import 'package:alicia/features/home/models/home_state.dart';
import 'package:alicia/features/home/repositories/home_repository.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final homeProvider = StateNotifierProvider<HomeNotifier, HomeState>((ref) {
  return HomeNotifier(ref: ref);
});

class HomeNotifier extends StateNotifier<HomeState> {
  HomeNotifier({required this.ref})
      : super(
          const HomeState(
            moodMap: {},
            userName: '',
            userId: '',
          ),
        );

  final Ref ref;

  Future<Either<AppException, void>> init() async {
    state = state.copyWith(isLoading: true);
    var response = await ref
        .read(hiveRepositoryProvider)
        .read(boxName: AliciaHiveBox.ALICIA_BOX, key: AliciaHiveBox.USER_ID);
    if (response.isLeft) {
      state = state.copyWith(isLoading: false);
      return Left(response.left);
    } else {
      state = state.copyWith(userId: response.right);
      response = await ref.read(hiveRepositoryProvider).read(
          boxName: AliciaHiveBox.ALICIA_BOX, key: AliciaHiveBox.USER_NAME);
      if (response.isLeft) {
        state = state.copyWith(isLoading: false);
        return Left(response.left);
      } else {
        state = state.copyWith(userName: response.right);
        response = await ref
            .read(homeRepositoryProvider)
            .getAttendance(userId: state.userId);
        if (response.isLeft) {
          state = state.copyWith(isLoading: false);
          return Left(response.left);
        } else {
          state = state.copyWith(attendance: response.right.attendance);
          response = await ref
              .read(homeRepositoryProvider)
              .getMoodMap(userId: state.userId);
          if (response.isLeft) {
            state = state.copyWith(isLoading: false);
            return Left(response.left);
          } else {
            state = state.copyWith(moodMap: response.right);
          }
        }
        state = state.copyWith(isLoading: false);
        print("User ID: ${state.userId}, User Name: ${state.userName}");
        print("Mood Map: ${state.moodMap}");
        return const Right(null);
      }
    }
  }

  Future<Either<AppException, String>> getReport() async {
    state = state.copyWith(isGeneratingReport: true);
    final response =
        await ref.read(homeRepositoryProvider).getReport(userId: state.userId);
    if (response.isLeft) {
      state = state.copyWith(isGeneratingReport: false);
      return Left(response.left);
    } else {
      state = state.copyWith(isGeneratingReport: false);
      return Right(ref.read(dioProvider).options.baseUrl + response.right.url);
    }
  }

  Future<Either<AppException, void>> getAttendance() async {
    state = state.copyWith(attendance: null);
    final response = await ref.read(homeRepositoryProvider).getAttendance(userId: state.userId);
    if (response.isLeft) {
      return Left(response.left);
    } else {
      state = state.copyWith(attendance: response.right.attendance);
      return const Right(null);
    }
  }

  Future<Either<AppException, void>> getMoodMap() async {
    state = state.copyWith(isLoading: true);
    final response = await ref.read(homeRepositoryProvider).getMoodMap(userId: state.userId);
    if (response.isLeft) {
      state = state.copyWith(isLoading: false);
      return Left(response.left);
    } else {
      state = state.copyWith(moodMap: response.right, isLoading: false);
      return const Right(null);
    }
  }
}
