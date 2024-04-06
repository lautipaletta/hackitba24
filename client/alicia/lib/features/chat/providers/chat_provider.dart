import 'package:alicia/core/common/models/app_exception.dart';
import 'package:alicia/core/common/models/message.dart';
import 'package:alicia/features/chat/models/chat_state.dart';
import 'package:alicia/features/chat/repository/chat_repository.dart';
import 'package:either_dart/either.dart';
import 'package:riverpod/riverpod.dart';

final chatProvider = StateNotifierProvider<ChatNotifier, ChatState>(
  (ref) {
    return ChatNotifier(ref: ref);
  },
);

class ChatNotifier extends StateNotifier<ChatState> {
  ChatNotifier({required this.ref}) : super(const ChatState());

  final Ref ref;

  void init() async {
    if (!state.sessionStarted) {
      state = state.copyWith(isLoading: true, error: null);
      final response = await ref.read(chatRepositoryProvider).startSession();
      if (response.isLeft) {
        state = state.copyWith(isLoading: false, error: response.left.message);
        return;
      }
      state = state.copyWith(
        prevSessionId: response.right.prevSessionId,
        messages: response.right.messages,
        sessionStarted: true,
        isLoading: false,
      );
    }
  }

  void addUserMessage({required String content}) {
    state = state.copyWith(
      messages: state.messages +
          [
            Message(content: content, role: 'user', timestamp: DateTime.now().millisecondsSinceEpoch),
          ],
      aliciaTyping: true,
    );
  }

  Future<Either<AppException, void>> sendMessage({required String content}) async {
    final response = await ref.read(chatRepositoryProvider).message(content: content);
    if (response.isLeft) {
      state = state.copyWith(aliciaTyping: false);
      return Left(response.left);
    }
    state = state.copyWith(
      messages: state.messages + [response.right],
      aliciaTyping: false,
    );
    return const Right(null);
  }

  Future<void> endSession() async {
    await ref.read(chatRepositoryProvider).endSession();
  }

  Future<Either<AppException, void>> loadMoreSessions() async {
    if (state.isLoadingMore || state.prevSessionId == null) return const Right(null);
    state = state.copyWith(isLoadingMore: true);
    final response = await ref.read(chatRepositoryProvider).getSession(sessionId: state.prevSessionId!);
    if (response.isLeft) {
      state = state.copyWith(isLoadingMore: false);
      return Left(response.left);
    }
    state = state.copyWith(
      prevSessionId: response.right.prevSessionId,
      messages: response.right.messages + state.messages,
      isLoadingMore: false,
    );
    return const Right(null);
  }
}
