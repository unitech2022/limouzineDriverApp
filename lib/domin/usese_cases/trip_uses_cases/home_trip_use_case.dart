import 'package:dartz/dartz.dart';


import '../../../core/failur/failure.dart';
import '../../../data/models/rsponse_home.dart';
import '../../entities/trip.dart';
import '../../repository/trip_base_repository.dart';

class HomeTripUseCase{
  final BaseTripRepository repository;

  HomeTripUseCase(this.repository);

  Future<Either<Failure,ResponseHome>> execute({userId,lat,lng,address})async{

    return await repository.homeDriver(userId: userId,lat: lat,lng: lng,address: address);
  }
}