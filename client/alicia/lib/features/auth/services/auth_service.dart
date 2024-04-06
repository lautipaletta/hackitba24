import 'package:alicia/core/common/providers/dio_provider.dart';
import 'package:alicia/features/auth/models/sign_up_body.dart';
import 'package:alicia/features/chat/models/user_body.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:riverpod/riverpod.dart';

part 'auth_service.g.dart';

final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService(ref.watch(dioProvider));
});

@RestApi()
abstract class AuthService {
  factory AuthService(Dio dio) = _AuthService;

  @POST('/create_user')
  Future<UserBody> signup({@Body() required SignUpBody request});
}
