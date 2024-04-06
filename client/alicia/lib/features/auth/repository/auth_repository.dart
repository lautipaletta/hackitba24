import 'package:alicia/core/common/models/app_exception.dart';
import 'package:alicia/features/auth/models/sign_up_body.dart';
import 'package:alicia/features/auth/services/auth_service.dart';
import 'package:either_dart/either.dart';
import 'package:riverpod/riverpod.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository(ref: ref);
});

class AuthRepository {
  AuthRepository({required this.ref});

  final Ref ref;

  Future<Either<AppException, String>> signup({
    required String name,
  }) async {
    try {
      final response = await ref.read(authServiceProvider).signup(
            request: SignUpBody(name: name),
          );
      return Right(response.userId);
    } catch (e) {
      return Left(AppException(message: e.toString()));
    }
  }
}
