

import 'package:dartz/dartz.dart';

import '../../core/failur/failure.dart';
import '../../data/models/rsponse_home.dart';

abstract class BaseTripRepository{




  Future<Either<Failure, ResponseHome>> homeDriver({userId,lat,lng,address});
}