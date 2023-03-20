

import 'package:limousine_driver/data/models/trip_model.dart';
import 'package:limousine_driver/data/models/user_response.dart';

import '../../domin/entities/driver.dart';
import '../../domin/entities/trip.dart';
import 'driver_model.dart';

class ResponseHome {
  final Trip? trip;
  final Driver? driver;
  final UserDetail? userDetail;
  final UserDetail? driverDetail;

  ResponseHome(
      {required this.trip,
     
      this.driver,
      this.userDetail,
      this.driverDetail});

  factory ResponseHome.fromJson(Map<String, dynamic> json) => ResponseHome(
      trip: json['trip'] != null ? TripModel.fromJson(json['trip']) : null,
      driver:
          json['driver'] != null ? DriverModel.fromJson(json['driver']) : null,
      userDetail: json['user'] != null
          ? UserDetail.fromJson(json['user'])
          : null,
           driverDetail: json['driverUser'] != null
          ? UserDetail.fromJson(json['driverUser'])
          : null,
     );
}
