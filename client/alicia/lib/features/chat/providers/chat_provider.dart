import 'package:alicia/features/chat/models/chat_state.dart';
import 'package:riverpod/riverpod.dart';

class ChatNotifier extends StateNotifier<ChatState> {
  ChatNotifier() : super(const ChatState());
}
