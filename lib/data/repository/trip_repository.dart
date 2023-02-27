import 'package:dartz/dartz.dart';
import 'package:limousine_driver/data/models/rsponse_home.dart';
import 'package:limousine_driver/core/failur/failure.dart';

import '../../core/error/exceptions.dart';
import '../../domin/repository/trip_base_repository.dart';
import '../data_source/remote_data_source/trip_remote_data_source.dart';

class TripRepository extends BaseTripRepository {
  final BaseTripRemoteDataSource baseRemoteDataSource;

  TripRepository(this.baseRemoteDataSource);

  @override
  Future<Either<Failure, ResponseHome>> homeDriver(
      {userId, lat, lng, address}) async {
    final result = await baseRemoteDataSource.homeDriver(
        userId: userId, lat: lat, lng: lng, address: address);

    try {
      return Right(result);
    } on ServerExceptions catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }
}
