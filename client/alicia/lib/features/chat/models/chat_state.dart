import 'package:alicia/core/common/models/message.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_state.freezed.dart';

@freezed
class ChatState with _$ChatState {
  const factory ChatState({
    @Default([]) List<Message> messages,
    @Default(false) bool sessionStarted,
    @Default(false) bool isLoading,
    @Default(false) bool isLoadingMore,
  }) = _ChatState;
}
