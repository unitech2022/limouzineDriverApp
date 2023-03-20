part of 'driver_cubit.dart';

class DriverState extends Equatable {
  final RequestState? passportImageState;
  final bool? changeValue;
  final RequestState? carImageState;
  final RequestState? drivingLicenseImageState;
  final String? passportImage;
  final String? carImage;
  final String? drivingLicenseImage;
  final RequestState? addDriverState;
  final String? addDriverMessage;
  final Driver? driver;

//get driver
  final RequestState? updateDriverState;
  final Driver? updateResponse;
   final RequestState? getDriverState;

  DriverState(
      {this.addDriverState,
      this.addDriverMessage = "",
      this.driver,
      this.carImage = "",
      this.drivingLicenseImage = "",
      this.passportImage = "",
      this.passportImageState,
      this.carImageState,
      this.changeValue,
      this.drivingLicenseImageState,
      this.updateDriverState,
      this.updateResponse,
      this.getDriverState
      });

  DriverState copyWith(
          {final RequestState? addDriverState,
          final String? addDriverMessage,
          final Driver? driver,
          final bool? changeValue,
          final RequestState? passportImageState,
          final RequestState? carImageState,
          final RequestState? drivingLicenseImageState,
          final String? passportImage,
          final String? carImage,
          final String? drivingLicenseImage,
            final RequestState? updateDriverState,
  final Driver? updateResponse,
    final RequestState? getDriverState
          
          }) =>
      DriverState(
          driver: driver ?? this.driver,
          changeValue: changeValue ?? this.changeValue,
          addDriverState: addDriverState ?? this.addDriverState,
          addDriverMessage: addDriverMessage ?? this.addDriverMessage,
          passportImageState: passportImageState ?? this.passportImageState,
          carImageState: carImageState ?? this.carImageState,
          drivingLicenseImageState:
              drivingLicenseImageState ?? this.drivingLicenseImageState,
          passportImage: passportImage ?? this.passportImage,
          carImage: carImage ?? this.carImage,
          drivingLicenseImage: drivingLicenseImage ?? this.drivingLicenseImage,
          
           updateDriverState: updateDriverState ?? this.updateDriverState,
          updateResponse: updateResponse ?? this.updateResponse,
           getDriverState: getDriverState ?? this.getDriverState,
          
          );

  @override
  List<Object?> get props => [
        passportImageState,
        carImageState,
        drivingLicenseImageState,
        passportImage,
        carImage,
        drivingLicenseImage,
        addDriverState,
        addDriverMessage,
        driver,
        changeValue,
        updateDriverState,
        updateResponse,getDriverState
      ];
}
