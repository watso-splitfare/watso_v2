import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:watso_v2/taxi/repository/taxi_repository.dart';

import '../model/taxi_model.dart';

part 'main_provider.g.dart';

@riverpod
class FilterOptions extends _$FilterOptions {
  @override
  TaxiOption build() {
    return TaxiOption(
      departDatetime: DateTime.now(),
      direction: TaxiDirection.STATION,
    );
  }

  changeDirection({TaxiDirection? direction}) {
    if (direction == null) {
      state = state.copyWith(
        direction: state.direction == TaxiDirection.CAMPUS
            ? TaxiDirection.STATION
            : TaxiDirection.CAMPUS,
      );
    } else {
      state = state.copyWith(direction: direction);
    }
  }

  changeDate(DateTime date) {
    state = state.copyWith(departDatetime: date);
  }

  beforeDate() {
    changeDate(state.departDatetime.subtract(Duration(days: 1)));
  }

  afterDate() {
    changeDate(state.departDatetime.add(Duration(days: 1)));
  }
}

// TaxiGroupList
@riverpod
Future<List<TaxiGroup>> filteredGroups(FilteredGroupsRef ref) {
  final filter = ref.watch(filterOptionsProvider);

  return ref.read(taxiRepositoryProvider).getTaxiGroups(
        direction: filter.direction,
        departDatetime: filter.departDatetime,
      );
}
