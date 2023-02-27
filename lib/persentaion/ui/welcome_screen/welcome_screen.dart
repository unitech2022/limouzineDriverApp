
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:limousine_driver/core/styles/colors.dart';

import '../../../core/helpers/helper_functions.dart';
import '../../../core/routers/routers.dart';
import '../../../core/utlis/strings.dart';
import '../../../core/widgets/button_widget.dart';
import '../../../core/widgets/texts.dart';
import 'components/ttitle_app.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: homeColor,
      body: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Container(
          alignment: Alignment.center,
          child: const TitleApp(
            heightIcon: 70,
            widthIcon: 100,
            fontSize: 60,
          ),
        ),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(children: [
             Texts(
                title: Strings.welcomeTo.tr(),
                textColor: textColor,
                fontSize: 38,
                align: TextAlign.center,
                weight: FontWeight.bold),
            sizedHeight(9),
             Texts(
                title: Strings.descPlatform.tr(),
                textColor: Color(0xffFFFFFF),
                fontSize: 15,
                align: TextAlign.center,
                weight: FontWeight.normal),
            sizedHeight(25),
            ButtonWidget(
              onPress: () {
                Navigator.pushNamed(context, login);
              },
              color:  Color(0xffFFFFFF),
              height: 55,
              isElevation: false,
              isBorder: true,
              
              child:  Texts(
                  title: Strings.loginOrSignUp.tr(),
                  textColor:  Color(0xffFFFFFF),
                  fontSize: 14,
                  align: TextAlign.center,
                  weight: FontWeight.bold),
            ),
            sizedHeight(27),
          ]),
        )
      ]),
    );
  }
}
