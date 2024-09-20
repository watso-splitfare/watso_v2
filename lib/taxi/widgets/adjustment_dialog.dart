import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../taxi/widgets/adjustment_provider.dart';

class AdjustmentDialog extends ConsumerWidget {
  const AdjustmentDialog({super.key,required this.groupID});
  final int groupID;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final totalAmount = ref.watch(totalAmountControllerProvider);
    final totalAmountControllers = ref.watch(totalAmountControllerProvider.notifier);
    final percentageControllers = ref.watch(percentageControllersProvider);
    final isWarningVisible = ref.watch(isWarningVisibleProvider);

    return AlertDialog(
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('정산하기',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            SizedBox(height: 16),
            Padding(
              padding: EdgeInsets.only(top: 20, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('총 결제 금액', style: TextStyle(fontSize: 16),),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        width: 80,
                        child: TextField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            filled: true,
                            fillColor: Colors.grey[100],
                          ),
                          textAlign: TextAlign.center,
                          controller: totalAmountControllers.controller,
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      SizedBox(width: 8),
                      Text('원'),
                    ],
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('총 인원', style: TextStyle(fontSize: 16),),
                  Text('${percentageControllers.length} 명'),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('1인당 요금', style: TextStyle(fontSize: 16),),
                  Text('${(totalAmount/members.length).ceil()} 원'), // 소수점 올림
                ],
              ),
            ),
            Divider(),
            ...List.generate(members.length, (index) {
              return _buildPersonRow(ref, index);
            }),
            Divider(),
            if (isWarningVisible)
              Text(
                '총 결제 금액과 입력한 개인 요금의 합이\n일치하지 않습니다.',
                style: TextStyle(color: Colors.red, fontSize: 14),
                maxLines: 2,
                overflow: TextOverflow.ellipsis, // 줄이 넘칠 경우
              ),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange, //   버튼 색상
                  // padding: EdgeInsets.symmetric(horizontal: 40, vertical: 0),
                ),
                onPressed: () => _checkAmountSum(context, ref),
                child: Text('정산 요청', style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPersonRow(WidgetRef ref, int index) {
    final percentageControllers = ref.watch(percentageControllersProvider);
    final amountControllers = ref.watch(amountControllersProvider);

    if (role == 'OWNER') {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            members[index],
            style: TextStyle(
              fontSize: 12,
              color: Color(0xFF767676),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildEditableField(ref, percentageControllers, index),
              _buildEditableAmountField(ref, amountControllers, index),
            ],
          ),
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
    return Row(
      children: [
        Container(
          width: 50,
          child: TextField(
            decoration: InputDecoration(
              border: InputBorder.none,
              filled: true,
              fillColor: Colors.grey[100],
            ),
            textAlign: TextAlign.center,
            controller: controllers[index],
            keyboardType: TextInputType.number,
            onChanged: (value) {
              ref.read(percentageControllersProvider.notifier).updateController(
                  index, value);
            },
          ),
        ),
        SizedBox(width: 8),
        Text('%')
      ],
    );
  }

  Widget _buildEditableAmountField(WidgetRef ref,
      List<TextEditingController> controllers, int index) {
    return Row(
      children: [
        Container(
          width: 80,
          child: TextField(
            decoration: InputDecoration(
              border: InputBorder.none,
              filled: true,
              fillColor: Colors.grey[100],
            ),
            textAlign: TextAlign.center,
            controller: controllers[index],
            keyboardType: TextInputType.number,
            onChanged: (value) {
              ref.read(amountControllersProvider.notifier).updateController(
                  index, value);
            },
          ),
        ),
        SizedBox(width: 8),
        Text('원'),
      ],
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

  void _checkAmountSum(BuildContext context, WidgetRef ref) {
    final amountControllers = ref.read(amountControllersProvider.notifier);

    int amountSum = amountControllers.getAmountSum();
    int totalAmount = ref.read(totalAmountControllerProvider);

    if (amountSum != totalAmount) {
      debugPrint('불일치');
      ref.read(isWarningVisibleProvider.notifier).state = true;
    } else {
      ref.read(isWarningVisibleProvider.notifier).state = false;
      debugPrint('일치.');

      final amounts = amountControllers.getAmounts();
      _returnAmounts(context, amounts);
    }
  }

  void _returnAmounts(BuildContext context, List<int> amounts) {
    Navigator.of(context).pop(amounts);
  }
}