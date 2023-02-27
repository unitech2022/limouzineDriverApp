import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';
import 'package:limousine_driver/core/helpers/helper_functions.dart';
import 'package:limousine_driver/core/styles/colors.dart';

import '../../../core/utlis/strings.dart';
import '../../../core/widgets/texts.dart';
import '../home_screen/components/app_bar_home.dart';
import '../home_screen/components/container_details_trip.dart';
import '../home_screen/components/container_point_widget.dart';
import '../home_screen/components/drawer_widget.dart';

class HistoryScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int index = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: DrawerWidget(
        scaffoldKey: _scaffoldKey,
      ),
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(50.0),
          child: AppBarHome(
            title: Strings.history,
            onTap: () {
              _scaffoldKey.currentState!.openEndDrawer();
            },
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
          )),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 27),
        child: Column(children: [
          // tabs
          Container(
            height: 56,
            decoration: BoxDecoration(
              color:  Color(0xffF7F7F7),
                border: Border.all(
                  width: 1,
                  color: Color(0xffF7F7F7),
                ),
                borderRadius: BorderRadius.circular(25)),
            child: Row(
              children: [
                TabHistoryWidget(
                  title: Strings.coming,
                  textColor1: index == 0 ? Colors.white : homeColor,
                  containerColor: index == 0 ? homeColor : Colors.transparent,
                  onTap: () {},
                ),
                TabHistoryWidget(
                  title: Strings.done,
                  textColor1: index == 1 ? Colors.white : homeColor,
                  containerColor: index == 1 ? homeColor : Colors.transparent,
                  onTap: () {},
                ),
                TabHistoryWidget(
                  title: Strings.canceled,
                  textColor1: index == 2 ? Colors.white : homeColor,
                  containerColor: index == 2 ? homeColor : Colors.transparent,
                  onTap: () {},
                ),
              ],
            ),
          ),
          sizedHeight(18)
          // list Of history
          ,
          Expanded(
            child: ListView.builder(
                itemCount: 3,
                itemBuilder: (context, index) {
                  return ItemListHistory();
                }),
          )
        ]),
      ),
    );
  }
}

class ItemListHistory extends StatelessWidget {
  const ItemListHistory({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
     
      padding: EdgeInsets.all(14),
      margin: EdgeInsets.only(bottom: 13),
      decoration: BoxDecoration(
          color: Color(0xffFFF9EC),
          borderRadius: BorderRadius.circular(8)),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SvgPicture.asset("assets/icons/airport.svg"),
                sizedWidth(13),
                Expanded(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                        crossAxisAlignment:
                            CrossAxisAlignment.center,
                        children: [
                          Texts(
                              title: "طلب رقم : 95312245",
                              textColor: Color(0xffA5A5A5),
                              fontSize: 12,
                              weight: FontWeight.bold,
                              align: TextAlign.start),
                          Texts(
                              title: "07-02-2023",
                              textColor: Colors.black,
                              fontSize: 12,
                              weight: FontWeight.bold,
                              align: TextAlign.start)
                        ],
                      ),
                      sizedHeight(3),
                      Divider(
                        height: .8,
                      ),
                      ContainerDetailsTrip(
                        icon: "assets/icons/wallet.svg",
                        label: Strings.cost,
                        textColor: Colors.black,
                        value1: "290",
                        value2: "ر.س",
                        value3: "كاش",
                      ),
                      ContainerDetailsTrip(
                        icon: "assets/icons/history_home.svg",
                        label: Strings.timeTrip,
                        textColor: Colors.black,
                        value1: "45",
                        value2: "دقيقة",
                        value3: "12  كم",
                      ),
                      sizedHeight(12),
                      ContainerStartingPointWidget(value:  "Al Wurud، Engineer Al Anjari Street, Riyadh Saudi Arabia",
                      label: Strings.startPoint,color:buttonsColor,),
                      sizedHeight(15),
                      ContainerStartingPointWidget(value:  "Al Wurud، Engineer Al Anjari Street, Riyadh Saudi Arabia",
                      label: Strings.endPoint,color:Color(0xff88D55F),),
                   
                    
                    ],
                  ),
                ),
              ],
            ),
          ]),
    );
  }
}

class ContainerStartingPointWidget extends StatelessWidget {
  final String label, value;
  final Color color;

  ContainerStartingPointWidget(
      {required this.label, required this.color, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 12,
          width: 12,
          decoration:
              BoxDecoration(shape: BoxShape.circle, color: color),
        ),
        sizedWidth(10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Texts(
                  title: label,
                  textColor: Colors.black,
                  fontSize: 10,
                  weight: FontWeight.w800,
                  align: TextAlign.start),
              Texts(
                  title:
                     value,
                  textColor: Color(0xffA5A5A5),
                  fontSize: 10,
                  weight: FontWeight.normal,
                  align: TextAlign.start),
            ],
          ),
        ),
      ],
    );
  }
}

class TabHistoryWidget extends StatelessWidget {
  final Color textColor1;
  final Color containerColor;
  final String title;
  final void Function() onTap;

  TabHistoryWidget(
      {required this.textColor1,
      required this.containerColor,
      required this.onTap,
      required this.title});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: containerColor,
            borderRadius: BorderRadius.circular(25),
          ),
          child: Center(
            child: Texts(
                title: title,
                textColor: textColor1,
                fontSize: 18,
                weight: FontWeight.normal,
                align: TextAlign.center),
          ),
        ),
      ),
    );
  }
}
