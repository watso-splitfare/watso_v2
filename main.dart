import 'package:flutter/material.dart';
import 'widgets.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,

      title: '택시왔소',
      home: MyPage(),
    );
  }
}

class MyPage extends StatelessWidget {
  const MyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("택시왔소",
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.0
          ),
        ),
        backgroundColor: Colors.orange[800],
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.white),
        actions: <Widget>[
          IconButton(
              onPressed: () {
                debugPrint("Setting button is clicked.");
              },
              icon: const Icon(Icons.settings)
          ),
        ],
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text('정산하기'),
          onPressed: () {
            debugPrint('clicked');
            showDialog(
                context: context,
                builder: (context) {
                  return const ReceiptDialog(payment: 6300, hc: 3);
                });
          },
        ),
      ),
    );
  }
}

