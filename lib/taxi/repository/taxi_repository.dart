import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../common/dio/dio.dart';
import '../model/taxi_model.dart';

part 'taxi_repository.g.dart';

@Riverpod(keepAlive: true)
TaxiRepository taxiRepository(TaxiRepositoryRef ref) {
  final dio = ref.watch(dioProvider);
  return TaxiRepository(dio);
}

@RestApi()
abstract class TaxiRepository {
  factory TaxiRepository(Dio dio) = _TaxiRepository;

  @GET('/taxi')
  Future<List<TaxiGroup>> getTaxiGroups({
    @Query('direction') required TaxiDirection direction,
    @Query('depart_datetime') required DateTime departDatetime,
    @Query('option') String option = 'JOINABLE',
  });

  @GET('/taxi')
  Future<List<TaxiGroup>> getCompletedTaxiGroups();

  @GET('/taxi')
  Future<List<TaxiGroup>> getJoinedTaxiGroups({
    @Query('option') String option = 'JOINED',
  });

  @GET('/taxi/{id}')
  Future<TaxiGroup> getTaxiGroup({
    @Path() required int id,
  });

  @POST('/taxi')
  Future<void> createTaxiGroup({
    @Body() required CreateTaxiGroup group,
  });

  @PATCH('/taxi/{id}/{status}')
  Future<void> updateTaxiGroup({
    @Path() required int id,
    @Path() required String status,
  });

  @POST('/taxi/{id}/member')
  Future<void> joinTaxiGroup({
    @Path() required int id,
  });

  @DELETE('/taxi/{id}/member')
  Future<void> leaveTaxiGroup({
    @Path() required int id,
  });

  @GET('/taxi/{id}/fee')
  Future<TaxiTotalFee> getFee({
    @Path() required int id,
  });

  @PATCH('/taxi/{id}/fee')
  Future<void> updateFee({
    @Path() required int id,
    @Body() required TaxiTotalFee totalFee,
  });
}
