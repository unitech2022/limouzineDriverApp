import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/helpers/helper_functions.dart';
import '../../../core/styles/colors.dart';
import '../../../core/utlis/data.dart';
import '../../../core/utlis/strings.dart';
import '../../../core/widgets/texts.dart';
import '../home_screen/components/app_bar_home.dart';
import '../home_screen/components/drawer_widget.dart';

class PolicyScreen extends StatelessWidget {
 final _scaffoldKey = GlobalKey<ScaffoldState>();
 


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
            title: Strings.policy,
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
        padding: EdgeInsets.only(left: 24, right: 24, top: 45, bottom: 30),
        child: SingleChildScrollView(
            child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Texts(
                      title: Strings.descPolicy,
                      textColor: buttonsColor,
                      fontSize: 26  ,
                    
                      weight: FontWeight.bold,
                      align: TextAlign.start),
                ),
              ],
            ),
            sizedHeight(24),
            Row(
              children: [
                Expanded(
                  child: Texts(
                      title: policy,
                      textColor: Color(0xff010F07),
                      fontSize: 16,
                     
                      weight: FontWeight.normal,
                      align: TextAlign.start),
                ),
              ],
            ),
          
          ],
        )),
      ),
  
    );
  }
}