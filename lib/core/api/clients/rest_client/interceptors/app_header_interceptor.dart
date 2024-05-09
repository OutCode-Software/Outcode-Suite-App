import 'package:dio/dio.dart';

class AppHeaderInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers.addAll(_getAppHeader());
    handler.next(options);
  }

  static Map<String, String> _getAppHeader() {
    return {'tz': 'Asia/Katmandu'};
  }
}
