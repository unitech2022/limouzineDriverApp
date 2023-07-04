import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:limousine_driver/core/utlis/api_constatns.dart';
import 'package:limousine_driver/core/utlis/enums.dart';
import 'package:limousine_driver/core/widgets/loading_widget.dart';
import 'package:limousine_driver/data/models/rsponse_home.dart';
import 'package:limousine_driver/persentaion/controller/trip_cubit/trip_cubit.dart';
import '../../../../core/helpers/helper_functions.dart';
import '../../../../core/styles/colors.dart';
import '../../../../core/utlis/strings.dart';
import '../../../../core/widgets/buttons.dart';
import '../../../../core/widgets/circle_image_widget.dart';
import '../../../../core/widgets/texts.dart';

import 'container_point_widget.dart';


class ItemCurrentTrip extends StatelessWidget {
 final ResponseHome responseHome;

  ItemCurrentTrip(this.responseHome);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TripCubit, TripState>(
      builder: (context, state) {
        return Container(
          padding: EdgeInsets.all(15),
          margin: EdgeInsets.only(bottom: 30),
          height: 335,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8), color: Color(0xffF7F7F7)),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleImageWidget(
                      height: 50,
                      width: 50,
                      image: ApiConstants.imageUrl(
                          responseHome.userDetail!.profileImage!)),
                  sizedWidth(18),
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Texts(
                            title: responseHome.userDetail!.fullName!,
                            textColor: Colors.black,
                            fontSize: 13,
                            weight: FontWeight.bold,
                            align: TextAlign.center),
                        sizedHeight(6),
                        // ContainerDetailsTrip(
                        //   icon: "assets/icons/wallet.svg",
                        //   label: Strings.cost,
                        //   textColor: buttonsColor,
                        //   value1: "290",
                        //   value2: "ر.س",
                        //   value3: "كاش",
                        // ),
                        // ContainerDetailsTrip(
                        //   icon: "assets/icons/far.svg",
                        //   label: Strings.nearYou,
                        //   textColor: Colors.black,
                        //   value1: "12",
                        //   value2: "دقيقة",
                        //   value3: "12  كم",
                        // ),
                        // ContainerDetailsTrip(
                        //   icon: "assets/icons/history_home.svg",
                        //   label: Strings.timeTrip,
                        //   textColor: Colors.black,
                        //   value1: "45",
                        //   value2: "دقيقة",
                        //   value3: "12  كم",
                        // )
                      ],
                    ),
                  ))
                ],
              )
              //
              ,
              sizedHeight(20),
              ContainerPointWidget(
                color: buttonsColor,
                width: 14,
                label: Strings.startPoint.tr(),
                value: responseHome.trip!.startAddress,
              ),
              sizedHeight(22),
              ContainerPointWidget(
                color: Color(0xff88D55F),
                label: Strings.endPoint.tr(),
                  width: 14,
                value: responseHome.trip!.endAddress,
              ),
              sizedHeight(20),
              Spacer(),
              state.changeStatusTrip == RequestState.loading
                  ? LoadingWidget(height: 55, color: homeColor)
                  : getTripStatus(
                    status: responseHome.trip!.status,context: context
                  ),  sizedHeight(20)
            ],
          ),
        );
      },
    );
  }

  Widget getTripStatus({status, context}) {
    if (status == 0) {
      return Row(
        children: [
          Expanded(
              child: MaterialButton(
            color: homeColor,
            child: Texts(
                title: Strings.accept.tr(),
                textColor: Colors.white,
                fontSize: 14,
                weight: FontWeight.normal,
                align: TextAlign.center),
            height: 42,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            onPressed: () {
              TripCubit.get(context)
                  .changeStatusTrip(tripId: responseHome.trip!.id, status: 1,userId:responseHome.trip!.userId );
            },
          )),
          sizedWidth(14),
          Expanded(
              child: Buttons2(
            onPress: () {
               TripCubit.get(context)
                  .changeStatusTrip(tripId: responseHome.trip!.id, status: 8,userId:responseHome.trip!.userId );
            },
            radus: 30,
            height: 42,
            color: Color(0xffA5A5A5),
            child: Texts(
                title: Strings.cancel.tr(),
                textColor: Colors.white,
                fontSize: 14,
                weight: FontWeight.normal,
                align: TextAlign.center),
          )),
        ],
      );
    } else if(status == 1){

   return 
      SizedBox(
         width: double.infinity,
        child: Texts(
            title: "في انتظار اختيار طريقة الدفع".tr(),
            textColor:homeColor,
            fontSize: 14,
            weight: FontWeight.bold,
            align: TextAlign.center),
      );
    }
     else if (status == 2) {
      return SizedBox(
        width: double.infinity,
        child: MaterialButton(
          color: homeColor,
          child: Texts(
              title: "وصلت".tr(),
              textColor: Colors.white,
              fontSize: 14,
              weight: FontWeight.normal,
              align: TextAlign.center),
          height: 42,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          onPressed: () {
            TripCubit.get(context)
                .changeStatusTrip(tripId: responseHome.trip!.id, status: 3,userId:responseHome.trip!.userId );
          },
        ),
      );
    } else if (status == 3) {
      return SizedBox(
         width: double.infinity,
        child: Texts(
            title: "في انتظار ركوب العميل".tr(),
            textColor:homeColor,
            fontSize: 14,
            weight: FontWeight.bold,
            align: TextAlign.center),
      );
    } else if (status == 4) {
      return SizedBox(
         width: double.infinity,
        child: MaterialButton(
          color: homeColor,
          child: Texts(
              title: "تم الوصول للوجهة".tr(),
              textColor: Colors.white,
              fontSize: 14,
              weight: FontWeight.normal,
              align: TextAlign.center),
          height: 42,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          onPressed: () {
            TripCubit.get(context)
                .changeStatusTrip(tripId: responseHome.trip!.id, status: 5,userId:responseHome.trip!.userId );
          },
        ),
      );
    } else if (status == 5) {
      return SizedBox(
         width: double.infinity,
        child: MaterialButton(
          color: homeColor,
          child: Texts(
              title: "التـأكيد من السائق".tr(),
              textColor: Colors.white,
              fontSize: 14,
              weight: FontWeight.normal,
              align: TextAlign.center),
          height: 42,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          onPressed: () {
            TripCubit.get(context)
                .changeStatusTrip(tripId: responseHome.trip!.id, status: 6,userId:responseHome.trip!.userId );
          },
        ),
      );
    } else if (status == 6) {
      return SizedBox(
         width: double.infinity,
        child: Texts(
            title: "في انتظار التأكيد من العميل".tr(),
            textColor:homeColor,
            fontSize: 14,
            weight: FontWeight.bold,
            align: TextAlign.center),
      );
    } else {
      return Texts(
          title: "تمت العملية".tr(),
          textColor: textColor,
          fontSize: 16,
          weight: FontWeight.bold,
          align: TextAlign.center);
    }
  }
}
