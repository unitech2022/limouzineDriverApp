import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';
import 'package:limousine_driver/core/helpers/functions.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';

import '../../../core/helpers/helper_functions.dart';
import '../../../core/styles/colors.dart';
import '../../../core/utlis/strings.dart';
import '../../../core/widgets/button_widget.dart';
import '../../../core/widgets/texts.dart';
import '../home_screen/components/app_bar_home.dart';
import '../home_screen/components/drawer_widget.dart';
import 'components/card_setting_widget.dart';

class SettingsScreen extends StatelessWidget {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: DrawerWidget(
        scaffoldKey: _scaffoldKey,
      ),
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(50.0),
          child: AppBarHome(
            title: Strings.sittings.tr(),
            onTap: () {
              _scaffoldKey.currentState!.openDrawer();
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
                Texts(
                    title: Strings.settings.tr(),
                    textColor: buttonsColor,
                    fontSize: 31,
                    weight: FontWeight.normal,
                    align: TextAlign.start),
              ],
            ),
            sizedHeight(24),
            Row(
              children: [
                SizedBox(
                  width: 280,
                  child: Texts(
                      title: Strings.descSettings.tr(),
                      textColor: textColor3,
                      fontSize: 16,
                      weight: FontWeight.normal,
                      align: TextAlign.start),
                ),
              ],
            ),
//             sizedHeight(18),

// CardSettingWidget(
//                 onTap: () {},
//                 icon: "assets/icons/dataset.svg",
//                 title: "الحالة: نشط",
//                 subTitle: Strings.statuse,
//                 child: SizedBox(
//                   width: 46,
//                   height: 30,
//                   child: FittedBox(
//                     fit: BoxFit.fill,
//                     child: CupertinoSwitch(

//                       activeColor: Color(0xff22A45D) ,
//                       thumbColor: Colors.white,
//                       trackColor:Color.fromARGB(255, 148, 150, 149) ,
//                       onChanged: (value) {

//                     },value: true,),
//                   ),
//                 )
//                 ),

// CardSettingWidget(
//                 onTap: () {},
//                 icon: "assets/icons/dataset.svg",
//                 title: Strings.app,
//                 subTitle: Strings.notyApp,
//                 child: SizedBox(
//                   width: 46,
//                   height: 30,
//                   child: FittedBox(
//                     fit: BoxFit.fill,
//                     child: CupertinoSwitch(

//                       activeColor: Color(0xff22A45D) ,
//                       thumbColor: Colors.white,
//                       trackColor:Color.fromARGB(255, 148, 150, 149) ,
//                       onChanged: (value) {

//                     },value: true,),
//                   ),
//                 )
//                 ),

//              CardSettingWidget(
//                 onTap: () {},
//                 icon: "assets/icons/dataset.svg",
//                 title: Strings.messages,
//                 subTitle: Strings.messagesToNumber,
//                 child: SizedBox(
//                   width: 46,
//                   height: 30,
//                   child: FittedBox(
//                     fit: BoxFit.fill,
//                     child: CupertinoSwitch(

//                       activeColor: Color(0xff22A45D) ,
//                       thumbColor: Colors.white,
//                       trackColor:Color.fromARGB(255, 148, 150, 149) ,
//                       onChanged: (value) {

//                     },value: false,),
//                   ),
//                 )
//                 ),

//              CardSettingWidget(
//                 onTap: () {},
//                 icon: "assets/icons/dataset.svg",
//                 title: Strings.adds,
//                 subTitle: Strings.smsNoty,
//                 child: SizedBox(
//                   width: 46,
//                   height: 30,
//                   child: FittedBox(
//                     fit: BoxFit.fill,
//                     child: CupertinoSwitch(

//                       activeColor: Color(0xff22A45D) ,
//                       thumbColor: Colors.white,
//                       trackColor:Color.fromARGB(255, 148, 150, 149) ,
//                       onChanged: (value) {

//                     },value: true,),
//                   ),
//                 )
//                 ),

//             CardSettingWidget(
//                 onTap: () {},
//                 icon: "assets/icons/profile.svg",
//                 title: Strings.personalInformation,
//                 subTitle: Strings.updatingInfo,
//                 child: Icon(
//                   Icons.arrow_back_ios_new_rounded,
//                   color: textColor3,
//                   size: 14,
//                 )),
//             CardSettingWidget(
//                 onTap: () {},
//                 icon: "assets/icons/lock.svg",
//                 title: Strings.password,
//                 subTitle: Strings.updatePassword,
//                 child: Icon(
//                   Icons.arrow_back_ios_new_rounded,
//                   color: textColor3,
//                   size: 14,
//                 )),
//             CardSettingWidget(
//                 onTap: () {},
//                 icon: "assets/icons/card.svg",
//                 title: Strings.payment,
//                 subTitle: Strings.systemPayment,
//                 child: Icon(
//                   Icons.arrow_back_ios_new_rounded,
//                   color: textColor3,
//                   size: 14,
//                 )),
//             CardSettingWidget(
//                 onTap: () {},
//                 icon: "assets/icons/decument.svg",
//                 title: Strings.subscription,
//                 subTitle: Strings.loginSubscrip,
//                 child: Icon(
//                   Icons.arrow_back_ios_new_rounded,
//                   color: textColor3,
//                   size: 14,
//                 )),
//             CardSettingWidget(
//                 onTap: () {},
//                 icon: "assets/icons/decument.svg",
//                 title: Strings.savedAddresses,
//                 subTitle: Strings.savedAddresses,
//                 child: Icon(
//                   Icons.arrow_back_ios_new_rounded,
//                   color: textColor3,
//                   size: 14,
//                 )),
//             CardSettingWidget(
//                 onTap: () {},
//                 icon: "assets/icons/share2.svg",
//                 title: Strings.shareFrinds,
//                 subTitle: Strings.makeInvinet,
//                 child: Icon(
//                   Icons.arrow_back_ios_new_rounded,
//                   color: textColor3,
//                   size: 14,
//                 )),

//            sizedHeight(37),
//             Row(
//               children: [
//                 Texts(
//                     title: Strings.others,
//                     textColor: buttonsColor,
//                     fontSize: 20,
//                     family: "alex_bold",
//                     weight: FontWeight.normal,
//                     align: TextAlign.start),
//               ],
//             ),

            sizedHeight(14),
            CardSettingWidget(
                onTap: () {},
                icon: "assets/icons/share2.svg",
                title: Strings.shareApp.tr(),
                subTitle: Strings.makeInvinet.tr(),
                child: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: textColor3,
                  size: 14,
                )),
            CardSettingWidget(
                onTap: () {},
                icon: "assets/icons/rating.svg",
                title: Strings.rateApp.tr(),
                subTitle: Strings.onApple.tr(),
                child: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: textColor3,
                  size: 14,
                )),

            CardSettingWidget(
                onTap: () {},
                icon: "assets/icons/document.svg",
                title: Strings.uses.tr(),
                subTitle: Strings.praivcy.tr(),
                child: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: textColor3,
                  size: 14,
                )),

            sizedHeight(17),

            ButtonWidget(
                height: 55,
                color: homeColor,
                onPress: () {
                  signOut(ctx: context);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset("assets/icons/logout2.svg"),
                    sizedWidth(24),
                     Texts(
                        title: Strings.logout.tr(),
                        textColor: Colors.white,
                        fontSize: 14,
                        weight: FontWeight.normal,
                        align: TextAlign.center),
                  ],
                )),
            sizedHeight(22),
            GestureDetector(
              onTap: () {
                showDialogDeleteAccount(
                    context: context,
                    title: Strings.deleteAccount.tr(),
                    body: Strings.configDelete.tr(),
                    founction: () {
                      pop(context);
                      signOut(ctx: context);
                      showTopMessage(
                          context: context,
                          customBar: CustomSnackBar.error(
                              backgroundColor: Colors.red,
                              message: Strings.deleteAccountSuccess.tr(),
                              textStyle: TextStyle(
                                  fontFamily: "font",
                                  fontSize: 16,
                                  color: Colors.white)));
                    });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset("assets/icons/delete2.svg"),
                  sizedWidth(24),
                   Texts(
                      title: Strings.deleteAccount.tr(),
                      textColor: Colors.red,
                      fontSize: 14,
                      weight: FontWeight.bold,
                      align: TextAlign.center),
                ],
              ),
            ),
          ],
        )),
      ),
    );
  }

  Future<void> showDialogDeleteAccount(
      {context, title, body, founction}) async {
    return showDialog<void>(
      context: context,

      barrierDismissible: false,
      // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          insetPadding: EdgeInsets.symmetric(horizontal: 20),
          title: Text(
            title,
            style: TextStyle(fontSize: 20, color: buttonsColor),
          ),
          content: Container(
            width: widthScreen(context),
            child: SingleChildScrollView(
              child: ListBody(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                          child: Text(
                        body,
                        style: TextStyle(fontSize: 20, color: Colors.black),
                        textAlign: TextAlign.center,
                      )),
                    ],
                  ),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            MaterialButton(
              color: homeColor,
              padding: EdgeInsets.all(5),
              child: Text(Strings.delete.tr(),
                  style: TextStyle(fontSize: 16, color: Colors.white)),
              onPressed: founction,
            ),
            MaterialButton(
              padding: EdgeInsets.all(5),
              color: Colors.red,
              child: Text(Strings.cancle.tr(),
                  style: TextStyle(fontSize: 14, color: Colors.white)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
