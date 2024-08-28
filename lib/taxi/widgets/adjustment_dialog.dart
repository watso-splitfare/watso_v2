import 'package:flutter/material.dart';

class AdjustmentDialog extends StatefulWidget {
  const AdjustmentDialog({
    super.key,
    required this.groupID,
  });
  final int groupID;

  @override
  State<AdjustmentDialog> createState() => _AdjustmentDialogState();
}
class _AdjustmentDialogState extends State<AdjustmentDialog> {
  final TextEditingController _totalAmountController = TextEditingController(text: '6200');
  List<TextEditingController> _percentageControllers = [];
  List<TextEditingController> _amountControllers = [];
  List<String> members = ["찰봉", "준하", "창욱", "민지"];
  bool _isWarningVisible = false;
  List<bool> _isAmountFieldInvalid = [];

  @override
  void initState() {
    super.initState();

    if (members.isNotEmpty) {
      // 멤버 수에 따라 컨트롤러 리스트 초기화
      int tmpPercentage = 100 ~/ members.length;
      int tmpAmount = 6200 ~/ members.length;

      _percentageControllers = List.generate(members.length, (index) => TextEditingController(text: tmpPercentage.toString()));
      _amountControllers = List.generate(members.length, (index) => TextEditingController(text: tmpAmount.toString()));

      _isAmountFieldInvalid = List<bool>.filled(members.length, false);
    } else {
      // members가 비어 있는 경우
      _percentageControllers = [];
      _amountControllers = [];
      _isAmountFieldInvalid = [];
    }
  }

  @override
  Widget build(BuildContext context) {
    if (members.isEmpty) {
      return Center(
        child: Text('멤버가 없습니다.'),
      );
    }
    return AlertDialog(
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '정산하기',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            SizedBox(height: 16),
            _buildRow('총 결제 금액', _totalAmountController, '원', readOnly: false),
            SizedBox(height: 8),
            Padding(
              padding: EdgeInsets.only(top: 20, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('총 인원', style: TextStyle(fontSize: 16),),
                  Text('${members.length} 명'),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('1인당 요금', style: TextStyle(fontSize: 16),),
                  Text('${_calculatePerPerson()} 원'),
                ],
              ),
            ),
            Divider(),
            Padding(
              padding: EdgeInsets.only(top: 10, bottom: 10),
              child: Column(
                children: List.generate(members.length, (index) {
                  String member = members[index];
                  return Column(
                    children: [
                      _buildPersonRow(member, index),
                      SizedBox(height: 8),
                    ],
                  );
                }),
              ),
            ),
            if (_isWarningVisible)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Column(
                  children: [
                    Text(
                      '총 결제 금액과 입력한 개인 요금의 합이\n일치하지 않습니다.',
                      style: TextStyle(color: Colors.red, fontSize: 14),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis, // 줄이 넘칠 경우
                    ),
                    SizedBox(height: 8),
                  ],
                ),
              ),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange, //   버튼 색상
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                ),
                onPressed: () {
                  _handleAdjustmentRequest();
                },
                child: Text('정산 요청', style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRow(String label, TextEditingController controller, String suffix, {bool readOnly = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyle(fontSize: 16),),
        Row(
          children: [
            Container(
              width: 80,
              child: TextField(
                controller: controller,
                readOnly: readOnly,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(horizontal: 8),
                ),
                onChanged: (value) {
                  setState(() {
                    _setAmountControllers();
                  });
                },
              ),
            ),
            SizedBox(width: 8),
            Text(suffix),
          ],
        ),
      ],
    );
  }

  Widget _buildPersonRow(String name, int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: TextStyle(
            fontSize: 12,
            color: Color(0xFF767676),
          ),
        ),
        SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  width: 50,
                  child: TextField(
                    controller: _percentageControllers[index],
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: _isAmountFieldInvalid[index] ? Colors.red : Colors.grey,
                        ),
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 8),
                    ),
                    onChanged: (value) {
                      setState(() {
                        _updateAmountController(index);  // 값이 변경될 때마다 UI 업데이트
                      });
                    },
                  ),
                ),
                SizedBox(width: 8),
                Text('%'),
              ],
            ),
            Row(
              children: [
                Container(
                  width: 80,
                  child: TextField(
                    controller: _amountControllers[index],
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: _isAmountFieldInvalid[index] ? Colors.red : Colors.grey,
                        ),
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 8),
                    ),
                    onChanged: (value) {
                      setState(() {
                        _updatePercentageController(index);  // 값이 변경될 때마다 UI 업데이트
                      });
                    },
                  ),
                ),
                SizedBox(width: 8),
                Text('원'),
              ],
            ),
          ],
        ),
      ],
    );
  }

  void _setAmountControllers() {
    int totalAmount = int.tryParse(_totalAmountController.text) ?? 0;
    for (int i = 0; i < _percentageControllers.length; i++) {
      int percentage = int.tryParse(_percentageControllers[i].text) ?? 0;
      _amountControllers[i].text = ((totalAmount * percentage) / 100).toStringAsFixed(0);
    }
  }

  void _updateAmountController(int index) {
    int totalAmount = int.tryParse(_totalAmountController.text) ?? 0;
    int percentage = int.tryParse(_percentageControllers[index].text) ?? 0;
    _amountControllers[index].text = ((totalAmount * percentage) / 100).toStringAsFixed(0);
  }

  void _updatePercentageController(int index) {
    int totalAmount = int.tryParse(_totalAmountController.text) ?? 0;
    int amount = int.tryParse(_amountControllers[index].text) ?? 0;
    if (totalAmount != 0) {
      _percentageControllers[index].text = ((amount * 100) / totalAmount).toStringAsFixed(0);
    }
  }

  String _calculatePerPerson() {
    int totalAmount = int.tryParse(_totalAmountController.text) ?? 0;
    return (totalAmount / members.length).toStringAsFixed(0);
  }

  void _handleAdjustmentRequest() {
    int totalAmount = _amountControllers
        .map((controller) => int.tryParse(controller.text) ?? 0)
        .fold(0, (sum, value) => sum + value);

    int totalAmountInput = int.tryParse(_totalAmountController.text) ?? 0;

    if (totalAmount != totalAmountInput) {
      debugPrint('총 결제 금액과 입력한 개인 요금의 합이 일치하지 않습니다.');
      setState(() {
        _isWarningVisible = true;
        for (int i = 0; i < _amountControllers.length; i++) {
          _isAmountFieldInvalid[i] = true;
        }
      });
    } else {
      // 개인 요금의 합이 총 결제 금액과 일치할 경우 처리할 코드
      setState(() {
        _isWarningVisible = false;
        for (int i = 0; i < _amountControllers.length; i++) {
          _isAmountFieldInvalid[i] = false;
        }
      });
      debugPrint('일치.');
      Navigator.of(context).pop();
    }
  }

  @override
  void dispose() {
    _totalAmountController.dispose();
    _percentageControllers.forEach((controller) => controller.dispose());
    _amountControllers.forEach((controller) => controller.dispose());
    super.dispose();
  }
}