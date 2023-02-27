import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:limousine_driver/core/routers/routers.dart';

import '../../../../../core/helpers/helper_functions.dart';
import '../../../../../core/styles/colors.dart';
import '../../../../../core/utlis/strings.dart';
import '../../../../../core/widgets/app_bar_widget.dart';
import '../../../../../core/widgets/button_widget.dart';
import '../../../../../core/widgets/texts.dart';

class DoneScreen extends StatelessWidget {
  const DoneScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(50.0),
          child: AppBarWidget(
            title: Strings.accountDriver.tr(),
          )),
      body: Container(
        color: Colors.white,
        margin: const EdgeInsets.only(top: 31, left: 25, right: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
        SizedBox(
          width: 300,
          child:  Texts(
              title: Strings.thanks.tr(),
              textColor: textColor,
              fontSize: 30,
              align: TextAlign.start,
              weight: FontWeight.bold),
        ),

        sizedHeight(11),
         Texts(
            title: Strings.descThanks.tr(),
            textColor: Color(0xffA5A5A5),
            fontSize: 14,
            align: TextAlign.start,
            weight: FontWeight.bold),
        sizedHeight(15),
         Spacer(),
        ButtonWidget(
            height: 55,
            color: homeColor,
                onPress: () {
                  Navigator.pushReplacementNamed(context, home);
                },
            child:  Texts(
                title: Strings.continueLogin.tr(),
                textColor: Colors.white,
                fontSize: 14,
                weight: FontWeight.normal,
                align: TextAlign.center)),
        sizedHeight(15),
          ],
        ),
      ),
    );
  
  }
}