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

  DriverState(
      {this.addDriverState,
      this.addDriverMessage = "",
      this.driver,
      this.carImage = "",
      this.drivingLicenseImage = "",
      this.passportImage = "",
       this.passportImageState,
       this.carImageState,
        this.changeValue ,
       this.drivingLicenseImageState});

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
          final String? drivingLicenseImage}) =>
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
          drivingLicenseImage: drivingLicenseImage ?? this.drivingLicenseImage);

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
    changeValue
      ];
}
