import 'package:alicia/core/common/models/message.dart';
import 'package:alicia/core/common/providers/dio_provider.dart';
import 'package:alicia/features/chat/models/message_body.dart';
import 'package:alicia/features/chat/models/session_response.dart';
import 'package:alicia/features/chat/models/user_body.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';
import 'package:riverpod/riverpod.dart';

part 'chat_service.g.dart';

final chatServiceProvider = Provider<ChatService>((ref) {
  return ChatService(ref.watch(dioProvider));
});

@RestApi()
abstract class ChatService {
  factory ChatService(Dio dio, {String baseUrl}) = _ChatService;

  @POST('/start_session')
  Future<SessionResponse> startSession({@Body() required UserBody body});

  @POST('/end_session')
  Future<void> endSession({@Body() required UserBody body});

  @POST('/message')
  Future<Message> message({@Body() required MessageBody body});

  @GET('/get_session')
  Future<SessionResponse> getSession({
    @Query('session_id') required String sessionId,
    @Query('user_id') required String userId,
  });
}
