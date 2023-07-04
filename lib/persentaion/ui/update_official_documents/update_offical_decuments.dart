import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:limousine_driver/core/helpers/helper_functions.dart';
import 'package:limousine_driver/core/styles/colors.dart';
import 'package:limousine_driver/core/utlis/app_model.dart';
import 'package:limousine_driver/core/utlis/enums.dart';
import 'package:limousine_driver/core/widgets/loading_widget.dart';
import 'package:limousine_driver/persentaion/controller/driver_cubit/driver_cubit.dart';

import '../../../core/utlis/api_constatns.dart';
import '../../../core/utlis/strings.dart';
import '../../../core/widgets/button_widget.dart';
import '../../../core/widgets/circle_image_widget.dart';
import '../../../core/widgets/texts.dart';

import '../sign_up_screen/steps_sign_screens/offical_screen/components/container_add_photo_widget.dart';

class UpdateOfficialDocuments extends StatefulWidget {
  const UpdateOfficialDocuments({super.key});

  @override
  State<UpdateOfficialDocuments> createState() =>
      _UpdateOfficialDocumentsState();
}

class _UpdateOfficialDocumentsState extends State<UpdateOfficialDocuments> {
  @override
  void initState() {
    super.initState();
    DriverCubit.get(context).getDriverById(driverId: driver!.id);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DriverCubit, DriverState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Texts(title:  Strings.updateOffical.tr(), align: TextAlign.center,fontSize: 16, textColor: Colors.white, weight: FontWeight.normal,)),
          body: state.getDriverState == RequestState.loading
              ? Center(
                  child: LoadingWidget(height: 55, color: homeColor),
                )
              : SingleChildScrollView(
                child: Container(
                    margin: EdgeInsets.all(20),
                    child: Column(
                      children: [
                        sizedHeight(20),
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
                                          ? Image.asset(
                                              "assets/images/image_person.png")
                                          : CircleImageWidget(
                                              height: 80,
                                              width: 80,
                                              image: ApiConstants.imageUrl(
                                                  state.passportImage),
                                            ),
                                    ),
                        ),
                        Divider(),
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
                                      ? Image.asset(
                                          "assets/images/image_person.png")
                                      : CircleImageWidget(
                                          height: 80,
                                          width: 80,
                                          image: ApiConstants.imageUrl(
                                              state.carImage!),
                                        ),
                                ),
                        ),
                        Divider(),
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
                                        ? Image.asset(
                                            "assets/images/image_person.png")
                                        : CircleImageWidget(
                                            height: 80,
                                            width: 80,
                                            image: ApiConstants.imageUrl(
                                                state.drivingLicenseImage!),
                                          ),
                                  )),
              
                        sizedHeight(60),
              
                        state.updateDriverState == RequestState.loading
                            ? LoadingWidget(
                                height: 55,
                                color: buttonsColor,
                              )
                            : ButtonWidget(
                                height: 55,
                                color: homeColor,
                                onPress: () {
                                  DriverCubit.get(context).updateDriver(
                                      imageCar: state.carImage,
                                      imagePass: state.passportImage,
                                      imageDriving: state.drivingLicenseImage,
                                      driverId: driver!.id);    
                                },
                                child: Texts(
                                    title: Strings.save.tr(),
                                    textColor: Colors.white,
                                    fontSize: 14,
                                    weight: FontWeight.normal,
                                    align: TextAlign.center)),
              
                        sizedHeight(20),
                      ],
                    ),
                  ),
              ),
        );
      },
    );
  }
}
