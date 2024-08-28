import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../model/taxi_model.dart';

part 'create_provider.g.dart';

@riverpod
class CreateTaxi extends _$CreateTaxi {
  @override
  CreateTaxiGroup build() {
    return CreateTaxiGroup(
      maxMember: 4,
      departDatetime: DateTime.now(),
      direction: TaxiDirection.STATION,
    );
  }

  changeDirection() {
    state = state.copyWith(
      direction: state.direction == TaxiDirection.CAMPUS
          ? TaxiDirection.STATION
          : TaxiDirection.CAMPUS,
    );
  }

  changeDate(DateTime date) {
    state = state.copyWith(
      departDatetime: date,
    );
  }

  addMember() {
    if (state.maxMember >= 4) return;
    state = state.copyWith(maxMember: state.maxMember + 1);
  }

  removeMember() {
    if (state.maxMember <= 2) return;
    state = state.copyWith(maxMember: state.maxMember - 1);
  }
}
