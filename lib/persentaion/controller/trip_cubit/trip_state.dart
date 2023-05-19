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
    final RequestState? getGroupsState;
  final List<Group> groupsLocation;
   final RequestState? getGroupDetailsState;
  final GroupDetails? groupDetails;
   final RequestState? acceptGroupState;

  TripState(
      {this.statusDriver,
      this.homeState,
      this.responseHome,
      this.changeStatusTrip,
      this.updateDeviceTokenState,
      this.getHistoriesState,
      this.histories,
       this.groupsLocation = const [],
      this.getGroupsState,
        this.getGroupDetailsState,
      this.groupDetails,
      this.acceptGroupState
      });

  TripState copyWith(
          {final statues,
          final int? statusDriver,
          final ResponseHome? responseHome,
          final RequestState? homeState,
          final RequestState? changeStatusTrip,
          final RequestState? updateDeviceTokenState,
          final RequestState? getHistoriesState,
          final ResponseHistory? histories,
            final List<Group>? groupsLocation,
          final RequestState? getGroupsState,
           final RequestState? getGroupDetailsState,
  final GroupDetails? groupDetails,
    final RequestState? acceptGroupState
          }) =>
      TripState(
        homeState: homeState ?? this.homeState,
        statusDriver: statusDriver ?? this.statusDriver,
        responseHome: responseHome ?? this.responseHome,
        changeStatusTrip: changeStatusTrip ?? this.changeStatusTrip,
        updateDeviceTokenState:
            updateDeviceTokenState ?? this.updateDeviceTokenState,
        getHistoriesState: getHistoriesState ?? this.getHistoriesState,
        histories: histories ?? this.histories,
         getGroupsState: getGroupsState ?? this.getGroupsState,
        groupsLocation: groupsLocation ?? this.groupsLocation,
        groupDetails: groupDetails ?? this.groupDetails,
        getGroupDetailsState: getGroupDetailsState ?? this.getGroupDetailsState,
         acceptGroupState: acceptGroupState ?? this.acceptGroupState,
      );

  @override
  List<Object?> get props => [
        homeState,
        responseHome,
        changeStatusTrip,
        updateDeviceTokenState,
        statusDriver,
        histories,
        getHistoriesState,
          getGroupsState,
        groupsLocation,
        getGroupDetailsState,
     groupDetails,
     acceptGroupState
      ];
}
