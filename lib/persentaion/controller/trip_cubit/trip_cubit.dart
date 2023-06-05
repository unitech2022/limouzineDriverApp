import 'dart:convert';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:limousine_driver/core/helpers/helper_functions.dart';
import 'package:limousine_driver/core/routers/routers.dart';
import 'package:limousine_driver/data/models/external_trip.dart';
import 'package:limousine_driver/domin/usese_cases/trip_uses_cases/home_trip_use_case.dart';
import 'package:http/http.dart' as http;
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import '../../../core/helpers/functions.dart';
import '../../../core/utlis/api_constatns.dart';
import '../../../core/utlis/app_model.dart';
import '../../../core/utlis/enums.dart';
import '../../../data/models/address_model.dart';
import '../../../data/models/city_model.dart';
import '../../../data/models/external_trip_details.dart';
import '../../../data/models/group.dart';
import '../../../data/models/group_details.dart';
import '../../../data/models/history_response.dart';
import '../../../data/models/rsponse_home.dart';
import '../../ui/sign_up_screen/steps_sign_screens/create_account_driver_screen.dart';
part 'trip_state.dart';

class TripCubit extends Cubit<TripState> {
  HomeTripUseCase homeTripUseCase;
  TripCubit(this.homeTripUseCase) : super(TripState());

  static TripCubit get(context) => BlocProvider.of<TripCubit>(context);

  homeTrip2({userId, lat, lng, address, context}) async {
    emit(TripState(homeState: RequestState.loading));
    var request = http.Request(
        'GET',
        Uri.parse(
            "${ApiConstants.homeDriverPath}userId=${userId}&lat=${lat.toString()}&lang=${lng.toString()}&address=$address"));

    http.StreamedResponse response = await request.send();
    print(response.statusCode.toString() + "home driver");
    if (response.statusCode == 200) {
      String jsonsDataString = await response.stream.bytesToString();
      final jsonData = jsonDecode(jsonsDataString);

      ResponseHome responseHome = ResponseHome.fromJson(jsonData);
      print(responseHome);
      driver = responseHome.driver;
      if (responseHome.driverDetail != null) {
        currentUser.email = responseHome.driverDetail!.email;
        currentUser.fullName = responseHome.driverDetail!.fullName;
        currentUser.profileImage = responseHome.driverDetail!.profileImage;
        currentUser.deviceToken = responseHome.driverDetail!.deviceToken;
      }

      if (responseHome.driver!.status == 0) {
        statusDriver = false;
      } else {
        statusDriver = true;
      }

      await getCities();
      emit(state.copyWith(
          homeState: RequestState.loaded,
          responseHome: responseHome,
          statusDriver: responseHome.driver!.status));
    } else {
      emit(state.copyWith(homeState: RequestState.error));
    }
  }

  homeTrip({userId, lat, lng, address, context}) async {
    emit(state.copyWith(homeState: RequestState.loading));
    final result = await homeTripUseCase.execute(
        userId: currentUser.id, lat: lat, lng: lng, address: address);
    result.fold((l) {
      if (l.message == "404") {
        pushPage(context: context, page: CreateAccountDriverScreen());
      }
      emit(state.copyWith(homeState: RequestState.error));
    }, (r) {
      driver = r.driver;
      if (r.driverDetail != null) {
        currentUser.email = r.driverDetail!.email;
        currentUser.fullName = r.driverDetail!.fullName;
        currentUser.profileImage = r.driverDetail!.profileImage;
        currentUser.deviceToken = r.driverDetail!.deviceToken;
      }

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
      homeTrip2(
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

//** external trip  */
  setCityPoint(City city, String type) {
    if (type == "start") {
      emit(state.copyWith(startCity: city));
    } else {
      emit(state.copyWith(endCity: city));
    }
    print(city.name);
  }

  List<City> filteredList = [];
  searchCity(String search) {
    filteredList = [];

    emit(state.copyWith(searchCity: RequestState.loading));
    filteredList = cities
        .where((element) => AppModel.lang == "ar"
            ? element.name!.toLowerCase().contains(search.trim().toLowerCase())
            : element.name_eng!
                .toLowerCase()
                .contains(search.trim().toLowerCase()))
        .toList();
    emit(state.copyWith(searchCity: RequestState.loaded));
  }

  String detailsAddress = "";
  bool loading = false;
  Future getAddresses(double lat, double long) async {
    loading = true;
    emit(state.copyWith(movMapState: RequestState.loading));
    List<Placemark> placemarks = await placemarkFromCoordinates(lat, long,localeIdentifier: AppModel.lang);

    detailsAddress =
        "${placemarks[0].name},${placemarks[0].country},${placemarks[0].street}";

    // print( detailsAddress+
    // "====== > address");

    loading = false;
    emit(state.copyWith(movMapState: RequestState.loaded));
  }

  getStartLocation(AddressModel value, {context, type}) async {
    print(value.label! + "start location");
    if (type == 0)
      emit(state.copyWith(startPoint: value));
    else
      emit(state.copyWith(endPoint: value));
  }

  setTimeTrip(String value, int type) async {
    if (type == 0) {
      emit(state.copyWith(dateTrip: value));
    } else {
      emit(state.copyWith(endDateTrip: value));
    }
  }

  // ** getExternalTrips
  Future getExternalTrips() async {
    emit(state.copyWith(getExternalTripsState: RequestState.loading));
    var request = http.MultipartRequest(
        'GET', Uri.parse('${ApiConstants.baseUrl}/extrips/get-external-trips'));
    request.fields.addAll({'driverId': driver!.id.toString()});

    http.StreamedResponse response = await request.send();
    print(response.statusCode.toString() + " =======> getExternalTrips");
    if (response.statusCode == 200) {
      String jsonDataString = await response.stream.bytesToString();
      final jsonData = jsonDecode(jsonDataString);

      emit(state.copyWith(
          getExternalTripsState: RequestState.loaded,
          externalTrips: List<ExternalTrip>.from(
              (jsonData as List).map((e) => ExternalTrip.fromJson(e)))));
    } else {
      emit(state.copyWith(getExternalTripsState: RequestState.error));
    }
  }

  //** add external Trip
  addExternalTrip(
      {price,
      cityStart,
      cityEnd,
      date,
      sets,
      name,
      startLat,
      startLng,
      endLat,
      endTirpTime,
      endLng,
      context}) async {
    emit(state.copyWith(addExternalTripState: RequestState.loading));
    var request = http.MultipartRequest(
        'POST', Uri.parse('${ApiConstants.baseUrl}/extrips/add-trip'));
    request.fields.addAll({
      'driverId': driver!.id.toString(),
      'price': price.toString(),
      'userId': '',
      'startPointLat': startLat.toString(),
      'startPointLng': startLng.toString(),
      'endPointLat': endLat.toString(),
      'endPointLng': endLng.toString(),
      'startCity': cityStart,
      'endCity': cityEnd,
      'Sets': sets.toString(),
      'StartingAt': date,
      'name': name,
      'endTime': endTirpTime
    });

    http.StreamedResponse response = await request.send();
    print(response.statusCode.toString() + " =======> addExternalTrip");
    if (response.statusCode == 200) {
      pushPageRoutName(context, externalTrip);

      showTopMessage(
          context: context,
          customBar: CustomSnackBar.success(
              backgroundColor: Colors.green,
              message: "تم اضافة الرحلة بنجاح".tr(),
              textStyle: TextStyle(
                  fontFamily: "font", fontSize: 16, color: Colors.white)));
      emit(state.copyWith(addExternalTripState: RequestState.loaded));
    } else {
      emit(state.copyWith(addExternalTripState: RequestState.error));
    }
  }

//** update externalTrip */
  Future updateExternalTrip(
      {price,
      cityStart,
      cityEnd,
      date,
      sets,
      name,
      startLat,
      startLng,
      endLat,
      endTirpTime,
      endLng,
      context,
      id}) async {
    emit(state.copyWith(updateExternalTripState: RequestState.loading));
    var request = http.MultipartRequest('POST',
        Uri.parse('${ApiConstants.baseUrl}/extrips/update-external-trip'));
    request.fields.addAll({
      'driverId': driver!.id.toString(),
      'price': price.toString(),
      'userId': '',
      'startPointLat': startLat.toString(),
      'startPointLng': startLng.toString(),
      'endPointLat': endLat.toString(),
      'endPointLng': endLng.toString(),
      'startCity': cityStart,
      'endCity': cityEnd,
      'Sets': sets.toString(),
      'StartingAt': date,
      'name': name,
      'endTime': endTirpTime,
      'id': id.toString()
    });

    http.StreamedResponse response = await request.send();
    print(response.statusCode.toString() + " =========== > updateExternalTrip");
    if (response.statusCode == 200) {
      pushPageRoutName(context, externalTrip);
      showSnakeBar(
          message: "تم التعديل  بنجاح".tr(),
          context: context,
          color: Colors.green);
      emit(state.copyWith(updateExternalTripState: RequestState.loaded));
    } else {
      emit(state.copyWith(updateExternalTripState: RequestState.error));
    }
  }

//** details external trip */
  getExternalTripDetails({groupId}) async {
    emit(state.copyWith(getGroupDetailsState: RequestState.loading));
    var request =
        http.MultipartRequest('GET', Uri.parse(ApiConstants.getGroupDetails));

    request.fields.addAll({'tripId': groupId.toString()});
    http.StreamedResponse response = await request.send();

    print(response.statusCode.toString() + " ====== > getGroupDetails");
    if (response.statusCode == 200) {
      String jsonDataString = await response.stream.bytesToString();
      final jsonData = jsonDecode(jsonDataString);

      emit(state.copyWith(
          getGroupDetailsState: RequestState.loaded,
          groupDetails: ExternalTripDetails.fromJson(jsonData)));
    } else {
      emit(state.copyWith(getGroupDetailsState: RequestState.error));
    }
  }

//** accept external trip */
  Future acceptExternalTrip({bookingId, status, tripId}) async {
    // emit(state.copyWith(acceptExternalTrip: RequestState.loading));
    var request = http.MultipartRequest('POST',
        Uri.parse('${ApiConstants.baseUrl}/Bookings/change-status-booking'));
    request.fields.addAll(
        {'bookingId': bookingId.toString(), 'status': status.toString(),'type': "1"});

    http.StreamedResponse response = await request.send();
    print(response.statusCode.toString() + " ========> acceptExternalTrip");
    if (response.statusCode == 200) {
      emit(state.copyWith(acceptExternalTrip: RequestState.loaded));
      getExternalTripDetails(groupId: tripId);
    } else {
      emit(state.copyWith(acceptExternalTrip: RequestState.error));
    }
  }

  Future deleteExternalTrip({tripId, context}) async {
    emit(state.copyWith(deleteExternalTripState: RequestState.loading));
    var request = http.MultipartRequest('DELETE',
        Uri.parse('${ApiConstants.baseUrl}/extrips/delete-external-trip'));
    request.fields.addAll({'tripId': tripId.toString()});

    http.StreamedResponse response = await request.send();
    print(response.statusCode.toString() + "  ======> deleteExternalTrip");
    if (response.statusCode == 200) {
   
showTopMessage(
          context: context,
          customBar: CustomSnackBar.success(
              backgroundColor: Colors.green,
              message: "تم الحذف بنجاح".tr(),
              textStyle: TextStyle(
                  fontFamily: "font", fontSize: 16, color: Colors.white)));

      pushPageRoutName(context, externalTrip);
      emit(state.copyWith(deleteExternalTripState: RequestState.loaded));
    } else {
      print(response.reasonPhrase);
      emit(state.copyWith(deleteExternalTripState: RequestState.error));
    }
  }

// get group

  getGroups() async {
    emit(state.copyWith(getGroupsState: RequestState.loading));
    var request =
        http.MultipartRequest('GET', Uri.parse(ApiConstants.getGroupsPath));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String jsonDataString = await response.stream.bytesToString();
      final jsonData = jsonDecode(jsonDataString);

      emit(state.copyWith(
          getGroupsState: RequestState.loaded,
          groupsLocation: List<Group>.from(
              (jsonData as List).map((e) => Group.fromJson(e)))));
    } else {
      emit(state.copyWith(getGroupsState: RequestState.error));
    }
  }

// getGroup Details
  // getGroupDetails({groupId}) async {
  //   emit(state.copyWith(getGroupDetailsState: RequestState.loading));
  //   var request = http.MultipartRequest(
  //       'GET', Uri.parse(ApiConstants.getGroupDetails + groupId.toString()));

  //   http.StreamedResponse response = await request.send();

  //   print(response.statusCode.toString() + " ====== > getGroupDetails");
  //   if (response.statusCode == 200) {
  //     String jsonDataString = await response.stream.bytesToString();
  //     final jsonData = jsonDecode(jsonDataString);

  //     emit(state.copyWith(
  //         getGroupDetailsState: RequestState.loaded,
  //         groupDetails: GroupDetails.fromJson(jsonData)));
  //   } else {
  //     emit(state.copyWith(getGroupDetailsState: RequestState.error));
  //   }
  // }

// accept trip
  acceptTrip({groupId, status, context}) async {
    emit(state.copyWith(acceptGroupState: RequestState.loading));

    var request =
        http.MultipartRequest('POST', Uri.parse(ApiConstants.acceptGroup));
    request.fields.addAll({
      'groupId': groupId.toString(),
      'driverId': driver!.id.toString(),
      'status': status.toString()
    });

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      emit(state.copyWith(acceptGroupState: RequestState.loaded));
      // await getGroupDetails(groupId: groupId);
      showSnakeBar(message: "تم قبول الرحلة", context: context);
    } else {
      emit(state.copyWith(acceptGroupState: RequestState.error));
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
