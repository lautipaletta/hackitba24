import 'package:dio/dio.dart';
import 'package:riverpod/riverpod.dart';

final dioProvider = Provider<Dio>(
  (ref) {
    final dio = Dio(
      BaseOptions(
        baseUrl: 'http://172.20.10.8:3000',
      ),
    );
    dio.interceptors.add(LogInterceptor());
    return dio;
  },
);

class LogInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    print('''🔵 [REQUEST]
    METHOD: ${options.method}
    PATH: ${options.path}
    QUERY PARAMETERS: ${options.queryParameters}
    DATA: ${options.data}
    HEADERS: ${options.headers}
    ''');
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print('''🟢 [RESPONSE]
    STATUS CODE: ${response.statusCode}
    PATH: ${response.requestOptions.path}
    DATA: ${response.data}
    ''');
    super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    print('''🔴 [ERROR]
    STATUS CODE: ${err.response?.statusCode}
    PATH: ${err.requestOptions.path}
    ERROR: ${err.error}
    ''');
    super.onError(err, handler);
  }
}
