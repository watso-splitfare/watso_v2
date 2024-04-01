import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:watso_v2/common/dio/dio_base.dart';

import '../storage/storage_provider.dart';
import 'dio_handling.dart';

part 'dio.g.dart';

@riverpod
Dio dio(ProviderRef ref) {
  final dio = Dio(dioOptions);
  final storage = ref.read(flutterSecureStorageProvider);
  dio.interceptors.add(CustomInterceptors(ref: ref, storage: storage));
  return dio;
}
