import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:limousine_driver/core/routers/routers.dart';
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
import '../home_screen.dart';
import 'container_details_trip.dart';
import 'container_point_widget.dart';

// class ListCurrentOrders extends StatelessWidget {
//   const ListCurrentOrders({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//         itemCount: 3,
//         padding: EdgeInsets.symmetric(vertical: 10),
//         shrinkWrap: true,
//         physics: NeverScrollableScrollPhysics(),
//         itemBuilder: (context, index) {
//           return Container();
//         });
//   }
// }

class ItemCurrentTrip extends StatelessWidget {
  ResponseHome responseHome;

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
                label: Strings.startPoint,
                value: responseHome.trip!.startAddress,
              ),
              sizedHeight(22),
              ContainerPointWidget(
                color: Color(0xff88D55F),
                label: Strings.endPoint,
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
                title: Strings.accept,
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
                  .changeStatusTrip(tripId: responseHome.trip!.id, status: 1);
            },
          )),
          sizedWidth(14),
          Expanded(
              child: Buttons2(
            onPress: () {
               TripCubit.get(context)
                  .changeStatusTrip(tripId: responseHome.trip!.id, status: 7);
            },
            radus: 30,
            height: 42,
            color: Color(0xffA5A5A5),
            child: Texts(
                title: Strings.cancel,
                textColor: Colors.white,
                fontSize: 14,
                weight: FontWeight.normal,
                align: TextAlign.center),
          )),
        ],
      );
    } else if (status == 1) {
      return SizedBox(
        width: double.infinity,
        child: MaterialButton(
          
          color: homeColor,
          child: Texts(
              title: "وصلت ",
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
                .changeStatusTrip(tripId: responseHome.trip!.id, status: 2);
          },
        ),
      );
    } else if (status == 2) {
      return SizedBox(
         width: double.infinity,
        child: MaterialButton(
          color: homeColor,
          child: Texts(
              title: "تم الركوب ",
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
                .changeStatusTrip(tripId: responseHome.trip!.id, status: 3);
          },
        ),
      );
    } else if (status == 3) {
      return SizedBox(
         width: double.infinity,
        child: MaterialButton(
          color: homeColor,
          child: Texts(
              title: "تم الوصول للوجهة ",
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
                .changeStatusTrip(tripId: responseHome.trip!.id, status: 4);
          },
        ),
      );
    } else if (status == 4) {
      return SizedBox(
         width: double.infinity,
        child: MaterialButton(
          color: homeColor,
          child: Texts(
              title: "تم التـأكيد من السائق ",
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
                .changeStatusTrip(tripId: responseHome.trip!.id, status: 5);
          },
        ),
      );
    } else if (status == 5) {
      return SizedBox(
         width: double.infinity,
        child: MaterialButton(
          color: homeColor,
          child: Texts(
              title: "تم التأكيد من العميل ",
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
                .changeStatusTrip(tripId: responseHome.trip!.id, status: 6);
          },
        ),
      );
    } else {
      return Texts(
          title: "تمت العملية",
          textColor: textColor,
          fontSize: 16,
          weight: FontWeight.bold,
          align: TextAlign.center);
    }
  }
}
