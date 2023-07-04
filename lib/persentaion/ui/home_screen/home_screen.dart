import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:limousine_driver/core/helpers/functions.dart';

import 'package:limousine_driver/core/styles/colors.dart';
import 'package:limousine_driver/core/utlis/app_model.dart';
import 'package:limousine_driver/core/utlis/enums.dart';

import 'package:limousine_driver/core/widgets/loading_widget.dart';
import 'package:limousine_driver/persentaion/controller/trip_cubit/trip_cubit.dart';
import '../../../core/helpers/helper_functions.dart';
import '../../../core/utlis/strings.dart';

import 'components/app_bar_home.dart';

import 'components/details_user_widget.dart';
import 'components/drawer_widget.dart';
import 'components/item_current_trip.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  String index = Strings.showMap;
  late GoogleMapController mapController;

  final LatLng _center =
      LatLng(locData.latitude ?? 0.0, locData.longitude ?? 0.0);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(locData.latitude.toString() + "  userId");
    TripCubit.get(context)
        .updateDeviceToken(userId: currentUser.id, token: AppModel.deviceToken);
    TripCubit.get(context).homeTrip2(
        context: context,
        userId: currentUser.id!,
        lat: locData.latitude,
        lng: locData.longitude,
        address: "currentLocation");
    getFCMToken();
  }

  @override
  void dispose() {
    super.dispose();

    // mapController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TripCubit, TripState>(
      builder: (context, state) {
        return state.homeState == RequestState.loaded
            ? Scaffold(
                key: _scaffoldKey,
                drawer: DrawerWidget(
                  scaffoldKey: _scaffoldKey,
                  driver: state.responseHome!.driver,
                  activeDriver: state.responseHome!.trip == null ? false : true,
                ),
                appBar: PreferredSize(
                  preferredSize: Size.fromHeight(50.0),
                  child: AppBarHome(
                    title: Strings.main.tr(),
                    child: Container(
                      margin: EdgeInsets.all(12),
                      height: 16,
                      width: 26,
                      child: SvgPicture.asset(
                        "assets/icons/login.svg",
                        color: Colors.white,
                        height: 16,
                        width: 26,
                      ),
                    ),
                    onTap: () {
                      _scaffoldKey.currentState!.openDrawer();
                    },
                  ),
                ),
                body: Stack(children: [
                  GoogleMap(
                    zoomControlsEnabled: false,
                    onMapCreated: _onMapCreated,
                    initialCameraPosition: CameraPosition(
                      target: _center,
                      zoom: 14.0,
                    ),
                  ),
                  state.responseHome!.trip != null &&
                          state.responseHome!.trip!.status != 8
                      ? Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                              padding: EdgeInsets.all(24),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(15),
                                      topRight: Radius.circular(15))),
                              child: ItemCurrentTrip(state.responseHome!)),
                        )
                      : SizedBox(),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: EdgeInsets.only(top: 20, left: 24, right: 24),
                      child: DetailsUserWidget(
                        userDetail: currentUser,
                      ),
                    ),
                  )

                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     Texts(
                  //         title: Strings.currentOrders,
                  //         textColor: Color(0xff28436C),
                  //         fontSize: 23,
                  //         weight: FontWeight.normal,
                  //         align: TextAlign.center),
                  //     Container(
                  //       padding:
                  //           EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                  //       decoration: BoxDecoration(
                  //           color: buttonsColor,
                  //           borderRadius: BorderRadius.circular(35)),
                  //       child: Texts(
                  //           title: "33",
                  //           textColor: Colors.white,
                  //           fontSize: 14,
                  //           weight: FontWeight.normal,
                  //           align: TextAlign.center),
                  //     )
                  //   ],
                  // ),
                  // sizedHeight(18),
                  // // list Orders

                  // Row(
                  //   children: [
                  //     ContainerTabWidget(
                  //       onTap: () {
                  //         setState(() {
                  //           index = Strings.showMap;
                  //         });
                  //       },
                  //       index: index,
                  //       icon: "assets/icons/map.svg",
                  //       label: Strings.showMap,
                  //     ),
                  //     sizedWidth(20),
                  //     ContainerTabWidget(
                  //       onTap: () {
                  //         setState(() {
                  //           index = Strings.showList;
                  //         });
                  //       },
                  //       index: index,
                  //       icon: "assets/icons/list_menu.svg",
                  //       label: Strings.showList,
                  //     )
                  //   ],
                  // ),
                  // sizedHeight(11),
                  //List

                  // index == Strings.showList
                  //     ? ListCurrentOrders()
                  //     : SizedBox(
                  //         height: 300,0.....................
                  //         child: GoogleMap(
                  //           zoomControlsEnabled: false,
                  //           onMapCreated: _onMapCreated,
                  //           initialCameraPosition: CameraPosition(
                  //             target: _center,
                  //             zoom: 14.0,
                  //           ),
                  //         )),
                  // button refresh page
                  ,
                  Align(
                    alignment: Alignment.topCenter,
                    child: IconButton(
                      icon: Icon(
                        Icons.refresh,
                        color: homeColor,
                        size: 30,
                      ),
                      onPressed: () {
                        TripCubit.get(context).homeTrip2(
                            userId: currentUser.id!,
                            lat: locData.latitude,
                            lng: locData.longitude,
                            address: "currentLocation");
                      },
                    ),
                  )
                ]))
            : Scaffold(
                body: LoadingWidget(height: double.infinity, color: homeColor));
      },
    );
  }

  void getFCMToken() async {
    FirebaseMessaging.instance.getToken().then((token) {
      print(token.toString() + "tokrrrrrrn");
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;

      // NotifyAowsome(notification!.title!,notification.body!);
      if (notification != null && android != null && !kIsWeb) {
        print("senedddd ========> send");

        TripCubit.get(context).homeTrip2(
            userId: currentUser.id!,
            lat: locData.latitude,
            lng: locData.longitude,
            address: "currentLocation");

        showNotification(title: notification.title, body: notification.body);
        //  AwesomeNotifications().createNotification(
        //         content: NotificationContent(
        //       id: createUniqueId(),

        //       color: Colors.green,

        //       channelKey: 'limozin',
        //       title: notification.title,
        //       body: notification.body,

        //       notificationLayout: NotificationLayout.BigPicture,
        //       // largeIcon: "asset://assets/images/logo_final.png"
        //     ));
        // AwesomeNotifications().initialize(
        //     "asset://assets/images/logo_final",
        //     [
        //       NotificationChannel(
        //           channelKey: 'key1',
        //           channelName: 'chat',
        //           channelDescription: "Notification example",
        //           defaultColor: Colors.blue,
        //           ledColor: Colors.blue,
        //           channelShowBadge: true,
        //           playSound: true,
        //           enableLights:true,
        //           enableVibration: false
        //       )
        //     ]
        // );

/*        flutterLocalNotificationsPlugin!.show(
            notification.hashCode,
            "تم اضافة اعلان في الاعلانات المعلقة",
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel!.id,
                channel!.name,
                // channel!.description,

                // TODO add a proper drawable resource to android, for now using
                //      one that already exists in example app.
                icon: '@mipmap/ic_launcher',
              ),
            ));*/

        print("aaaaaaaaaaaawww${message.data["desc"]}");
      }
    });
  }
}

int createUniqueId() {
  return DateTime.now().millisecondsSinceEpoch.remainder(100000);
}

//  