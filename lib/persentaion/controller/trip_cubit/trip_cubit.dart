import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';

import 'package:limousine_driver/domin/usese_cases/trip_uses_cases/home_trip_use_case.dart';
import 'package:http/http.dart' as http;
import '../../../core/helpers/functions.dart';
import '../../../core/utlis/api_constatns.dart';
import '../../../core/utlis/app_model.dart';
import '../../../core/utlis/enums.dart';
import '../../../data/models/history_response.dart';
import '../../../data/models/rsponse_home.dart';

part 'trip_state.dart';

class TripCubit extends Cubit<TripState> {
  HomeTripUseCase homeTripUseCase;
  TripCubit(this.homeTripUseCase) : super(TripState());

  static TripCubit get(context) => BlocProvider.of<TripCubit>(context);

  homeTrip({userId, lat, lng, address}) async {
    emit(state.copyWith(homeState: RequestState.loading));
    final result = await homeTripUseCase.execute(
        userId: currentUser.id, lat: lat, lng: lng, address: address);
    result.fold((l) => emit(state.copyWith(homeState: RequestState.error)),
        (r) {
      driver = r.driver;
      currentUser.email = r.driverDetail!.email;
      currentUser.fullName = r.driverDetail!.fullName;
      currentUser.profileImage = r.driverDetail!.profileImage;
      currentUser.deviceToken = r.driverDetail!.deviceToken;
      if (r.driver!.status == 0) {
        statusDriver = false;
      } else {
        statusDriver = true;
      }
      emit(state.copyWith(
          homeState: RequestState.loaded,
          responseHome: r,
          statusDriver: r.driver!.status));
    });
  }

  getAddressLabel({lat, lng}) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(lat, lng);

    currentLocation =
        "${placemarks[0].name},${placemarks[0].country},${placemarks[0].street}";
  }

  /// Todo : refactor
  changeStatusTrip({tripId, status, userId}) async {
    emit(state.copyWith(changeStatusTrip: RequestState.loading));
    var request = http.MultipartRequest(
        'POST', Uri.parse(ApiConstants.changeStatusTripPath));
    request.fields.addAll({
      'status': status.toString(),
      'tripId': tripId.toString(),
      'userId': userId
    });

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(response.statusCode.toString());
      emit(state.copyWith(changeStatusTrip: RequestState.loaded));
      homeTrip(
          userId: currentUser.id,
          lat: locData.latitude,
          lng: locData.longitude,
          address: "");
    } else {
      print(response.statusCode.toString());
      emit(state.copyWith(changeStatusTrip: RequestState.error));
    }
  }

  bool statusDriver = false;

  /// Todo : refactor
  changeStatusDriver({status, driverId}) async {
    if (status == 0) {
      statusDriver = false;
    } else {
      statusDriver = true;
    }
    emit(state.copyWith(statues: status));
    var request = http.MultipartRequest(
        'POST', Uri.parse(ApiConstants.changeStatusDriverPath));
    request.fields
        .addAll({'status': status.toString(), 'driverId': driverId.toString()});

    http.StreamedResponse response = await request.send();
    print("updateDeviceStatus = : -" + response.statusCode.toString());
    if (response.statusCode == 200) {
      print(response.statusCode.toString());
      emit(state.copyWith(statusDriver: status));
      // homeTrip(
      //     userId: currentUser.id,
      //     lat: locData.latitude,
      //     lng: locData.longitude,
      //     address: "");
    } else {
      print(response.statusCode.toString());
      // emit(state.copyWith(statusDriver: RequestState.error));
    }
  }

// Todo : refactor
  updateDeviceToken({userId, token}) async {
    emit(state.copyWith(updateDeviceTokenState: RequestState.loading));
    // var headers = {'Authorization': currentUser.token!};
    var request = http.MultipartRequest(
        'POST', Uri.parse(ApiConstants.updateDeviceTokenPath));
    request.fields.addAll({'userId': currentUser.id!, 'token': token});
    // request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    // print("updateDeviceToken = : -" + response.statusCode.toString());
    if (response.statusCode == 200) {
      emit(state.copyWith(updateDeviceTokenState: RequestState.loaded));
    } else {
      // print("updateDeviceToken = : -" + response.reasonPhrase.toString());
      emit(state.copyWith(updateDeviceTokenState: RequestState.error));
    }
  }

  /// git history trips
  getHistoriesTrips() async {
    emit(state.copyWith(getHistoriesState: RequestState.loading));
    var request =
        http.MultipartRequest('GET', Uri.parse(ApiConstants.getHistoriesPath));
    request.fields.addAll({'driverId': driver!.id.toString()});

    http.StreamedResponse response = await request.send();
    print(response.statusCode.toString() + " =====> getHistories ");
    if (response.statusCode == 200) {
      String jsonDataString = await response.stream.bytesToString();
      final jsonData = jsonDecode(jsonDataString);
      ResponseHistory responseHistory = ResponseHistory.fromJson(jsonData);
      emit(state.copyWith(
          getHistoriesState: RequestState.loaded, histories: responseHistory));
    } else {
      print(response.reasonPhrase);
      emit(state.copyWith(getHistoriesState: RequestState.error));
    }
  }
}
