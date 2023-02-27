import 'package:dartz/dartz.dart';
import 'package:limousine_driver/domin/entities/driver.dart';

import '../../core/failur/failure.dart';


abstract class BaseDriverRepository{
  Future<Either<Failure, Driver>> addDriver(Driver driver);


}