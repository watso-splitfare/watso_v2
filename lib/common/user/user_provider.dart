import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../dio/dio.dart';
import './user_model.dart';

part 'user_provider.g.dart';

@riverpod
class AuthController extends _$AuthController {
  @override
  Future<MyUser?> build() async {
    MyUser? user = await _loginWithToken();
    return user;
  }

  _loginWithToken() async {
    // await Future.delayed(Duration(seconds: 10));
    // return const MyUser(id: '1', username: 'test');
    return null;
    //토큰이없거나 에러있으면 null을 반환
  }

  loginWithKakao() async {
    OAuthToken token = await UserApi.instance.loginWithKakaoTalk();
    log('카카오톡으로 로그인 성공 accessToken: ${token.accessToken} , idToken: ${token.idToken}');
    Dio dio = ref.watch(dioProvider);
    var data = await dio.get('/auth/login/kakao', queryParameters: {
      'access_token': token.accessToken,
    });
    log('카카오톡으로 로그인 성공 data: $data');
    state = const AsyncData(MyUser(id: '1', username: 'test'));
  }

  logout() {
    state = const AsyncData(null);
  }
}
