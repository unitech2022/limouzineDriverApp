import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:limousine_driver/core/utlis/api_constatns.dart';
import 'package:limousine_driver/core/utlis/app_model.dart';
import 'package:limousine_driver/core/utlis/data.dart';

import 'package:limousine_driver/core/widgets/texts.dart';
import 'package:limousine_driver/domin/entities/driver.dart';
import 'package:limousine_driver/persentaion/controller/driver_cubit/driver_cubit.dart';

import '../../../../core/helpers/functions.dart';
import '../../../../core/helpers/helper_functions.dart';
import '../../../../core/styles/colors.dart';
import '../../../../core/utlis/enums.dart';
import '../../../../core/utlis/strings.dart';
import '../../../../core/widgets/app_bar_widget.dart';
import '../../../../core/widgets/button_widget.dart';
import '../../../../core/widgets/circle_image_widget.dart';

import '../../../../core/widgets/loading_widget.dart';
import 'car_details/components/drop_car_details_widget.dart';
import 'offical_screen/components/container_add_photo_widget.dart';

class CreateAccountDriverScreen extends StatefulWidget {
  @override
  State<CreateAccountDriverScreen> createState() =>
      _CreateAccountDriverScreenState();
}

class _CreateAccountDriverScreenState extends State<CreateAccountDriverScreen> {
  int currentIndex = 0;
  String? currentValue;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DriverCubit, DriverState>(
      builder: (context, state) {
        return Scaffold(
            appBar: PreferredSize(
                preferredSize: Size.fromHeight(50.0),
                child: AppBarWidget(
                  title: Strings.accountDriver.tr(),
                )),
            body: Padding(
              padding:
                  const EdgeInsets.only(left: 25.0, right: 25.0, top: 25.0),
              child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Texts(
                          title: Strings.accountDriver.tr(),
                          textColor: textColor,
                          fontSize: 30,
                          align: TextAlign.start,
                          weight: FontWeight.bold),
                      sizedHeight(15),
                      Texts(
                          title: Strings.complateData.tr(),
                          textColor: Color(0xffA5A5A5),
                          fontSize: 14,
                          align: TextAlign.start,
                          weight: FontWeight.bold),
                      sizedHeight(15),

                      // passportImage
                      ContainerAddPhotoWidget(
                        title: Strings.pasport.tr(),
                        image: "",
                        onTap: () {
                          DriverCubit.get(context).uploadImage(1);
                          print("ddff");
                        },
                        imageWidget:
                            state.passportImageState == RequestState.loading
                                ? SizedBox(
                                    width: 90,
                                    child: LoadingWidget(
                                      height: 90,
                                      color: buttonsColor,
                                    ),
                                  )
                                : Container(
                                    height: 90,
                                    width: 90,
                                    child: state.passportImage == ""
                                        ? SizedBox(
                                            child: Center(
                                                child: Icon(
                                              Icons.camera_alt_outlined,
                                              size: 30,
                                              color: Color.fromARGB(
                                                  255, 125, 124, 124),
                                            )),
                                          )
                                        : CircleImageWidget(
                                            height: 80,
                                            width: 80,
                                            image: ApiConstants.imageUrl(
                                                state.passportImage),
                                          ),
                                  ),
                      ),
                      //carImage
                      ContainerAddPhotoWidget(
                        title: Strings.photoCarDetails.tr(),
                        image: "",
                        onTap: () {
                          DriverCubit.get(context).uploadImage(2);
                          print("2");
                        },
                        imageWidget: state.carImageState == RequestState.loading
                            ? SizedBox(
                                width: 90,
                                child: LoadingWidget(
                                  height: 80,
                                  color: buttonsColor,
                                ),
                              )
                            : Container(
                                height: 90,
                                width: 90,
                                child: state.carImage == ""
                                    ? SizedBox(
                                        child: Center(
                                            child: Icon(
                                          Icons.camera_alt_outlined,
                                          size: 30,
                                          color: Color.fromARGB(
                                              255, 125, 124, 124),
                                        )),
                                      )
                                    : CircleImageWidget(
                                        height: 80,
                                        width: 80,
                                        image: ApiConstants.imageUrl(
                                            state.carImage!),
                                      ),
                              ),
                      ),
                      //drivingLicenseImage
                      ContainerAddPhotoWidget(
                          title: Strings.photoCar4.tr(),
                          image: "",
                          onTap: () {
                            DriverCubit.get(context).uploadImage(3);
                            print("3");
                          },
                          imageWidget: state.drivingLicenseImageState ==
                                  RequestState.loading
                              ? SizedBox(
                                  width: 90,
                                  child: LoadingWidget(
                                    height: 90,
                                    color: buttonsColor,
                                  ),
                                )
                              : Container(
                                  height: 90,
                                  width: 90,
                                  child: state.drivingLicenseImage == ""
                                      ? SizedBox(
                                          child: Center(
                                              child: Icon(
                                            Icons.camera_alt_outlined,
                                            size: 30,
                                            color: Color.fromARGB(
                                                255, 125, 124, 124),
                                          )),
                                        )
                                      : CircleImageWidget(
                                          height: 80,
                                          width: 80,
                                          image: ApiConstants.imageUrl(
                                              state.drivingLicenseImage!),
                                        ),
                                )),

                      sizedHeight(13),

                      DropCarDetailsWidget(
                        currentValue: DriverCubit.get(context).brandId,
                        title: Strings.brandCar.tr(),
                        onSelect: (v) {
                          DriverCubit.get(context).changeValue(v, 1);
                        },
                        list: carsBrands,
                      ),
                      DropCarDetailsWidget(
                        currentValue: DriverCubit.get(context).typeCar,
                        title: Strings.typeCar.tr(),
                        onSelect: (v) {
                          DriverCubit.get(context).changeValue(v, 2);
                        },
                        list: carTypes,
                      ),

                      DropCarDetailsWidget(
                        currentValue: DriverCubit.get(context).modelCar,
                        title: Strings.modelCar.tr(),
                        onSelect: (v) {
                          DriverCubit.get(context).changeValue(v, 3);
                        },
                        list: carModels,
                      ),

                      DropCarDetailsWidget(
                        currentValue: DriverCubit.get(context).madeYear,
                        title: Strings.madeCar.tr(),
                        onSelect: (v) {
                          DriverCubit.get(context).changeValue(v, 4);
                        },
                        list: carMade,
                      ),
                      sizedHeight(30),

                      state.addDriverState == RequestState.loading
                          ? LoadingWidget(
                              height: 55,
                              color: buttonsColor,
                            )
                          : ButtonWidget(
                              height: 55,
                              color: homeColor,
                              onPress: () {
                                if (isValidate(
                                    imagePass: state.passportImage,
                                    imageCar: state.carImage,
                                    imageDriving: state.drivingLicenseImage)) {
                                  print("heeeeeee");
                                  Driver driver = Driver(
                                      id: 1,
                                      userId: currentUser.id!,
                                      lat: 0.0,
                                      lng: 0.0,
                                      zoneId:
                                          DriverCubit.get(context).typeCar!.id,
                                      passport: state.passportImage!,
                                      drivingLicense:
                                          state.drivingLicenseImage!,
                                      carImage: state.carImage!,
                                      carModelId:
                                          DriverCubit.get(context).modelCar!.id,
                                      carMakeYear: DriverCubit.get(context)
                                          .modelCar!
                                          .title,
                                      status: 0,
                                      createdAt: "");

                                  DriverCubit.get(context)
                                      .addDriver(driver, context: context);
                                }
                              },
                              child: Texts(
                                  title: Strings.continueLogin.tr(),
                                  textColor: Colors.white,
                                  fontSize: 14,
                                  weight: FontWeight.normal,
                                  align: TextAlign.center)),

                      sizedHeight(20),

                      /*    SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Texts(
                    title: Strings.selectPhoto,
                    textColor: Color(0xff464646),
                    fontSize: 12,
                    align: TextAlign.center,
                    weight: FontWeight.bold),
                const Texts(
                    title: Strings.typeImage,
                    textColor: Color(0xff464646),
                    fontSize: 12,
                    align: TextAlign.center,
                    weight: FontWeight.bold),
                const Texts(
                    title: Strings.sizeImage,
                    textColor: Color(0xff464646),
                    fontSize: 12,
                    align: TextAlign.center,
                    weight: FontWeight.bold),
              ],
            ),
          ),*/
                      sizedHeight(15),
                      /*  FieldSignUpWidget(
                controller: _controller,
                label: Strings.firstName,
              ),
              FieldSignUpWidget(
                controller: _controller,
                label: Strings.secondName,
              ),
              FieldSignUpWidget(
                controller: _controller,
                label: Strings.lastName,
              ),
              FieldSignUpWidget(
                controller: _controller,
                label: Strings.email,
              ),
              FieldSignUpWidget(
                controller: _controller,
                label: Strings.password,
                pass: true,
              ),
              FieldSignUpWidget(
                controller: _controller,
                label: Strings.reapat,
                pass: true,
              ),*/
                    ]),
              ),
            ));
      },
    );
  }

  bool isValidate({imageCar, imagePass, imageDriving}) {
    if (imagePass == "") {
      showSnakeBar(message:"اختار صورة البطاقة", context: context);
      return false;
    } else if (imageCar == "") {
      showSnakeBar(message: "اختار صورة السيارة", context: context);
      return false;
    } else if (imageDriving == "") {
      showSnakeBar(message: "اختار صورة رخصة القيادة", context: context);
      return false;
    } else if (DriverCubit.get(context).brandId == null) {
      showSnakeBar(message: "brand", context: context);
      return false;
    } else if (DriverCubit.get(context).typeCar == null) {
      showSnakeBar(message: "type", context: context);
      return false;
    } else if (DriverCubit.get(context).modelCar == null) {
      showSnakeBar(message: "mad", context: context);
      return false;
    } else if (DriverCubit.get(context).madeYear == null) {
      showSnakeBar(message: "mad", context: context);
      return false;
    } else {
      return true;
    }
  }
}
