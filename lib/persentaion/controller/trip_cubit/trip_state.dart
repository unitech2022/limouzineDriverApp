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
  final ExternalTripDetails? groupDetails;
  final RequestState? acceptGroupState;

  // trip external
  final RequestState? movMapState;
  final City? startCity;
  final City? endCity;
  final RequestState? searchCity;
  final AddressModel? endPoint;
  final AddressModel? startPoint;
  final String? dateTrip;
  final RequestState? addExternalTripState;
  final List<ExternalTrip>? externalTrips;
  final RequestState? getExternalTripsState;
  final String? endDateTrip;
  final RequestState? acceptExternalTrip;
    final RequestState? deleteExternalTripState;
     final RequestState? updateExternalTripState;

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
      this.acceptGroupState,
      this.startCity,
      this.endCity,
      this.searchCity,
      this.movMapState,
      this.startPoint,
      this.endPoint,
      this.dateTrip,
      this.addExternalTripState,
      this.externalTrips,
      this.getExternalTripsState,
      this.endDateTrip,
      this.acceptExternalTrip
      ,this.deleteExternalTripState,this.updateExternalTripState
      
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
          final ExternalTripDetails? groupDetails,
          final RequestState? acceptGroupState,
          final City? startCity,
          final City? endCity,
          final RequestState? searchCity,
          final RequestState? movMapState,
          final AddressModel? endPoint,
          final AddressModel? startPoint,
          final String? dateTrip,
          final String? endDateTrip,
          final RequestState? addExternalTripState,
          final List<ExternalTrip>? externalTrips,
          final RequestState? getExternalTripsState,
          final RequestState? acceptExternalTrip
          ,final RequestState? deleteExternalTripState,
             final RequestState? updateExternalTripState
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
        startCity: startCity ?? this.startCity,
        endCity: endCity ?? this.endCity,
        searchCity: searchCity ?? this.searchCity,
        movMapState: movMapState ?? this.movMapState,
        startPoint: startPoint ?? this.startPoint,
        endPoint: endPoint ?? this.endPoint,
        dateTrip: dateTrip ?? this.dateTrip,
        addExternalTripState: addExternalTripState ?? this.addExternalTripState,
        externalTrips: externalTrips ?? this.externalTrips,
        getExternalTripsState:
            getExternalTripsState ?? this.getExternalTripsState,
        endDateTrip: endDateTrip ?? this.endDateTrip,
        acceptExternalTrip: acceptExternalTrip ?? this.acceptExternalTrip,
           deleteExternalTripState: deleteExternalTripState ?? this.deleteExternalTripState,
              updateExternalTripState: updateExternalTripState ?? this.updateExternalTripState,

           
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
        acceptGroupState,
        startCity,
        endCity,
        searchCity,
        movMapState,
        endPoint,
        startPoint,
        dateTrip,
        addExternalTripState,
        externalTrips,
        getExternalTripsState,
        endDateTrip,
        acceptExternalTrip,
        deleteExternalTripState,
        updateExternalTripState
      ];
}
