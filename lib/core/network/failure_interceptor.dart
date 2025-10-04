import 'package:black_bull/core/error/error_mapper.dart';
import 'package:dio/dio.dart';

class FailureInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    print(
      "❌ DioError: ${err.response?.statusCode} ${err.response?.statusMessage}",
    );
    print("❌ Data: ${err.response?.data}");
    final failure = mapDioException(err);

    final newError = DioException(
      requestOptions: err.requestOptions,
      response: err.response,
      type: err.type,
      error: failure, // attach failure here at creation
      message: err.message,
    );
    handler.next(newError);
  }
}
