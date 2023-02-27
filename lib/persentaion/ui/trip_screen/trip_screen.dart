import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:limousine_driver/core/widgets/circle_image_widget.dart';

import '../../../core/helpers/helper_functions.dart';
import '../../../core/styles/colors.dart';
import '../../../core/thems/them.dart';
import '../../../core/utlis/strings.dart';
import '../../../core/widgets/button_widget.dart';
import '../../../core/widgets/container.divider.dart';
import '../../../core/widgets/texts.dart';
import '../history_screen/history_screen.dart';
import '../home_screen/components/drawer_widget.dart';

class TripScreen extends StatefulWidget {
  @override
  State<TripScreen> createState() => _TripScreenState();
}

class _TripScreenState extends State<TripScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  late GoogleMapController mapController;

  final LatLng _center = const LatLng(45.521563, -122.677433);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    mapController.setMapStyle(styleMap);
    mapController = controller;
  }

  @override
  void dispose() {
    super.dispose();
    mapController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        GoogleMap(
          zoomControlsEnabled: false,
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: _center,
            zoom: 14.0,
          ),
        ),

        // container select addresses trip

        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 28),
            width: double.infinity,
            height: 360,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25), topRight: Radius.circular(25)),
            ),
            child: Column(children: [
              sizedHeight(13),
              const ContainerDivider(
                color: Color(0xffBEBEBE),
                height: 3,
                width: 120,
              ),
              sizedHeight(15),
              Row(
                children: [
                  CircleImageWidget(
                      height: 45, width: 45, image: "assets/images/person.png"),
                  sizedWidth(18),
                  Expanded(
                      child: const Texts(
                          title: "يعقوب قمر الدين دبيازه",
                          textColor: Colors.black,
                          fontSize: 13,
                          weight: FontWeight.bold,
                          align: TextAlign.start))
                ],
              ),
              sizedHeight(15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RowDetailsTripWidget(
                    value2: "ر.س كاش",
                    value: "290",
                    icon: "assets/icons/wallet.svg",
                    title: Strings.cost,
                  ),
                  RowDetailsTripWidget(
                    value2: "12  كم",
                    value: "12 ",
                    icon: "assets/icons/far.svg",
                    title: Strings.nearYou,
                  ),
                  RowDetailsTripWidget(
                    value2: "12  كم",
                    value: "290",
                    icon: "assets/icons/history_home.svg",
                    title: Strings.timeTrip,
                  ),
                ],
              ),
              sizedHeight(8),
              Divider(height: .9),
              sizedHeight(13),
              ContainerStartingPointWidget(
                value:
                    "Al Wurud، Engineer Al Anjari Street, Riyadh Saudi Arabia",
                label: Strings.startPoint,
                color: buttonsColor,
              ),
              sizedHeight(20),
              ContainerStartingPointWidget(
                value:
                    "Al Wurud، Engineer Al Anjari Street, Riyadh Saudi Arabia",
                label: Strings.endPoint,
                color: Color(0xff88D55F),
              ),
              const Spacer()
              // button search
              ,
              ButtonWidget(
                  height: 55,
                  color: homeColor,
                  onPress: () {},
                  child: const Texts(
                      title: Strings.searchAboutTrip,
                      textColor: Colors.white,
                      fontSize: 14,
                      weight: FontWeight.normal,
                      align: TextAlign.center)),
            ]),
          ),
        )
      ],
    ));
  }
}

class RowDetailsTripWidget extends StatelessWidget {
  final String icon, title, value, value2;

  RowDetailsTripWidget(
      {required this.icon,
      required this.title,
      required this.value,
      required this.value2});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SvgPicture.asset(icon),
        sizedHeight(5),
        Texts(
            title: Strings.cost,
            textColor: Colors.black,
            fontSize: 10,
            family: "alex_bold",
            weight: FontWeight.bold,
            align: TextAlign.start),
        sizedHeight(5),
        Texts(
            title: value,
            textColor: buttonsColor,
            fontSize: 20,
            family: "alex_bold",
            weight: FontWeight.bold,
            align: TextAlign.start),
        Texts(
            title: value2,
            textColor: Color(0xff7C7C7C),
            fontSize: 8,
            weight: FontWeight.normal,
            align: TextAlign.start),
      ],
    );
  }
}
