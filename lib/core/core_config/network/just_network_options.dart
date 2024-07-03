import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:just_in_play_proof/core/core_config/network/headers.dart';

class JustNetworkOptions extends JustNetwork {
  JustNetworkOptions({
    this.url,
    this.headers,
  });
  final String? url;
  final Map<String, dynamic>? headers;
  final dio = Dio();

  @override
  void dioConfig() {
    dio.options.baseUrl = url ?? _baseUrl;
    dio.options.headers = headers ?? justPlayHeader;
    dio.options.connectTimeout = const Duration(seconds: 5);
    dio.options.receiveTimeout = const Duration(seconds: 3);
    dio.interceptors.add(CustomInterceptors());
  }

  @override
  Future<Response<T>> get<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    void Function(int p1, int p2)? onReceiveProgress,
  }) =>
      dio.get(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
}

abstract class JustNetwork {
  String get _baseUrl => 'https://api.simkl.com';

  void dioConfig();
  Future<Response<T>> get<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    void Function(int, int)? onReceiveProgress,
  });
}

class CustomInterceptors extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    log('REQUEST[${options.method}] => PATH: ${options.path}');
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    log('RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}\nHEADER:${response.headers}\nBODY:${response.data} ');
    super.onResponse(response, handler);
  }

  @override
  Future onError(DioException err, ErrorInterceptorHandler handler) async {
    log('ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}');
    super.onError(err, handler);
  }
}
