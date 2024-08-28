import 'package:flutter/material.dart';

import '../widgets/messaging_body.dart';
import '../widgets/messaging_header.dart';

class MessagingScreen extends StatelessWidget {
  const MessagingScreen({super.key, required this.pageId});

  final int pageId;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(child: MessagingHeader(pageId: pageId!)),
        SliverFillRemaining(child: MessagingBody(pageId: pageId!)),
      ],
    );
  }
}
