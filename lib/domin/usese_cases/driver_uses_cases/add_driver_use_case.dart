import 'package:dartz/dartz.dart';
import 'package:limousine_driver/domin/repository/base_driver_repository.dart';

import '../../../core/failur/failure.dart';
import '../../entities/driver.dart';


class AddDriverUseCase{
  final BaseDriverRepository repository;

  AddDriverUseCase(this.repository);

  Future<Either<Failure, Driver>> execute(Driver driver)async{

    return await repository.addDriver(driver);
  }
}