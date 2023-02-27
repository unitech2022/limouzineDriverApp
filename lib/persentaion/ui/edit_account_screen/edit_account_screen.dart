import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../../core/helpers/helper_functions.dart';
import '../../../core/styles/colors.dart';
import '../../../core/utlis/strings.dart';
import '../../../core/widgets/buttons.dart';
import '../../../core/widgets/circle_image_widget.dart';
import '../../../core/widgets/texts.dart';
import '../home_screen/components/app_bar_home.dart';
import '../home_screen/components/drawer_widget.dart';

class EditAccountScreen extends StatefulWidget {
  @override
  State<EditAccountScreen> createState() => _EditAccountScreenState();
}

class _EditAccountScreenState extends State<EditAccountScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

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
          title: Strings.myProfiel,
          onTap: () {},
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
                SizedBox(
                  height: 135,
                  width: 120,
                  child: Stack(
                    children: [
                      Container(
                        height: 120,
                        width: 120,
                        decoration: BoxDecoration(
                            border: Border.all(color: buttonsColor, width: 3),
                            shape: BoxShape.circle),
                        child: CircleImageWidget(
                            height: 120,
                            width: 120,
                            image: "assets/images/person.png"),
                      ),
                      Positioned(
                        bottom: 1,
                        left: 0,
                        right: 0,
                        child: Container(
                          height: 31,
                          width: 31,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: buttonsColor),
                          child: Icon(
                            Icons.camera_alt_outlined,
                            size: 17,
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            sizedHeight(12),
            Texts(
                title: "فواز البالاوي",
                textColor: Colors.black,
                fontSize: 20,
                family: "alex_bold",
                weight: FontWeight.normal,
                align: TextAlign.start),
            sizedHeight(19),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Texts(
                      title: Strings.name,
                      textColor: Color(0xff464646),
                      fontSize: 10,
                      family: "alex_bold",
                      weight: FontWeight.normal,
                      align: TextAlign.start),
                ),
              ],
            ),
            sizedHeight(4),
            FieldEditProfileWidget(controller: _controller, raduis: 30),
            sizedHeight(31),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Texts(
                      title: Strings.email,
                      textColor: Color(0xff464646),
                      fontSize: 10,
                      family: "alex_bold",
                      weight: FontWeight.normal,
                      align: TextAlign.start),
                ),
              ],
            ),
            sizedHeight(4),
            FieldEditProfileWidget(
              controller: _controller,
              type: TextInputType.emailAddress, raduis: 30
            ),
            sizedHeight(31),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Texts(
                      title: Strings.number,
                      textColor: Color(0xff464646),
                      fontSize: 10,
                      family: "alex_bold",
                      weight: FontWeight.normal,
                      align: TextAlign.start),
                ),
              ],
            ),
            sizedHeight(4),
            FieldEditProfileWidget(
              controller: _controller,
              type: TextInputType.number,
              raduis: 30,
            ),
            sizedHeight(31),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Texts(
                      title: Strings.birthday,
                      textColor: Color(0xff464646),
                      fontSize: 10,
                      family: "alex_bold",
                      weight: FontWeight.normal,
                      align: TextAlign.start),
                ),
              ],
            ),
            sizedHeight(4),
            FieldEditProfileWidget(controller: _controller,
              raduis: 30),
            sizedHeight(31),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Texts(
                      title: Strings.gender,
                      textColor: Color(0xff464646),
                      fontSize: 10,
                      family: "alex_bold",
                      weight: FontWeight.normal,
                      align: TextAlign.start),
                ),
              ],
            ),
            sizedHeight(4),
            FieldEditProfileWidget(controller: _controller,
              raduis: 30),
            sizedHeight(31),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Texts(
                      title: Strings.password,
                      textColor: Color(0xff464646),
                      fontSize: 10,
                      family: "alex_bold",
                      weight: FontWeight.normal,
                      align: TextAlign.start),
                ),
              ],
            ),
            sizedHeight(4),
            FieldEditProfileWidget(
              controller: _controller,
              type: TextInputType.visiblePassword,
              raduis: 30,
            ),
            sizedHeight(31),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Texts(
                      title: Strings.reapat,
                      textColor: Color(0xff464646),
                      fontSize: 10,
                      family: "alex_bold",
                      weight: FontWeight.normal,
                      align: TextAlign.start),
                ),
              ],
            ),
            sizedHeight(4),
            FieldEditProfileWidget(
              controller: _controller,
              type: TextInputType.visiblePassword,
              raduis: 30,
            ),
            sizedHeight(28),
            SizedBox(
              width: double.infinity,
              child: Buttons2(
                onPress: () {},
                radus: 10,
                height: 44,
                color: homeColor,
                child: Texts(
                    title: Strings.save,
                    textColor: Colors.white,
                    fontSize: 14,
                    weight: FontWeight.normal,
                    align: TextAlign.center),
              ),
            ),
          ],
        )),
      ),
    );
  }
}

class FieldEditProfileWidget extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType type;
  final double raduis,height;
  const FieldEditProfileWidget(
      {required this.controller, this.type = TextInputType.text,required this.raduis,this.height=40});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 27),
      decoration: BoxDecoration(
        color: Color(0xffF7F7F7),
        borderRadius: BorderRadius.circular(raduis),
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: type,
        style: TextStyle(color: Color(0xff7C7C7C), fontSize: 16),
        decoration: InputDecoration(
          isDense: true,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
