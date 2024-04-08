import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../storage/storage_type.dart';

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
    log('[REQ] [${options.method}] ${options.uri} ${options.data} ${options.headers}');
    final accessToken = storage.read(key: AuthToken.accessToken.name);

    if (accessToken != null) {
      options.headers['Authorization'] = 'Bearer $accessToken';
    }

    return super.onRequest(options, handler);
  }

  @override
  void onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) {
    log('[RES] [${response.requestOptions.method}] ${response.requestOptions.uri} ${response.data?.toString()}  ');
    return super.onResponse(response, handler);
  }

  @override
  Future<void> onError(
    err,
    ErrorInterceptorHandler handler,
  ) async {
    log('[ERR] [${err.requestOptions.method}] ${err.requestOptions.uri} ${err.response?.statusCode} ${err.requestOptions.data} ${err.response?.data}');

    if (err.response?.statusCode == 401) {
      try {
        final refreshToken =
            await storage.read(key: AuthToken.refreshToken.name);
        await storage.delete(key: AuthToken.accessToken.name);

        // no refresh token
        if (refreshToken == null) {
          // 에러를 던질때는 handler.reject를 사용한다.
          return handler.reject(err);
        }
        // refresh token이 있을 경우, 새로운 access token을 요청한다.
        // 요청이 안되면 에러를 던진다.

        return handler.reject(err);
      } catch (e) {
        try {
          await storage.deleteAll();
        } catch (e) {
          log('Failed to delete all storage');
        }
        return handler.reject(err);
      }
    }

    return super.onError(err, handler);
  }
}
