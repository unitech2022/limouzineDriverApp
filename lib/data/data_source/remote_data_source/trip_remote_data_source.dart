import 'dart:convert';


import 'package:http/http.dart' as http;


import '../../../core/network/error_message_model.dart';
import '../../../core/utlis/api_constatns.dart';
import '../../models/rsponse_home.dart';

abstract class BaseTripRemoteDataSource {


  Future<ResponseHome> homeDriver({userId,lat,lng,address});
}

class TripRemoteDataSource extends BaseTripRemoteDataSource {
 
  
  @override
  Future<ResponseHome> homeDriver({userId,lat,lng,address}) async{
      var request =
        http.MultipartRequest('GET', Uri.parse("${ApiConstants.homeDriverPath}userId=$userId&lat=$lat&Lang=$lng&address=$address"));
  

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String jsonsDataString = await response.stream.bytesToString();
      final jsonData = jsonDecode(jsonsDataString);

      return ResponseHome.fromJson(jsonData);
    } else {
      throw ErrorMessageModel(
          statusCode: response.statusCode,
          statusMessage: "حدث خطأ, حاول مرة أخرى");
    }
  }
}
