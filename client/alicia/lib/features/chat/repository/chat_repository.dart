import 'package:alicia/core/common/models/app_exception.dart';
import 'package:alicia/core/common/models/message.dart';
import 'package:alicia/features/chat/models/message_body.dart';
import 'package:alicia/features/chat/models/session_response.dart';
import 'package:alicia/features/chat/models/user_body.dart';
import 'package:alicia/features/chat/services/chat_service.dart';
import 'package:alicia/features/home/providers/home_provider.dart';
import 'package:either_dart/either.dart';
import 'package:riverpod/riverpod.dart';

final chatRepositoryProvider = Provider<ChatRepository>((ref) {
  return ChatRepository(ref: ref);
});

class ChatRepository {
  ChatRepository({required this.ref});

  final Ref ref;

  Future<Either<AppException, SessionResponse>> startSession({required String userId}) async {
    try {
      final response = await ref.read(chatServiceProvider).startSession(
            body: UserBody(userId: userId),
          );
      return Right(response);
    } catch (e) {
      return Left(AppException(message: e.toString()));
    }
  }

  Future<Either<AppException, void>> endSession({required String userId}) async {
    try {
      await ref.read(chatServiceProvider).endSession(
            body: UserBody(userId: userId),
          );
      return const Right(null);
    } catch (e) {
      return Left(AppException(message: e.toString()));
    }
  }

  Future<Either<AppException, Message>> message({required String content, required String userId}) async {
    try {
      final response = await ref.read(chatServiceProvider).message(
            body: MessageBody(
              content: content,
              userId: userId,
            ),
          );
      return Right(response);
    } catch (e) {
      return Left(AppException(message: e.toString()));
    }
  }

  Future<Either<AppException, SessionResponse>> getSession({required String sessionId, required String userId}) async {
    try {
      final response = await ref.read(chatServiceProvider).getSession(
            sessionId: sessionId,
            userId: userId,
          );
      return Right(response);
    } catch (e) {
      return Left(AppException(message: e.toString()));
    }
  }
}
