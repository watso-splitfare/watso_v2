import 'package:dio/dio.dart';

var dioOptions = BaseOptions(
  baseUrl: 'http://164.125.248.36:8000/api',
  connectTimeout: const Duration(seconds: 5),
  receiveTimeout: const Duration(seconds: 5),
);
