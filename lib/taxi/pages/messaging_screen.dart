import 'package:flutter/material.dart';

import '../../common/widgets/Boxes.dart';
import '../widgets/messaging_body.dart';
import '../widgets/messaging_header.dart';

class MessagingScreen extends StatelessWidget {
  const MessagingScreen({super.key, this.pageId});

  final String? pageId;

  @override
  Widget build(BuildContext context) {
    if (pageId == null) {
      return AngularBox(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
        margin: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
        child: Text("참여 중인 택시가 없습니다"),
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        MessagingHeader(pageId: pageId!),
        Expanded(child: MessagingBody(pageId: pageId!))
      ],
    );
  }
}
