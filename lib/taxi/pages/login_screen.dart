import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../common/constants/styles.dart';
import '../../common/user/user_provider.dart';
import '../../common/widgets/Boxes.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Stack(children: [
        Column(
          children: [
            Expanded(child: Container(color: WatsoColor.primary)),
            Expanded(child: Container(color: WatsoColor.background)),
          ],
        ),
        Center(
          child: RoundBox(
            margin: EdgeInsets.symmetric(horizontal: 20),
            padding: EdgeInsets.symmetric(horizontal: 20),
            height: 200,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    "로그인",
                    textAlign: TextAlign.center,
                    style: WatsoFont.title,
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: WatsoColor.primary,
                    ),
                    onPressed: () async {
                      try {
                        await ref
                            .read(authControllerProvider.notifier)
                            .loginWithKakao();
                        // show alert dialog
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('로그인 성공'),
                                content: Text('로그인에 성공했습니다.'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('확인'),
                                  ),
                                ],
                              );
                            });
                      } catch (error) {
                        print('카카오톡으로 로그인 실패 $error');
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('로그인 실패'),
                                content: Text('로그인에 실패했습니다.'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('확인'),
                                  ),
                                ],
                              );
                            });
                      }
                    },
                    child: Text("카카오 로그인"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
