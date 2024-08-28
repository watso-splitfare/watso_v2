import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:watso_v2/taxi/model/user_model.dart';

part 'taxi_model.freezed.dart';
part 'taxi_model.g.dart';

@freezed
class TaxiOption with _$TaxiOption {
  const factory TaxiOption({
    required DateTime departDatetime,
    required TaxiDirection direction,
  }) = _TaxiOption;

  factory TaxiOption.fromJson(Map<String, dynamic> json) =>
      _$TaxiOptionFromJson(json);
}

@freezed
class CreateTaxiGroup with _$CreateTaxiGroup {
  const factory CreateTaxiGroup({
    required int maxMember,
    required DateTime departDatetime,
    required TaxiDirection direction,
  }) = _CreateTaxiGroup;

  factory CreateTaxiGroup.fromJson(Map<String, dynamic> json) =>
      _$CreateTaxiGroupFromJson(json);
}

// {
// "id": 1719843797268,
// "owner_id": 1719843797268,
// "status": "OPEN",
// "direction": "CAMPUS",
// "depart_datetime": "2024-08-25T18:06:37",
// "fee": {
// "total": 6200,
// "cost": 3100
// },
// "member": {
// "current_member": 1,
// "max_member": 4,
// "members": [
// 1719843797268
// ]
// }
// }
@freezed
class TaxiGroup with _$TaxiGroup {
  const factory TaxiGroup({
    required int id,
    required MyUser owner,
    required TaxiStatus status,
    required DateTime departDatetime,
    required TaxiDirection direction,
    required TaxiFee fee,
    required TaxiMember member,
  }) = _TaxiGroup;

  factory TaxiGroup.fromJson(Map<String, dynamic> json) =>
      _$TaxiGroupFromJson(json);
}

@freezed
class TaxiFee with _$TaxiFee {
  const factory TaxiFee({
    required int total,
    required int cost,
  }) = _TaxiFee;

  factory TaxiFee.fromJson(Map<String, dynamic> json) =>
      _$TaxiFeeFromJson(json);
}

enum TaxiStatus { OPEN, CLOSE, SETTLE, COMPLETE }

// TaxiStatus enum에 대한 확장 메서드 정의
extension TaxiStatusExtension on TaxiStatus {
  String toKr() {
    switch (this) {
      case TaxiStatus.OPEN:
        return '모집';
      case TaxiStatus.CLOSE:
        return '마감';
      case TaxiStatus.SETTLE:
        return '정산';
      case TaxiStatus.COMPLETE:
        return '완료';
    }
  }
}

enum TaxiDirection { CAMPUS, STATION }

extension TaxiDirectionExtension on TaxiDirection {
  String toKorean() {
    switch (this) {
      case TaxiDirection.CAMPUS:
        return '부산대 밀양캠';
      case TaxiDirection.STATION:
        return '밀양역';
    }
  }
}

@freezed
class TaxiMember with _$TaxiMember {
  const factory TaxiMember({
    required int currentMember,
    required int maxMember,
    @Default([]) List<int> members,
  }) = _TaxiMember;

  factory TaxiMember.fromJson(Map<String, dynamic> json) =>
      _$TaxiMemberFromJson(json);
}

@freezed
class TaxiBill with _$TaxiBill {
  const factory TaxiBill({
    required MyUser user,
    required int cost,
  }) = _TaxiBill;

  factory TaxiBill.fromJson(Map<String, dynamic> json) =>
      _$TaxiBillFromJson(json);

  @override
  Map<String, dynamic> toJson() => {
        'user_id': user.id,
        'cost': cost,
      };
}

@freezed
class TaxiTotalFee with _$TaxiTotalFee {
  const TaxiTotalFee._();

  const factory TaxiTotalFee({
    required int fee,
    required List<TaxiBill> bills,
  }) = _TaxiTotalFee;

  factory TaxiTotalFee.fromJson(Map<String, dynamic> json) =>
      _$TaxiTotalFeeFromJson(json);

  int get billCostSum {
    return bills.fold(
        0, (previousValue, element) => previousValue + element.cost);
  }

  Map<String, int> get feeDivided {
    double feeDivided = fee / bills.length;
    int memberFee = feeDivided.ceil();
    int ownerFee = fee - memberFee * (bills.length - 1);
    return {'memberFee': memberFee, 'ownerFee': ownerFee};
  }
}
