import 'package:dio/dio.dart';
import 'logger.dart';

class ApiClient {
  final Dio _dio;

  ApiClient(String baseUrl)
      : _dio = Dio(BaseOptions(
          baseUrl: baseUrl,
          connectTimeout: const Duration(seconds: 5),
        ))
          ..interceptors.add(InterceptorsWrapper(
            onRequest: (o, h) {
              log.i('➡️ ${o.method} ${o.path}: ${o.data}');
              h.next(o);
            },
            onResponse: (r, h) {
              log.i('✅ ${r.statusCode} ${r.requestOptions.path}');
              h.next(r);
            },
            onError: (e, h) {
              log.e('❌ ${e.requestOptions.method} ${e.requestOptions.path}',
                  error: e);
              h.next(e);
            },
          ));

  Future<Response> post(String path, {dynamic data}) {
    return _dio.post(path, data: data);
  }

  Future<Response> get(String path, {Map<String, dynamic>? params}) {
    return _dio.get(path, queryParameters: params);
  }
}
