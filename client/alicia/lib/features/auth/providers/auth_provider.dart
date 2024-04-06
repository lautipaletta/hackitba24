import 'package:alicia/core/common/models/app_exception.dart';
import 'package:alicia/features/auth/models/auth_state.dart';
import 'package:alicia/features/auth/repository/auth_repository.dart';
import 'package:either_dart/either.dart';
import 'package:riverpod/riverpod.dart';

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier(ref: ref);
});

class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier({required this.ref}) : super(const AuthState());

  final Ref ref;

  Future<Either<AppException, void>> signup({required String name}) async {
    state = state.copyWith(isLoading: true);
    final response = await ref.read(authRepositoryProvider).signup(name: name);
    if (response.isLeft) {
      state = state.copyWith(isLoading: false);
      return Left(response.left);
    } else {
      state = state.copyWith(isLoading: false, userId: response.right);
      return const Right(null);
    }
  }
}
