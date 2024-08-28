import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../common/widgets/Buttons.dart';
import '../model/taxi_model.dart';
import '../provider/messaging_provider.dart';
import 'messaging_timeline.dart';
import 'receipt_dialog.dart';
import 'recuit_info_card.dart';

class MessagingHeader extends ConsumerWidget {
  const MessagingHeader({super.key, required this.pageId});

  final int pageId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<TaxiGroup> group = ref.watch(messagingHeaderProvider(pageId));
    final List<String> processes =
        TaxiStatus.values.map((e) => e.toKr()).toList();
    return group.when(data: (data) {
      final departure = data.direction == TaxiDirection.CAMPUS
          ? TaxiDirection.STATION
          : TaxiDirection.CAMPUS;
      final destination = data.direction;
      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          MessagingTimeline(
            processes: processes,
            processIndex: processes.indexOf(data.status.toKr()),
          ),
          RecuitInfoCard(
            departure: departure.toKorean(),
            destination: destination.toKorean(),
            maxPeople: data.member.maxMember,
            currentPeople: data.member.currentMember,
            departTime: data.departDatetime,
            estimatedCost: data.fee.cost,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: PrimaryBtn(
              minimumSize: Size(double.infinity, 48),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return const ReceiptDialog(payment: 6300, hc: 3);
                    });
              },
              text: "탑승자 확정하기",
            ),
          ),
        ],
      );
    }, error: (err, stack) {
      return Center(child: Text("Error: $err"));
    }, loading: () {
      return Center(child: CircularProgressIndicator());
    });
  }
}
