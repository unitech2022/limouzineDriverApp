import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';
import 'package:limousine_driver/core/helpers/functions.dart';
import 'package:limousine_driver/core/helpers/helper_functions.dart';
import 'package:limousine_driver/core/styles/colors.dart';
import 'package:limousine_driver/core/utlis/api_constatns.dart';
import 'package:limousine_driver/core/utlis/app_model.dart';
import 'package:limousine_driver/core/utlis/strings.dart';
import 'package:limousine_driver/core/widgets/circle_image_widget.dart';
import 'package:limousine_driver/persentaion/ui/update_official_documents/update_offical_decuments.dart';

import '../../../core/routers/routers.dart';
import '../../../core/widgets/buttons.dart';
import '../../../core/widgets/texts.dart';
import '../home_screen/components/app_bar_home.dart';
import '../home_screen/components/drawer_widget.dart';

class AccountScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

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
          title: Strings.myProfiel.tr(),
          onTap: () {
            _scaffoldKey.currentState!.openDrawer();
          },
          child: IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.more_vert,
                color: Colors.white,
              )),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: SingleChildScrollView(
            child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: buttonsColor, width: 3),
                      shape: BoxShape.circle),
                  child: CircleImageWidget(
                      height: 120,
                      width: 120,
                      image: ApiConstants.imageUrl(currentUser.profileImage!)),
                ),
              ],
            ),
            sizedHeight(25),
            Texts(
                title: currentUser.fullName!,
                textColor: Colors.black,
                fontSize: 20,
                family: "alex_bold",
                weight: FontWeight.normal,
                align: TextAlign.start),
            sizedHeight(11),
            Texts(
                title: currentUser.email!,
                textColor: Colors.black,
                fontSize: 12,
                weight: FontWeight.normal,
                align: TextAlign.start),
            sizedHeight(21),
            SizedBox(
                width: 220,
                child: Buttons2(
                  onPress: () {
                    Navigator.pushNamed(context, editAccount);
                  },
                  radus: 30,
                  height: 44,
                  color: buttonsColor,
                  child: Texts(
                      title: Strings.editAccounte.tr(),
                      textColor: Colors.white,
                      fontSize: 14,
                      weight: FontWeight.normal,
                      align: TextAlign.center),
                )),
            sizedHeight(41),
            Divider(
              height: .8,
            ),
            sizedHeight(31),
            // RowItemProfile(
            //   textColor: Colors.black,
            //   onTap: () {},
            //   color: Color(0xff0B2957),
            //   icon: "assets/icons/sittings.svg",
            //   title: Strings.genralSitings.tr(),
            // ),
            // sizedHeight(23),
            RowItemProfile(
              textColor: Colors.black,
              onTap: () {
                pushPage(context:context,page: UpdateOfficialDocuments());
              },
              color: Color(0xff0B2957),
              icon: "assets/icons/acount.svg",
              title: Strings.myData.tr(),
            ),
            sizedHeight(23),
            RowItemProfile(
              textColor: Colors.black,
              onTap: () {},
              color: Color(0xff0B2957),
              icon: "assets/icons/acount.svg",
              title: Strings.dataBank.tr(),
            ),
            sizedHeight(23),
            Divider(
              height: .8,
            ),
            sizedHeight(23),
            RowItemProfile(
              textColor: Colors.black,
              onTap: () {
                signOut(ctx: context);
              },
              color: Color(0xff0B2957),
              icon: "assets/icons/logout.svg",
              title: Strings.logoutFromAccount.tr(),
            ),
            sizedHeight(23),
            RowItemProfile(
              textColor: Color(0xffF2154F),
              onTap: () {},
              color: Color(0xffF2154F),
              icon: "assets/icons/delete2.svg",
              title: Strings.deleteAccount.tr(),
            ),
          ],
        )),
      ),
    );
  }
}

class RowItemProfile extends StatelessWidget {
  final String icon, title;
  final Color color, textColor;
  final void Function() onTap;

  const RowItemProfile(
      {required this.color,
      required this.textColor,
      required this.icon,
      required this.onTap,
      required this.title});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Container(
            height: 24,
            width: 24,
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Color(0xffEAEAEA)),
            child: SvgPicture.asset(icon, color: color),
          ),
          sizedWidth(22),
          Expanded(
            child: Texts(
                title: title,
                textColor: textColor,
                fontSize: 16,
                weight: FontWeight.normal,
                align: TextAlign.start),
          ),
          Container(
              height: 24,
              width: 24,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: Color(0xffEAEAEA)),
              child: Icon(
                Icons.keyboard_arrow_left,
                color: Color(0xff0B2957),
              )),
        ],
      ),
    );
  }
}
