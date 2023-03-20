import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:limousine_driver/core/helpers/functions.dart';
import 'package:limousine_driver/core/utlis/api_constatns.dart';
import 'package:limousine_driver/core/utlis/app_model.dart';
import 'package:limousine_driver/core/widgets/circle_image_widget.dart';
import 'package:limousine_driver/core/widgets/container.divider.dart';
import 'package:limousine_driver/domin/entities/driver.dart';
import 'package:limousine_driver/persentaion/controller/trip_cubit/trip_cubit.dart';

import '../../../../core/helpers/helper_functions.dart';
import '../../../../core/routers/routers.dart';
import '../../../../core/styles/colors.dart';
import '../../../../core/utlis/strings.dart';
import '../../../../core/widgets/texts.dart';
import '../home_screen.dart';
import 'item_menu.dart';

class DrawerWidget extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  Driver? driver;
  bool? activeDriver;
  DrawerWidget(
      {super.key, required this.scaffoldKey, this.driver, this.activeDriver});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerRight,
      padding: const EdgeInsets.only(left: 24, right: 24, top: 38),
      width: widthScreen(context) - 70,
      decoration:  BoxDecoration(
        borderRadius: BorderRadius.only(
          topRight: AppModel.lang == "ar" ? Radius.circular(0) : Radius.circular(80),
          bottomRight: AppModel.lang == "ar" ? Radius.circular(0) : Radius.circular(80),
          topLeft: AppModel.lang == "en" ? Radius.circular(0) : Radius.circular(80),
          bottomLeft: AppModel.lang == "en" ? Radius.circular(0) : Radius.circular(80),
        ),
        color: Color(0xff0B1B2F),
      ),
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            GestureDetector(
              onTap: () {
                scaffoldKey.currentState!.closeDrawer();
              },
              child: Container(
                height: 36,
                width: 36,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color.fromARGB(42, 255, 255, 255)),
                child: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
        sizedHeight(10),
        Row(
          children: [
            SizedBox(
              height: 90,
              width: 90,
              child: Stack(
                children: [
                  Container(
                    width: 90,
                    height: 90,
                    decoration: BoxDecoration(
                        color: textColor2,
                        shape: BoxShape.circle,
                        border: Border.all(color: textColor, width: 3)),
                    child: CircleImageWidget(
                        height: 90,
                        width: 90,
                        image:
                            ApiConstants.imageUrl(currentUser.profileImage!)),
                  ),
                  Positioned(
                      left: 5,
                      top: 10,
                      child: Container(
                        height: 16,
                        width: 16,
                        decoration: BoxDecoration(
                            color: Color(0xff88D55F),
                            shape: BoxShape.circle,
                            border: Border.all(color: textColor, width: 3)),
                      )),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      alignment: Alignment.center,
                      height: 25,
                      width: 70,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(color: textColor, width: 3),
                          color: Color(0xff28436C)),
                      child: Texts(
                          title: "المستوي : 11",
                          textColor: Colors.white,
                          fontSize: 9,
                          weight: FontWeight.normal,
                          align: TextAlign.center),
                    ),
                  )
                ],
              ),
            ),
            sizedWidth(20),
            Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Texts(
                    title: currentUser.fullName!,
                    textColor: Colors.white,
                    fontSize: 20,
                    weight: FontWeight.normal,
                    align: TextAlign.start),
                sizedHeight(11),
                Texts(
                    title: "هيونداي سوناتا . جده 5234",
                    textColor: Color(0xff82B4FF),
                    fontSize: 10,
                    weight: FontWeight.normal,
                    align: TextAlign.start),
                sizedHeight(2),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Texts(
                        title: "الحالة :  ",
                        textColor: Color(0xff82B4FF),
                        fontSize: 10,
                        weight: FontWeight.normal,
                        align: TextAlign.start),
                    Texts(
                        title: TripCubit.get(context).statusDriver
                            ? " انلاين"
                            : " اوفلاين",
                        textColor: Color.fromARGB(255, 19, 224, 60),
                        fontSize: 10,
                        weight: FontWeight.normal,
                        align: TextAlign.start),
                    Transform.scale(
                      scaleX: .65,
                      scaleY: .55,
                      child: CupertinoSwitch(
                        activeColor: Color(0xff88D55F),
                        thumbColor: Colors.white,
                        trackColor: Color.fromARGB(255, 148, 150, 149),
                        onChanged: (value) {
                          if (activeDriver!) {
                            pop(context);
                            showSnakeBar(
                                context: context, message: Strings.isActive);
                          } else {
                            TripCubit.get(context).changeStatusDriver(
                                driverId: driver!.id, status: value ? 1 : 0);
                          }
                        },
                        value: TripCubit.get(context).statusDriver,
                      ),
                    )
                  ],
                )
              ],
            ))
          ],
        ),
        sizedHeight(25),
        Container(
          child: Row(
            children: [
              RowCounterDrawer(
                value: "1811",
                title: Strings.trip,
              ),
              ContainerDivider(
                width: .5,
                color: Color(0xff82B4FF),
                height: 40,
              ),
              RowCounterDrawer(
                value: "4.9",
                title: Strings.yourRate,
              ),
              ContainerDivider(
                width: .5,
                color: Color(0xff82B4FF),
                height: 40,
              ),
              RowCounterDrawer(
                value: "3",
                title: Strings.year,
              ),
            ],
          ),
        ),
        sizedHeight(25),
        Container(
          height: .3,
          margin: EdgeInsets.symmetric(horizontal: 30),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Color.fromARGB(255, 3, 169, 78),
            boxShadow: [
              BoxShadow(
                color: Colors.black,
                offset: Offset(.5, .5), //(x,y)
                blurRadius: 25.0,
              ),
            ],
          ),
        ),
        sizedHeight(30),
        ItemMenu(
          text: Strings.main,
          icon: "assets/icons/home_menu.svg",
          child: const SizedBox(),
          onTap: () {
            Navigator.pushNamed(context, home);
          },
        ),
        sizedHeight(25),
        ItemMenu(
          text: Strings.account,
          icon: "assets/icons/acount.svg",
          child: const Texts(
              title: "٩٥٠ ر.س",
              textColor: Color(0xffA5A5A5),
              fontSize: 16,
              weight: FontWeight.normal,
              align: TextAlign.center),
          onTap: () {
            pop(context);
            Navigator.pushNamed(context, account);
          },
        ),
        sizedHeight(25),
         ItemMenu(
          text: Strings.lang.tr(),
          icon: "assets/icons/translate.svg",
          child:  Texts(
              title:AppModel.lang == "ar"? "العربية":"English",
              textColor: Color(0xffA5A5A5),
              fontSize: 16,
              weight: FontWeight.normal,
              align: TextAlign.center),
          onTap: () {
            showMyDialog(
                context: context,
                title: "",
                body: AppModel.lang == "ar"
                    ? "تغيير الى اللغة الانجليزية "
                    : "Translate to Arabic",
                founction: () async {
                  if (AppModel.lang == "ar") {
                    AppModel.lang = "en";
                    context.setLocale(Locale('en'));
                    await saveData(ApiConstants.langKey, 'en');
                    pop(context);
                    Navigator.pushNamed(context, splash);
                  } else {
                    AppModel.lang = "ar";
                    context.setLocale(Locale('ar'));
                    await saveData(ApiConstants.langKey, 'ar');
                    pop(context);
                    Navigator.pushNamed(context, splash);
                  }
                });
          },
        ),
        sizedHeight(25),
        ItemMenu(
          text: Strings.notys,
          icon: "assets/icons/notifications.svg",
          child:SizedBox(),
          //  Container(
          //     padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
          //     decoration: BoxDecoration(
          //         borderRadius: BorderRadius.circular(15), color: buttonsColor),
          //     child: const Texts(
          //         title: "١٢ جديد",
          //         textColor: Color(0xffA5A5A5),
          //         fontSize: 11,
          //         weight: FontWeight.normal,
          //         align: TextAlign.center)),
          
          onTap: () {
            pop(context);
            Navigator.pushNamed(context, notifications);
          },
        ),
        sizedHeight(25),
        ItemMenu(
          text: Strings.history,
          icon: "assets/icons/history.svg",
          child: const Texts(
              title: "١٢٠ رحله",
              textColor: Color(0xffA5A5A5),
              fontSize: 16,
              weight: FontWeight.normal,
              align: TextAlign.center),
          onTap: () {
            pop(context);
            Navigator.pushNamed(context, history);
          },
        ),
        // sizedHeight(25),
        // ItemMenu(
        //   text: Strings.nickNames,
        //   icon: "assets/icons/nickname.svg",
        //   child: SizedBox(),
        //   onTap: () {
        //     // Navigator.pushNamed(context, subscription);
        //   },
        // ),
        sizedHeight(25),
        ItemMenu(
          text: Strings.sittings,
          icon: "assets/icons/sittings.svg",
          child: const SizedBox(),
          onTap: () {
            Navigator.pushNamed(context, settings);
          },
        ),
        sizedHeight(25),
        ItemMenu(
          text: Strings.support,
          icon: "assets/icons/help.svg",
          child: SizedBox(),
          onTap: () {
            Navigator.pushNamed(context, support);
          },
        ),
        sizedHeight(25),
        ItemMenu(
          text: Strings.privacy,
          icon: "assets/icons/aboute.svg",
          child: const SizedBox(),
          onTap: () {
            Navigator.pushNamed(context, policy);
          },
        ),
        const Spacer(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Texts(
                title: "V 1.00",
                textColor: Color(0xffA5A5A5),
                fontSize: 16,
                weight: FontWeight.normal,
                align: TextAlign.center),
            Row(
              children: [
                SvgPicture.asset(
                  "assets/icons/logout.svg",
                  width: 24,
                  height: 24,
                  color: Colors.white,
                ),
                sizedWidth(18),
                const Texts(
                    title: Strings.logout,
                    textColor: Colors.white,
                    fontSize: 16,
                    weight: FontWeight.normal,
                    align: TextAlign.right),
              ],
            )
          ],
        ),
        sizedHeight(42)
      ]),
    );
  }
}

class RowCounterDrawer extends StatelessWidget {
  final String title, value;
  const RowCounterDrawer({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Column(
      children: [
        Texts(
            title: value,
            textColor: Colors.white,
            fontSize: 23,
            weight: FontWeight.normal,
            align: TextAlign.start),
        Texts(
            title: title,
            textColor: Color(0xff82B4FF),
            fontSize: 12,
            weight: FontWeight.normal,
            align: TextAlign.start),
      ],
    ));
  }
}
