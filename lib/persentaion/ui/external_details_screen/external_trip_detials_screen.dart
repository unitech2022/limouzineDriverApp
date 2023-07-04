import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:limousine_driver/core/helpers/functions.dart';
import 'package:limousine_driver/core/styles/colors.dart';
import 'package:limousine_driver/core/utlis/enums.dart';
import 'package:limousine_driver/core/widgets/loading_widget.dart';
import 'package:limousine_driver/data/models/external_trip.dart';
import 'package:limousine_driver/data/models/external_trip_details.dart';
import 'package:limousine_driver/persentaion/controller/trip_cubit/trip_cubit.dart';
import 'package:limousine_driver/persentaion/ui/external_trip_screen/add_external_trip_screen.dart';
import 'package:limousine_driver/persentaion/ui/notifications_screen/notifications_screen.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/helpers/helper_functions.dart';

import '../../../core/utlis/app_model.dart';
import '../../../core/utlis/strings.dart';


import '../../../core/widgets/circle_image_widget.dart';
import '../../../data/models/city_model.dart';
import '../external_trip_screen/external_trip_screen.dart';

import '../home_screen/components/drawer_widget.dart';

class ExternalTripDetailsScreen extends StatefulWidget {
  final int groupId;
  const ExternalTripDetailsScreen({super.key, required this.groupId});

  @override
  State<ExternalTripDetailsScreen> createState() =>
      _ExternalTripDetailsScreenState();
}

class _ExternalTripDetailsScreenState extends State<ExternalTripDetailsScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    TripCubit.get(context).getExternalTripDetails(groupId: widget.groupId);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        key: _scaffoldKey,
        drawer: DrawerWidget(
          scaffoldKey: _scaffoldKey,
        ),
        appBar: AppBar(
          backgroundColor: Color(0xffEAEB15),
          title: Text(Strings.detailsTrip.tr(),
              style: TextStyle(color: Colors.black)),
          leading: IconButton(
              onPressed: () {
                pop(context);
              },
              icon: Icon(Icons.arrow_back, color: Colors.black)),
        ),
        body: BlocBuilder<TripCubit, TripState>(builder: (context, state) {
          return state.getGroupDetailsState == RequestState.loading
              ? Center(child: LoadingWidget(height: 55, color: homeColor))
              : Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    TabBar(
                      indicatorColor: Colors.black,
                      unselectedLabelColor: Color(0xff929191),
                      labelColor: Colors.black,
                      labelStyle:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      tabs: [
                        Tab(
                          text: Strings.detailsTrip.tr(),
                        ),
                        Tab(text: "الحجوزات".tr())
                      ],
                    ),
                    Expanded(
                        child: TabBarView(
                      children: [
                        DetailsTripWedgit(
                            externalTrip: state.groupDetails!.trip!),
                        ListBookingWidget(
                            bookings: state.groupDetails!.bookingsResponse!)
                      ],
                    ))
                  ],
                );
        }),
      ),
    );
  }
}

class ListBookingWidget extends StatefulWidget {
  final List<BookingsResponse> bookings;
   ListBookingWidget({
    super.key,
    required this.bookings,
  });

  @override
  State<ListBookingWidget> createState() => _ListBookingWidgetState();
}

class _ListBookingWidgetState extends State<ListBookingWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 30, left: 11, right: 11, bottom: 20),
      child: widget.bookings.isEmpty
          ? ListEmptyWidget(textColor: Colors.black, title: "لا توجد حجوزات".tr())
          : ListView.builder(
              itemCount: widget.bookings.length,
              itemBuilder: (ctx, index) {
                BookingsResponse bookingsResponse = widget.bookings[index];
                return Container(
                    padding: const EdgeInsets.all(11),
                    margin: EdgeInsets.only(bottom: 5),
                    decoration: BoxDecoration(
                      color: const Color(0xffffffff),
                      borderRadius: BorderRadius.circular(12.0),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x29000000),
                          offset: Offset(0, 3),
                          blurRadius: 6,
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "#${bookingsResponse.booking!.id!.toString()}",
                              style: TextStyle(
                                fontFamily: 'Segoe UI',
                                fontSize: 16,
                                color: Color(0xfffe7811),
                              ),
                              textAlign: TextAlign.start,
                            ),
                            GestureDetector(
                              onTap: () {
                                launchUrl(Uri.parse(
                                    "tel://${bookingsResponse.userDetail!.userName}"));
                              },
                              child: Container(
                                height: 35,
                                width: 35,
                                decoration: BoxDecoration(
                                    color: Colors.blue, shape: BoxShape.circle),
                                child: Center(
                                  child: Icon(
                                    Icons.call,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 60,
                              child: Text(
                                'الاسم'.tr(),
                                style: TextStyle(
                                  fontFamily: 'Segoe UI',
                                  fontSize: 13,
                                  color: const Color(0xff000000),
                                  fontWeight: FontWeight.w700,
                                ),
                                textAlign: TextAlign.start,
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              bookingsResponse.userDetail!.fullName!,
                              style: TextStyle(
                                fontFamily: 'Segoe UI',
                                fontSize: 13,
                                color: const Color(0xff7d756e),
                              ),
                              textAlign: TextAlign.start,
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(
                                
                                  child: Text(
                                    'رقم الهاتف'.tr(),
                                    style: TextStyle(
                                      fontFamily: 'Segoe UI',
                                      fontSize: 13,
                                      color: const Color(0xff000000),
                                      fontWeight: FontWeight.w700,
                                    ),
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  bookingsResponse.userDetail!.userName!,
                                  style: TextStyle(
                                    fontFamily: 'Segoe UI',
                                    fontSize: 13,
                                    color: const Color(0xff7d756e),
                                  ),
                                  textAlign: TextAlign.start,
                                )
                              ],
                            ),
                            BlocBuilder<TripCubit, TripState>(
                                builder: (context, state) {
                              return bookingsResponse.booking!.status == 0
                                  ? state.acceptExternalTrip ==
                                          RequestState.loading
                                      ? LoadingWidget(
                                          height: 26, color: homeColor)
                                      : Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                TripCubit.get(context)
                                                    .acceptExternalTrip(
                                                        bookingId:
                                                            bookingsResponse
                                                                .booking!.id,
                                                        tripId: bookingsResponse
                                                            .booking!
                                                            .externalTripId,
                                                        status: 1);
                                              },
                                              child: Container(
                                                height: 26,
                                               padding: EdgeInsets.symmetric(horizontal: 5),
                                                decoration: BoxDecoration(
                                                  color:
                                                      const Color(0xff0fd937),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          23.0),
                                                ),
                                                child: Center(
                                                    child: Text(
                                                  'قبول'.tr(),
                                                  style: TextStyle(
                                                    fontFamily: 'Segoe UI',
                                                    fontSize: 16,
                                                    color: Color.fromRGBO(
                                                        255, 255, 255, 1),
                                                  ),
                                                  textAlign: TextAlign.right,
                                                )),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                TripCubit.get(context)
                                                    .acceptExternalTrip(
                                                        bookingId:
                                                            bookingsResponse
                                                                .booking!.id,
                                                        tripId: bookingsResponse
                                                            .booking!
                                                            .externalTripId,
                                                        status: 2);
                                              },
                                              child: Container(
                                                height: 26,
                                                width: 58,
                                                decoration: BoxDecoration(
                                                  color:
                                                      const Color(0xffD90F0F),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          23.0),
                                                ),
                                                child: Center(
                                                    child: Text(
                                                  'رفض'.tr(),
                                                  style: TextStyle(
                                                    fontFamily: 'Segoe UI',
                                                    fontSize: 16,
                                                    color:
                                                        const Color(0xffffffff),
                                                  ),
                                                  textAlign: TextAlign.right,
                                                )),
                                              ),
                                            ),
                                          ],
                                        )
                                  : Container(
                                      height: 26,
                                          padding: EdgeInsets.symmetric(horizontal: 15),
                                      decoration: BoxDecoration(
                                        color:colors[bookingsResponse.booking!.status!] ,
                                        borderRadius:
                                            BorderRadius.circular(23.0),
                                      ),
                                      child: Center(
                                          child: Text(
                                        bookStatus[bookingsResponse.booking!.status!],
                                        style: TextStyle(
                                          fontFamily: 'Segoe UI',
                                          fontSize: 14,
                                          color: const Color(0xffffffff),
                                        ),
                                        textAlign: TextAlign.right,
                                      )),
                                    );
                            })
                          ],
                        ),
                      ],
                    ));
              }),
    );
  }

  List<Color> colors = [Colors.amber, Colors.green, Colors.red];

   List<String> bookStatus = ['في الانتظار'.tr(), 'مؤكد'.tr(),  'مرفوض'.tr()];
}

class DetailsTripWedgit extends StatelessWidget {
  final ExternalTrip externalTrip;
  const DetailsTripWedgit({
    super.key,
    required this.externalTrip,
  });

  @override
  Widget build(BuildContext context) {

    City startCity =cities.firstWhere((element) =>element.name==externalTrip.startCity );
                          City endCity =cities.firstWhere((element) =>element.name==externalTrip.endCity );
    return Container(
        margin: EdgeInsets.only(top: 30, left: 11, right: 11),
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xffffffff),
                  borderRadius: BorderRadius.circular(12.0),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0x29000000),
                      offset: Offset(0, 3),
                      blurRadius: 6,
                    ),
                  ],
                ),
                padding: EdgeInsets.all(11),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          externalTrip.name,
                          style: TextStyle(
                            fontFamily: 'Segoe UI',
                            fontSize: 20,
                            color: const Color(0xfffe7811),
                          ),
                          textAlign: TextAlign.right,
                        ),
                        Text(
                          '${externalTrip.price} ٍٍSR',
                          style: TextStyle(
                            fontFamily: 'Segoe UI',
                            fontSize: 16,
                            color: const Color(0xfff20000),
                          ),
                          textAlign: TextAlign.right,
                        )
                      ],
                    ),
                    RowDetailsTrip(
                        title: 'محطة الذهاب'.tr(),
                        value:AppModel.lang=="ar"?startCity.name!:startCity.name_eng! ,
                        child: SizedBox()
                        //  Text(
                        //   '${externalTrip.startingAt.split('T')[0]}  -  05:20',
                        //   style: TextStyle(
                        //     fontFamily: 'Segoe UI',
                        //     fontSize: 17,
                        //     color: const Color(0xff03de79),
                        //     fontWeight: FontWeight.normal,
                        //   ),
                        //   textAlign: TextAlign.right,
                        // ),
                        ),
                         SizedBox(height: 5,),
                    RowDetailsTrip(
                      title: "محطة الوصول".tr(),
                      value:AppModel.lang=="ar"?endCity.name!:endCity.name_eng!,
                      child: SizedBox(),
                    ),
                    SizedBox(height: 5,),

                    RowDetailsTrip(
                      title: "تاريخ الرحلة".tr(),
                      value: externalTrip.startingAt.split("T")[0]+ " -- " + externalTrip.startingAt.split("T")[1],
                      child: SizedBox(),
                    ),
                    SizedBox(height: 5,),

                    RowDetailsTrip(
                      title: "عدد الركاب".tr(),
                      value: externalTrip.sets.toString(),
                      child: SizedBox(),
                    ),
                  ],
                )),
          ),
          SizedBox(
            height: 50,
          ),

          // *** location trip
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xffffffff),
              borderRadius: BorderRadius.circular(12.0),
              boxShadow: [
                BoxShadow(
                  color: const Color(0x29000000),
                  offset: Offset(0, 3),
                  blurRadius: 6,
                ),
              ],
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      "الموقع".tr(),
                      style: TextStyle(
                        fontFamily: 'Segoe UI',
                        fontSize: 20,
                        color: const Color(0xfffe7811),
                      ),
                      textAlign: TextAlign.right,
                    )
                  ],
                ),
                SizedBox(
                  height: 27,
                ),
                Row(
                  children: [
                    Expanded(
                        child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          height: 91,
                          width: 91,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey, width: 1),
                              shape: BoxShape.circle),
                          child: CircleImageWidget(
                            height: 90,
                            width: 90,
                            icon: Icons.location_on_outlined,
                            image:
                                "https://maps.googleapis.com/maps/api/staticmap?zoom=18&size=600x300&maptype=roadmap&markers=${externalTrip.startPointLat},${externalTrip.startPointLng}&key=AIzaSyDFZhFfswZpcjeUDYm6C7H46JLdSonK0f4",
                          ),
                        ),
                        SizedBox(
                          height: 19,
                        ),
                        GestureDetector(
                          onTap: () {
                            openGoogleMapLocation(
                                lat: externalTrip.startPointLat,
                                lng: externalTrip.startPointLng);
                          },
                          child: Container(
                            height: 25,
                            width: 80,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: const Color(0xff1485f6),
                              borderRadius: BorderRadius.circular(23.0),
                            ),
                            child: Center(
                              child: Text(
                                "الذهاب".tr(),
                                style: TextStyle(
                                    fontFamily: 'Segoe UI',
                                    fontSize: 16,
                                    color: const Color(0xffffffff),
                                    height: 1.2),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )),
                    Expanded(
                        child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          height: 91,
                          width: 91,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey, width: 1),
                              shape: BoxShape.circle),
                          child: CircleImageWidget(
                            height: 90,
                            width: 90,
                            icon: Icons.location_on_outlined,
                            image:
                                "https://maps.googleapis.com/maps/api/staticmap?zoom=18&size=600x300&maptype=roadmap&markers=${externalTrip.endPointLat},${externalTrip.endPointLng}&key=AIzaSyDFZhFfswZpcjeUDYm6C7H46JLdSonK0f4",
                          ),
                        ),
                        SizedBox(
                          height: 19,
                        ),
                        GestureDetector(
                          onTap: () {
                            openGoogleMapLocation(
                                lat: externalTrip.endPointLat,
                                lng: externalTrip.endPointLng);
                          },
                          child: Container(
                            height: 25,
                            width: 80,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(23.0),
                            ),
                            child: Center(
                              child: Text(
                                "الوصول".tr(),
                                style: TextStyle(
                                    fontFamily: 'Segoe UI',
                                    fontSize: 16,
                                    color: const Color(0xffffffff),
                                    height: 1.2),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ))
                  ],
                )
              ],
            ),
          ),

          // ** operation trip
          SizedBox(
            height: 37,
          ),
          BlocBuilder<TripCubit, TripState>(builder: (context, state) {
            return Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      pushPage(
                          context: context,
                          page: AddExternalTripScreen(
                            type: 1,
                            externalTrip: externalTrip,
                          ));
                    },
                    child: Container(
                      height: 40,
                      decoration:
                          BoxDecoration(border: Border.all(color: Colors.blue)),
                      child: Center(
                        child: Text(
                          'تعديل'.tr(),
                          style: TextStyle(
                              fontFamily: 'Segoe UI',
                              fontSize: 16,
                              color: Colors.blue,
                              height: 1.2),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 30),
                Expanded(
                  child: state.deleteExternalTripState == RequestState.loading
                      ? LoadingWidget(height: 40, color: homeColor)
                      : GestureDetector(
                          onTap: () {
                            TripCubit.get(context).deleteExternalTrip(
                                tripId: externalTrip.id, context: context);
                          },
                          child: Container(
                            height: 40,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.red)),
                            child: Center(
                              child: Text(
                                'حذف'.tr(),
                                style: TextStyle(
                                    fontFamily: 'Segoe UI',
                                    fontSize: 16,
                                    color: Colors.red,
                                    height: 1.2),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                )
              ],
            );
          })
        ]));
  }
}
