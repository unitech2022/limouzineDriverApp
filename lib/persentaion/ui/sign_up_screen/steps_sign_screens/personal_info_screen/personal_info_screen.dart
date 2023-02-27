import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:limousine_driver/core/widgets/circle_image_widget.dart';

import '../../../../../core/helpers/helper_functions.dart';
import '../../../../../core/styles/colors.dart';
import '../../../../../core/utlis/strings.dart';
import '../../../../../core/widgets/texts.dart';
import '../../components/add_photo_widget.dart';
import '../offical_screen/components/container_add_photo_widget.dart';

class PersonalInfoScreen extends StatefulWidget {
  const PersonalInfoScreen({super.key});

  @override
  State<PersonalInfoScreen> createState() => _PersonalInfoScreenState();
}

class _PersonalInfoScreenState extends State<PersonalInfoScreen> {
  final _controller = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller.text = "ammare";
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(left: 25.0, right: 25.0, top: 25.0, bottom: 90),
      child: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Texts(
              title: Strings.prsonalInfo,
              textColor: textColor,
              fontSize: 30,
              align: TextAlign.start,
              weight: FontWeight.bold),
          sizedHeight(15),
          const Texts(
              title: Strings.complateData,
              textColor: Color(0xffA5A5A5),
              fontSize: 14,
              align: TextAlign.start,
              weight: FontWeight.bold),
          sizedHeight(15),
       /*   ContainerAddPhotoWidget(title:  Strings.photoId,image: "",onTap: (){},),
          ContainerAddPhotoWidget(title:  Strings.photoId,image: "",onTap: (){},),
          ContainerAddPhotoWidget(title:  Strings.photoId,image: "",onTap: (){},),*/
          sizedHeight(13),
      /*    SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Texts(
                    title: Strings.selectPhoto,
                    textColor: Color(0xff464646),
                    fontSize: 12,
                    align: TextAlign.center,
                    weight: FontWeight.bold),
                const Texts(
                    title: Strings.typeImage,
                    textColor: Color(0xff464646),
                    fontSize: 12,
                    align: TextAlign.center,
                    weight: FontWeight.bold),
                const Texts(
                    title: Strings.sizeImage,
                    textColor: Color(0xff464646),
                    fontSize: 12,
                    align: TextAlign.center,
                    weight: FontWeight.bold),
              ],
            ),
          ),*/
          sizedHeight(15),
          FieldSignUpWidget(
            controller: _controller,
            label: Strings.firstName,
          ),
          FieldSignUpWidget(
            controller: _controller,
            label: Strings.secondName,
          ),
          FieldSignUpWidget(
            controller: _controller,
            label: Strings.lastName,
          ),
          FieldSignUpWidget(
            controller: _controller,
            label: Strings.email,
          ),
          FieldSignUpWidget(
            controller: _controller,
            label: Strings.password,
            pass: true,
          ),
          FieldSignUpWidget(
            controller: _controller,
            label: Strings.reapat,
            pass: true,
          ),
        ]),
      ),
    );
  }
}

class FieldSignUpWidget extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final bool pass;
  FieldSignUpWidget({required this.controller, required this.label,this.pass=false});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  color: Color.fromARGB(255, 201, 199, 199), width: .2))),
      child: Row(
        children: [
          SizedBox(
            width: 90,
            child: Texts(
                title: label,
                textColor: Color(0xff797979),
                fontSize: 12,
                weight: FontWeight.normal,
                align: TextAlign.start),
          ),
          Expanded(
              child: SizedBox(
                height: 55,
                child: TextField(
            controller: controller,
            style: TextStyle(color: Color(0xff28436C), fontSize: 12),
            decoration: InputDecoration(
                  isDense: true,
                  border: InputBorder.none,
                 contentPadding: EdgeInsets.symmetric(vertical: 15),
                  suffixIcon:pass?
                   Icon(Icons.remove_red_eye,color:  Color(0xff797979),)
                  :SizedBox()),
          ),
              ))
        ],
      ),
    );
  }
}
