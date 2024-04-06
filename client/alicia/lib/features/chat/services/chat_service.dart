import 'package:alicia/core/common/models/message.dart';
import 'package:alicia/core/common/providers/dio_provider.dart';
import 'package:alicia/features/chat/models/message_body.dart';
import 'package:alicia/features/chat/models/session_response.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:riverpod/riverpod.dart';

part 'chat_service.g.dart';

final chatServiceProvider = Provider<ChatService>((ref) {
  return ChatService(ref.watch(dioProvider));
});

@RestApi()
abstract class ChatService {
  factory ChatService(Dio dio, {String baseUrl}) = _ChatService;

  @GET('/startSession')
  Future<SessionResponse> startSession({@Query('user_id') required String userId});

  @GET('/endSession')
  Future<void> endSession({@Query('user_id') required String userId});

  @POST('/message')
  Future<Message> message({@Body() required MessageBody body});

  @GET('/getSession')
  Future<SessionResponse> getSession({@Query('session_id') required String sessionId});
}