part of 'trip_cubit.dart';

class TripState extends Equatable {
  final ResponseHome? responseHome;
  final RequestState? homeState;
  final RequestState? changeStatusTrip;




  TripState(
      {
      this.homeState,
      this.responseHome,
      this.changeStatusTrip
     });

  TripState copyWith(
          {
          final statues,
          final ResponseHome? responseHome,
          final RequestState? homeState,
           final RequestState? changeStatusTrip
        }) =>
      TripState(
          homeState: homeState ?? this.homeState,
          responseHome: responseHome ?? this.responseHome,
          changeStatusTrip: changeStatusTrip??this.changeStatusTrip
         );

  @override
  List<Object?> get props => [
      
        homeState,
        responseHome,changeStatusTrip
      ];
}
