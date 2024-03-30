import 'package:riverpod_annotation/riverpod_annotation.dart';

import './user_model.dart';

part 'user_provider.g.dart';

@riverpod
class AuthController extends _$AuthController {
  @override
  Future<User?> build() async {
    User? user = await _loginWithToken();
    return user;
  }

  _loginWithToken() async {
    // await Future.delayed(Duration(seconds: 10));
    return const User(id: '1', username: 'test');
    //토큰이없거나 에러있으면 null을 반환
  }

  login() async {
    await Future.delayed(Duration(seconds: 10));
    state = const AsyncData(User(id: '1', username: 'test'));
  }

  logout() {
    state = const AsyncData(null);
  }
}
