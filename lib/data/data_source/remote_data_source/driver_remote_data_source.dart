import 'dart:convert';

import 'package:limousine_driver/core/utlis/api_constatns.dart';
import 'package:limousine_driver/data/models/driver_model.dart';
import 'package:http/http.dart' as http;
import '../../../core/network/error_message_model.dart';
import '../../../domin/entities/driver.dart';

abstract class BaseDriverRemoteDataSource {
  Future<DriverModel> addDriver(Driver driver);

}

class DriverRemoteDataSource extends BaseDriverRemoteDataSource {
  @override
  Future<DriverModel> addDriver(Driver driver) async{

    var request = http.MultipartRequest('POST', Uri.parse(ApiConstants.addDriverPath  ,));
    request.fields.addAll({
      'UserId': driver.userId,
      'Passport': driver.passport,
      'DrivingLicense': driver.drivingLicense,
      'CarImage': driver.carImage,
      'CarModelId': driver.carModelId.toString(),
      'CarMakeYear': driver.carMakeYear,
      'ZoneId': driver.zoneId.toString(),
      'lat': driver.lat.toString(),
      'lng': driver.lng.toString()
    });


    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      String jsonsDataString = await response.stream.bytesToString();
      final jsonData = jsonDecode(jsonsDataString);
      return DriverModel.fromJson(jsonData);
    } else {
      throw ErrorMessageModel(
          statusCode: response.statusCode,
          statusMessage: "حدث خطأ, حاول مرة أخرى");
    }
  }
}