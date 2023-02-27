
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';
import 'package:limousine_driver/core/helpers/helper_functions.dart';
import 'package:limousine_driver/core/utlis/data.dart';

import '../../../core/utlis/strings.dart';
import '../../../core/widgets/texts.dart';
import '../home_screen/components/app_bar_home.dart';
import '../home_screen/components/drawer_widget.dart';

class BadgesScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

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
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        child: SingleChildScrollView(
            child: Column(
          children: [
            Container(
              height: 55,
              padding: EdgeInsets.symmetric(horizontal: 17),
              decoration: BoxDecoration(
                  color: Color(0xffF7F7F7),
                  borderRadius: BorderRadius.circular(10)),
              child: Center(
                child: Row(
                  children: [
                    const Texts(
                        title: Strings.yourBadges,
                        textColor: Color(0xff0B1B2F),
                        fontSize: 16,
                        weight: FontWeight.normal,
                        align: TextAlign.start),
                  ],
                ),
              ),
            ),
            sizedHeight(17),
            Wrap(
              alignment: WrapAlignment.center,
              direction: Axis.horizontal,
              children: badges
                  .map((e) => Container(
                   margin: EdgeInsets.only(left: 10,bottom: 54),
                  
                     width: widthScreen(context) / 3.85,
                        child: Column(children: [
                          Container(
                            height: 114,
                            padding: EdgeInsets.all(5),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Color(0xffFFF3F6),
                              border: Border.all(color:Color(0xffF2154F),width: 3)),
                              child: Image.asset(e.icon),
                              
                           
                          )
                        , sizedHeight(11),
                        Text(e.title,style: TextStyle(
                          color: Colors.black,fontSize: 11,height: 1.2,fontWeight: FontWeight.bold
                        ),)
                     
                        ]),
                      ))
                  .toList(),
            ),
          ],
        )),
      ),
    );
  }
}
