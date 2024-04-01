import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class CustomInterceptors extends InterceptorsWrapper {
  final FlutterSecureStorage storage;
  final Ref ref;

  CustomInterceptors({
    required this.storage,
    required this.ref,
  });

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) {
    print('REQUEST[${options.method}] => PATH: ${options.path}');
    // final accessToken = storage.read(key: ACCESS_TOKEN_KEY);
    // final accessToken = ref.read(secureStorageProvider).read(key: ACCESS_TOKEN_KEY);
    //
    // if (accessToken != null) {
    //   options.headers['Authorization'] = 'Bearer $accessToken';
    // }

    return super.onRequest(options, handler);
  }

  @override
  void onError(
    err,
    ErrorInterceptorHandler handler,
  ) {
    print(
        'ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}');
    // if (err.response?.statusCode == 401) {
    //   ref.read(userMeProvider.notifier).logout();
    // }

    return super.onError(err, handler);
  }

  @override
  void onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) {
    print(
        'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}');

    // if (response.statusCode == 401) {
    //   ref.read(userMeProvider.notifier).logout();
    // }

    return super.onResponse(response, handler);
  }
}
