import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';
import 'package:limousine_driver/core/helpers/helper_functions.dart';
import 'package:limousine_driver/core/utlis/strings.dart';

import '../../../core/widgets/texts.dart';
import '../home_screen/components/app_bar_home.dart';
import '../home_screen/components/drawer_widget.dart';

class NotificationsScreen extends StatelessWidget {
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
            title: Strings.notys,
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
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 11),
        child: SingleChildScrollView(
            child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 100,
                  padding: EdgeInsets.symmetric(vertical: 5),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Color(0xffEAEAEA)),
                  child: Texts(
                      title: Strings.today,
                      textColor: Colors.black,
                      fontSize: 10,
                      weight: FontWeight.bold,
                      align: TextAlign.center),
                ),
              ],
            ),
            sizedHeight(11),
            ListView.builder(
                itemCount: 10,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Container(
                    padding: EdgeInsets.only(left:20,right: 20,top: 20),
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(bottom: 4),
                    height: 65,
                    decoration: BoxDecoration(
                        color: Color(0xffEAEAEA),
                        borderRadius: BorderRadius.circular(10)),
                        child: Row(
                          children: [
                            SvgPicture.asset("assets/icons/notify.svg",height: 28,width: 28,fit: BoxFit.cover,)
                         ,sizedWidth(24),
                         Expanded(child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                          Texts(
                      title: "تم قبول طلبك ",
                      textColor: Color(0xffA5A5A5),
                      fontSize: 12,
                      weight: FontWeight.bold,
                      align: TextAlign.start),

                       Texts(
                      title: "الطلب رقم 954131 تم قبوله",
                      textColor: Colors.black,
                      fontSize: 10,
                      weight: FontWeight.bold,
                      align: TextAlign.start),
                         ],))
                         
                         
                          ],
                        ),
                  );
                })
          ],
        )),
      ),
    );
  }
}
