import 'package:equatable/equatable.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';

import 'package:limousine_driver/domin/usese_cases/trip_uses_cases/home_trip_use_case.dart';
import 'package:http/http.dart' as http;
import '../../../core/helpers/functions.dart';
import '../../../core/utlis/api_constatns.dart';
import '../../../core/utlis/app_model.dart';
import '../../../core/utlis/enums.dart';
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
      emit(state.copyWith(homeState: RequestState.loaded, responseHome: r));
    });
  }

  getAddressLabel({lat, lng}) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(lat, lng);

    currentLocation =
        "${placemarks[0].name},${placemarks[0].country},${placemarks[0].street}";
  }

  /// Todo : refactor
  changeStatusTrip({tripId, status}) async {
    emit(state.copyWith(changeStatusTrip: RequestState.loading));
    var request = http.MultipartRequest(
        'POST', Uri.parse(ApiConstants.changeStatusTripPath));
    request.fields
        .addAll({'status': status.toString(), 'tripId': tripId.toString()});

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
}
