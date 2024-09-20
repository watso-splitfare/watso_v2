import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

// 역할
const role = 'OWNER';

// 멤버
const List<String> members = ["찰봉", "준하", "창욱", "민지"];

// 총 결제 금액
final totalAmountControllerProvider = StateNotifierProvider<TotalAmountControllerNotifier, int>((ref) {
  final initialAmount = 6200; // 초기값
  return TotalAmountControllerNotifier(initialAmount);
});

// 각 멤버의 금액 비율
final percentageControllersProvider = StateNotifierProvider<PercentageAmountControllerNotifier, List<TextEditingController>>((ref) {
  return PercentageAmountControllerNotifier(ref);
});

// 각 멤버의 금액
final amountControllersProvider = StateNotifierProvider<AmountControllerNotifier, List<TextEditingController>>((ref) {
  return AmountControllerNotifier(ref);
});

// 경고 메시지
final isWarningVisibleProvider = StateProvider<bool>((ref) => false);

// 총 결제 금액 컨트롤러
class TotalAmountControllerNotifier extends StateNotifier<int> {
  late TextEditingController _controller;

  TotalAmountControllerNotifier(int initialAmount) : super(initialAmount) {
    _controller = TextEditingController(text: initialAmount.toString());
    _controller.addListener(updateController);
  }

  void updateController() {
    final newValue = int.tryParse(_controller.text) ?? 0;
    state = newValue;
  }

  TextEditingController get controller => _controller;
}

// 멤버 비율 컨트롤러
class PercentageAmountControllerNotifier extends StateNotifier<List<TextEditingController>> {
  PercentageAmountControllerNotifier(this.ref) : super(_initializeControllers(ref));

  final Ref ref;

  static List<TextEditingController> _initializeControllers(Ref ref) {
    int tmpPercentage = 100 ~/ members.length;
    return List.generate(members.length, (index) => TextEditingController(text: tmpPercentage.toString()));
  }

  void updateController(int index, String value) {
    state[index].text = value;
    state = List.from(state);  // 상태 업데이트

    updateAmountsFromPercentages();
  }

  void updateAmountsFromPercentages() {
    final totalAmount = ref.read(totalAmountControllerProvider);
    final AmountControllers = ref.read(amountControllersProvider.notifier);

    List<String> newAmounts = [];

    for (var percentageController in state) {
      int percentage = int.tryParse(percentageController.text) ?? 0;
      int amount = (totalAmount * (percentage/100)).ceil();
      newAmounts.add(amount.toString());
    }

    AmountControllers.state = List.generate(members.length, (index) {
      return TextEditingController(text: newAmounts[index]);
    });
  }
}

// 멤버 금액 컨트롤러
class AmountControllerNotifier extends StateNotifier<List<TextEditingController>> {
  AmountControllerNotifier(this.ref) : super(_initializeControllers(ref));

  final Ref ref;

  static List<TextEditingController> _initializeControllers(Ref ref) {
    int totalAmount = ref.read(totalAmountControllerProvider);
    int tmpAmount = totalAmount ~/ members.length;
    return List.generate(members.length, (index) => TextEditingController(text: tmpAmount.toString()));
  }

  void updateController(int index, String value) {
    state[index].text = value;
    state = List.from(state);  // 상태 업데이트

    updatePercentagesFromAmounts();
  }

  void updatePercentagesFromAmounts() {
    final totalAmount = ref.read(totalAmountControllerProvider);
    final percentageControllers = ref.read(percentageControllersProvider.notifier);

    List<String> newPercentages = [];

    for (var amountController in state) {
      int amount = int.tryParse(amountController.text) ?? 0;
      int percentage = (amount / totalAmount * 100).round();
      newPercentages.add(percentage.toString());
    }

    percentageControllers.state = List.generate(members.length, (index) {
      return TextEditingController(text: newPercentages[index]);
    });
  }

  int getAmountSum() {
    return state.fold<int>(0, (sum, controller) {
      int value = int.tryParse(controller.text) ?? 0;
      return sum + value;
    });
  }

  List<int> getAmounts() {
    return state.map((controller) {
      return int.tryParse(controller.text) ?? 0;
    }).toList();
  }
}