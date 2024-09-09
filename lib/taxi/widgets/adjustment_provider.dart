import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

// 총 결제 금액
final totalAmountProvider = StateProvider<int>((ref) => 6200);

// 각 멤버의 금액 비율
final percentageControllersProvider = StateNotifierProvider<PercentageAmountControllerNotifier, List<TextEditingController>>((ref) {
  return PercentageAmountControllerNotifier();
});

// 각 멤버의 금액
final amountControllersProvider = StateNotifierProvider<AmountControllerNotifier, List<TextEditingController>>((ref) {
  return AmountControllerNotifier();
});

// 경고 메시지
final isWarningVisibleProvider = StateProvider<bool>((ref) => false);

// 역할
final roleProvider = StateProvider<String>((ref) => 'OWNER');

// 멤버 비율 컨트롤러
class PercentageAmountControllerNotifier extends StateNotifier<List<TextEditingController>> {
  PercentageAmountControllerNotifier() : super(_initializeControllers());

  static List<TextEditingController> _initializeControllers() {
    List<String> members = ["찰봉", "준하", "창욱", "민지"];
    int tmpPercentage = 100 ~/ members.length;
    return List.generate(members.length, (index) => TextEditingController(text: tmpPercentage.toString()));
  }

  void updateController(int index, String value) {
    state[index].text = value;
    state = List.from(state);  // 상태 업데이트
  }
}

// 멤버 금액 컨트롤러
class AmountControllerNotifier extends StateNotifier<List<TextEditingController>> {
  AmountControllerNotifier() : super(_initializeControllers());

  static List<TextEditingController> _initializeControllers() {
    List<String> members = ["찰봉", "준하", "창욱", "민지"];
    int tmpAmount = 6200 ~/ members.length;
    return List.generate(members.length, (index) => TextEditingController(text: tmpAmount.toString()));
  }

  void updateController(int index, String value) {
    state[index].text = value;
    state = List.from(state);  // 상태 업데이트
  }
}