part of 'trip_cubit.dart';

class TripState extends Equatable {
  final ResponseHome? responseHome;
  final RequestState? homeState;
  final RequestState? changeStatusTrip;
  final RequestState? updateDeviceTokenState;
  final int? statusDriver;
  // grt histories
  final RequestState? getHistoriesState;
  final ResponseHistory? histories;

  TripState(
      {this.statusDriver,
      this.homeState,
      this.responseHome,
      this.changeStatusTrip,
      this.updateDeviceTokenState,
      this.getHistoriesState,
      this.histories});

  TripState copyWith(
          {final statues,
          final int? statusDriver,
          final ResponseHome? responseHome,
          final RequestState? homeState,
          final RequestState? changeStatusTrip,
          final RequestState? updateDeviceTokenState,
          final RequestState? getHistoriesState,
          final ResponseHistory? histories}) =>
      TripState(
        homeState: homeState ?? this.homeState,
        statusDriver: statusDriver ?? this.statusDriver,
        responseHome: responseHome ?? this.responseHome,
        changeStatusTrip: changeStatusTrip ?? this.changeStatusTrip,
        updateDeviceTokenState:
            updateDeviceTokenState ?? this.updateDeviceTokenState,
        getHistoriesState: getHistoriesState ?? this.getHistoriesState,
        histories: histories ?? this.histories,
      );

  @override
  List<Object?> get props => [
        homeState,
        responseHome,
        changeStatusTrip,
        updateDeviceTokenState,
        statusDriver,
        histories,
        getHistoriesState
      ];
}
