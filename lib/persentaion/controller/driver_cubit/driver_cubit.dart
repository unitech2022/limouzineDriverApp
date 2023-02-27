
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:limousine_driver/core/utlis/data.dart';
import 'package:limousine_driver/domin/entities/driver.dart';
import 'package:limousine_driver/domin/usese_cases/driver_uses_cases/add_driver_use_case.dart';


import '../../../core/helpers/functions.dart';
import '../../../core/utlis/enums.dart';
import '../../../domin/usese_cases/app_use_case/app_use_case.dart';
import '../../ui/sign_up_screen/steps_sign_screens/done_screen/done_screen.dart';

part 'driver_state.dart';

class DriverCubit extends Cubit<DriverState> {
  AddDriverUseCase addDriverUseCase;
  AppUseCase appUseCase;
  DriverCubit(this.addDriverUseCase,this.appUseCase) : super(DriverState());

  static DriverCubit get(context) => BlocProvider.of<DriverCubit>(context);

  CarBrand? brandId , typeCar, modelCar,madeYear;
  addDriver(Driver driver, {context}) async {
    emit(state.copyWith(addDriverState: RequestState.loading));
    final result = await addDriverUseCase.execute(driver);
    result.fold(
        (l) => emit(DriverState(
            addDriverState: RequestState.error,
            addDriverMessage: l.message)), (r) {
      print(r);

      pushPage(context: context, page: DoneScreen());

      emit(DriverState(driver: r, addDriverState: RequestState.loaded));
    });
  }

  uploadImage(typeImage) async {
    File _image;
    final picker = ImagePicker();

    var _pickedFile = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 50, // <- Reduce Image quality
        maxHeight: 500, // <- reduce the image size
        maxWidth: 500);

    if (_pickedFile != null) {
      _image = File(_pickedFile.path);
      ;

      if (typeImage == 1) {
        emit(state.copyWith(passportImageState: RequestState.loading));
      } else if (typeImage == 2) {
        emit(state.copyWith(carImageState: RequestState.loading));
      } else {
        emit(state.copyWith(drivingLicenseImageState: RequestState.loading));
      }
      final result = await appUseCase.execute(file: _image);
      result.fold((l) {
        if (typeImage == 1) {
          emit(state.copyWith(passportImageState: RequestState.error));
        } else if (typeImage == 2) {
          emit(state.copyWith(carImageState: RequestState.error));
        } else {
          emit(state.copyWith(drivingLicenseImageState: RequestState.error));
        }
      }, (r) {
        print(r);
        if (typeImage == 1) {
          emit(state.copyWith(passportImage: r,passportImageState: RequestState.loaded));
        } else if (typeImage == 2) {
          emit(state.copyWith(carImage: r,carImageState:RequestState.loaded ));
        } else {
          emit(state.copyWith(drivingLicenseImage: r,drivingLicenseImageState: RequestState.loaded));
        }
      });
    }
  }

  changeValue(CarBrand newValue, int type) {

    if (type == 1) {
      brandId = newValue;
      emit(state.copyWith(changeValue: true));
    } else if (type == 2) {
      typeCar = newValue;
      emit(state.copyWith(changeValue: true));
    } else if (type == 3) {
      modelCar = newValue;
      emit(state.copyWith(changeValue: true));
    } else {
      madeYear = newValue;
      emit(state.copyWith(changeValue: true));
    }
  }
}
