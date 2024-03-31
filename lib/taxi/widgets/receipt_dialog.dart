import 'package:flutter/material.dart';

class ReceiptDialog extends StatefulWidget {
  const ReceiptDialog({
    super.key,
    required this.payment,
    required this.hc,
  });
  final int payment;  // 총 결제 금액
  final int hc;       // 인원 수

  @override
  State<ReceiptDialog> createState() => _ReceiptDialogState();
}

class _ReceiptDialogState extends State<ReceiptDialog> {

  @override
  Widget build(BuildContext context) {
    var userList = ['창욱', '태민', '준하'];    // 수정 필요
    var paymentPP = List<int>.filled(widget.hc, 0);
    for(int i=0; i<widget.hc; i++) {
      // debugPrint('$i');
      paymentPP[i] = widget.payment~/widget.hc;
    }

    // 필요: 총결제금액, 인원수, 닉네임(이름?), 개인당요금 .... 차량번호, 탑승시간, 거래일시는 없어도...?
    return AlertDialog(
      title: const Text(
        '영수증',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
      content: SingleChildScrollView(
        child: ListBody(
          children: [
            Column(
              children: [
                const Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('차량 번호', style: TextStyle(fontSize: 15),),
                      Text('부산12바 1234', style: TextStyle(fontSize: 15))
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('탑승 시간', style: TextStyle(fontSize: 15)),
                      Text('2023.12.19 11:36:23', style: TextStyle(fontSize: 15))
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('거래 일시', style: TextStyle(fontSize: 15)),
                      Text('2023.12.19 11:40:43', style: TextStyle(fontSize: 15))
                    ],
                  ),
                ),
                const Padding(padding: EdgeInsets.only(bottom: 8), child: Divider()),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('총 결제 금액', style: TextStyle(fontSize: 15)),
                      Text('${widget.payment}원', style: TextStyle(fontSize: 15)),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('총 인원', style: TextStyle(fontSize: 15)),
                      Text('${widget.hc}명', style: const TextStyle(fontSize: 15)),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('1인당 요금', style: TextStyle(fontSize: 15)),
                      Text('${paymentPP[0]}원', style: TextStyle(fontSize: 15)),
                    ],
                  ),
                ),
                const Padding(padding: EdgeInsets.only(bottom: 8), child: Divider()),
                // userList list 형식으로 받는다면, 아래 코드 반복문으로 수정해야 함
                Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Column(
                      children: [
                        Row(children: [Text('${userList[0]}', style: TextStyle(fontSize: 10),)]),
                        Row(children: [Text('${paymentPP[0]}원', style: const TextStyle(fontSize: 15))])
                      ],
                    )
                ),
                Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Column(
                      children: [
                        Row(children: [Text('${userList[1]}', style: TextStyle(fontSize: 10),)]),
                        Row(children: [Text('${paymentPP[1]}원', style: const TextStyle(fontSize: 15))])
                      ],
                    )
                ),
                Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Column(
                      children: [
                        Row(children: [Text('${userList[2]}', style: TextStyle(fontSize: 10),)]),
                        Row(children: [Text('${paymentPP[2]}원', style: const TextStyle(fontSize: 15))])
                      ],
                    )
                ),
                const Padding(
                    padding: EdgeInsets.only(bottom: 8), child: Divider()),
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('확인'))
              ],
            )
          ],
        ),
      ),
    );
  }
}
