import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../taxi/widgets/adjustment_provider.dart';

class AdjustmentDialog extends ConsumerWidget {
  const AdjustmentDialog({super.key,required this.groupID});
  final int groupID;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final totalAmount = ref.watch(totalAmountProvider);
    final percentageControllers = ref.watch(percentageControllersProvider);
    final isWarningVisible = ref.watch(isWarningVisibleProvider);

    return AlertDialog(
      content: SingleChildScrollView(
        child: Column(
          children: [
            Text('정산하기',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            SizedBox(height: 16),
            _buildRow('총 결제 금액', totalAmount, ref),
            ...List.generate(percentageControllers.length, (index) {
              return _buildPersonRow(ref, index);
            }),
            if (isWarningVisible)
              Text(
                '총 결제 금액과 입력한 개인 요금의 합이 일치하지 않습니다.',
                style: TextStyle(color: Colors.red),
              ),
            ElevatedButton(
              onPressed: () => _handleAdjustmentRequest(context, ref),
              child: Text('정산 요청'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRow(String label, int totalAmount, WidgetRef ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyle(fontSize: 16)),
        Text('$totalAmount 원'),
      ],
    );
  }

  Widget _buildPersonRow(WidgetRef ref, int index) {
    final role = ref.watch(roleProvider);
    final percentageControllers = ref.watch(percentageControllersProvider);
    final amountControllers = ref.watch(amountControllersProvider);

    if (role == 'OWNER') {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildEditableField(ref, percentageControllers, index),
          _buildEditableAmountField(ref, amountControllers, index),
        ],
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildReadOnlyField(percentageControllers, index),
          _buildReadOnlyAmountField(amountControllers, index),
        ],
      );
    }
  }

  // owner
  Widget _buildEditableField(WidgetRef ref,
      List<TextEditingController> controllers, int index) {
    return Container(
      width: 50,
      child: TextField(
        controller: controllers[index],
        keyboardType: TextInputType.number,
        onChanged: (value) {
          ref.read(percentageControllersProvider.notifier).updateController(
              index, value);
        },
      ),
    );
  }

  Widget _buildEditableAmountField(WidgetRef ref,
      List<TextEditingController> controllers, int index) {
    return Container(
      width: 80,
      child: TextField(
        controller: controllers[index],
        keyboardType: TextInputType.number,
        onChanged: (value) {
          ref.read(amountControllersProvider.notifier).updateController(
              index, value);
        },
      ),
    );
  }

  // normal
  Widget _buildReadOnlyField(List<TextEditingController> controllers,
      int index) {
    return Container(
      width: 50,
      child: Text('${controllers[index].text} %'),
    );
  }

  Widget _buildReadOnlyAmountField(List<TextEditingController> controllers,
      int index) {
    return Container(
      width: 80,
      child: Text('${controllers[index].text} 원'),
    );
  }

  void _handleAdjustmentRequest(BuildContext context, WidgetRef ref) {
    // 정산 요청
  }
}