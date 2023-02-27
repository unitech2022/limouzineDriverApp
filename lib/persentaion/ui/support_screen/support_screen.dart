import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/helpers/helper_functions.dart';
import '../../../core/styles/colors.dart';
import '../../../core/utlis/strings.dart';
import '../../../core/widgets/button_widget.dart';
import '../../../core/widgets/texts.dart';
import '../edit_account_screen/edit_account_screen.dart';
import '../home_screen/components/app_bar_home.dart';
import '../home_screen/components/drawer_widget.dart';

class SupportScreen extends StatefulWidget {
  @override
  State<SupportScreen> createState() => _SupportScreenState();
}

class _SupportScreenState extends State<SupportScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _controller = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller.text = "ammarIbrahime";
  }

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
                      title: Strings.supportTitle,
                      textColor: buttonsColor,
                      fontSize: 26,
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
                      title: Strings.supportDesc,
                      textColor: Color(0xff010F07),
                      fontSize: 16,
                      weight: FontWeight.normal,
                      align: TextAlign.start),
                ),
              ],
            ),
            sizedHeight(29),
            FieldEditProfileWidget(
              controller: _controller,
              raduis: 10,
              height: 54,
            ),
            sizedHeight(14),
            FieldEditProfileWidget(
              controller: _controller,
              raduis: 10,
              height: 54,
            ),
            sizedHeight(14),
            Container(
              height: 140,
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: 27),
              decoration: BoxDecoration(
                color: Color(0xffF7F7F7),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _controller,
                      keyboardType: TextInputType.text,
                      style: TextStyle(color: Color(0xff7C7C7C), fontSize: 16),
                      decoration: InputDecoration(
                        isDense: true,
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.attach_file_rounded)),
                      Texts(
                          title: "باقي255 حرف",
                          textColor: Color(0xff010F07),
                          fontSize: 12,
                          weight: FontWeight.normal,
                          align: TextAlign.start),
                    ],
                  )
                ],
              ),
            ),
            sizedHeight(14),
            Container(
              height: 50,
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: 27),
              decoration: BoxDecoration(
                color: Color(0xffF7F7F7),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.photo_library_rounded,
                    size: 16,
                  ),
                  sizedWidth(15),
                  Texts(
                      title: Strings.attachment,
                      textColor: Color(0xff010F07),
                      fontSize: 16,
                      weight: FontWeight.normal,
                      align: TextAlign.start),
                  sizedWidth(30),
                  Expanded(
                      child: ListView.builder(
                          itemCount: 5,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return Container(
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10)),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.asset("assets/images/img2.png")),
                            );
                          })),
                ],
              ),
            ),
            sizedHeight(14),
            ButtonWidget(
                height: 55,
                color: homeColor,
                onPress: () {
                  showDialogRating();
                },
                child: const Texts(
                    title: Strings.send,
                    textColor: Colors.white,
                    fontSize: 14,
                    weight: FontWeight.normal,
                    align: TextAlign.center)),
            sizedHeight(34),
            const Texts(
                title: Strings.scialMedia,
                textColor: homeColor,
                fontSize: 16,
                weight: FontWeight.normal,
                align: TextAlign.center),
            sizedHeight(34),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset("assets/icons/twiter.svg"),
                sizedWidth(22),
                SvgPicture.asset("assets/icons/linked_in.svg"),
                sizedWidth(22),
                SvgPicture.asset("assets/icons/inst.svg"),
                sizedWidth(22),
                SvgPicture.asset("assets/icons/face.svg"),
                sizedWidth(22),
                SvgPicture.asset("assets/icons/youtub.svg")
              ],
            )
          ],
        )),
      ),
    );
  }
  
  void showDialogRating() {
    
  }
}
