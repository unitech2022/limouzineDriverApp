import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:limousine_driver/persentaion/ui/sign_up_screen/components/add_photo_widget.dart';

import '../../../../../core/helpers/helper_functions.dart';
import '../../../../../core/styles/colors.dart';
import '../../../../../core/utlis/strings.dart';
import '../../../../../core/widgets/texts.dart';
import 'components/container_add_photo_widget.dart';

class OfficialScreen extends StatelessWidget {
  const OfficialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      margin: const EdgeInsets.only(top: 31, left: 25, right: 25, bottom: 80),
      child: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: const Texts(
                title: Strings.mainData,
                textColor: textColor,
                fontSize: 30,
                align: TextAlign.start,
                weight: FontWeight.bold),
          ),
          sizedHeight(11),
          const Texts(
              title: Strings.complateData,
              textColor: Color(0xffA5A5A5),
              fontSize: 14,
              align: TextAlign.start,
              weight: FontWeight.bold),
          sizedHeight(15),
          // ContainerAddPhotoWidget(title:  Strings.photoId,),
          //  ContainerAddPhotoWidget(title:  Strings.photoCar,),
          //  ContainerAddPhotoWidget(title:  Strings.photoCar2,),
          //  ContainerAddPhotoWidget(title:  Strings.photoCar3,)
          //
          //   ,ContainerAddPhotoWidget(title:  Strings.pasport,),
          //  ContainerAddPhotoWidget(title:  Strings.photoCar4,)
        ],
      )),
    );
  }
}

