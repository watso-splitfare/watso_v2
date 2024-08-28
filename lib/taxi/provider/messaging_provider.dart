//maker riverpod notifier with family
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:watso_v2/taxi/model/taxi_model.dart';

import '../repository/taxi_repository.dart';

part 'messaging_provider.g.dart';

@riverpod
class MessagingHeader extends _$MessagingHeader {
  @override
  Future<TaxiGroup> build(int pageId) async {
    final data =
        await ref.read(taxiRepositoryProvider).getTaxiGroup(id: pageId);
    return data;
  }

  updateStatus(TaxiStatus status) async {
    if (!state.hasValue) return;
    int id = state.value!.id;
    await ref
        .read(taxiRepositoryProvider)
        .updateTaxiGroup(id: id, status: status.name);
    ref.refresh(messagingHeaderProvider(id));
  }
}
