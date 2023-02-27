import 'package:dartz/dartz.dart';

import 'package:limousine_driver/core/failur/failure.dart';

import 'package:limousine_driver/domin/entities/driver.dart';

import '../../core/error/exceptions.dart';
import '../../domin/repository/base_driver_repository.dart';
import '../data_source/remote_data_source/driver_remote_data_source.dart';

class DriverRepository extends BaseDriverRepository {
  final BaseDriverRemoteDataSource baseRemoteDataSource;


  DriverRepository(this.baseRemoteDataSource);

  @override
  Future<Either<Failure, Driver>> addDriver(Driver driver)async {

    final result = await baseRemoteDataSource.addDriver(driver);

    try {
      return Right(result);
    } on ServerExceptions catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }




}
