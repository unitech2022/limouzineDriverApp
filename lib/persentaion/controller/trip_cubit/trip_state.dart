part of 'trip_cubit.dart';

class TripState extends Equatable {
  final ResponseHome? responseHome;
  final RequestState? homeState;
  final RequestState? changeStatusTrip;
  final RequestState? updateDeviceTokenState;




  TripState(
      {
      this.homeState,
      this.responseHome,
      this.changeStatusTrip,this.updateDeviceTokenState
     });

  TripState copyWith(
          {
          final statues,
          final ResponseHome? responseHome,
          final RequestState? homeState,
           final RequestState? changeStatusTrip,
            final RequestState? updateDeviceTokenState
        }) =>
      TripState(
          homeState: homeState ?? this.homeState,
          responseHome: responseHome ?? this.responseHome,
          changeStatusTrip: changeStatusTrip??this.changeStatusTrip,
          updateDeviceTokenState: updateDeviceTokenState??this.updateDeviceTokenState
         );

  @override
  List<Object?> get props => [
      
        homeState,
        responseHome,changeStatusTrip,updateDeviceTokenState
      ];
}
