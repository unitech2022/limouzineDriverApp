import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../../../../core/helpers/helper_functions.dart';
import '../../../../../core/styles/colors.dart';
import '../../../../../core/utlis/strings.dart';
import '../../../../../core/widgets/texts.dart';

class PrimarySittingsScreen extends StatelessWidget {
  const PrimarySittingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      margin: const EdgeInsets.only(top: 31, left: 25, right: 25, bottom: 80),
      child: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Texts(
              title: Strings.sitingsPrimay1,
              textColor: textColor,
              fontSize: 30,
              align: TextAlign.start,
              weight: FontWeight.bold),
          const Texts(
              title: Strings.sitingsPrimay2,
              textColor: textColor,
              fontSize: 30,
              align: TextAlign.start,
              weight: FontWeight.bold),
          sizedHeight(11),
          const Texts(
              title: Strings.descSitingsPrimay,
              textColor: Color(0xffA5A5A5),
              fontSize: 14,
              align: TextAlign.start,
              weight: FontWeight.bold),
          sizedHeight(15),
          SwitchSignUpWidget(label: Strings.sittingsQuiz1,)
          ,
          SwitchSignUpWidget(label: Strings.sittingsQuiz2,)
          ,
          SwitchSignUpWidget(label: Strings.sittingsQuiz3,)
          ,
          SwitchSignUpWidget(label: Strings.sittingsQuiz4,)
        ],
      )),
    );
  }
}

class SwitchSignUpWidget extends StatelessWidget {
  final String label;
  const SwitchSignUpWidget({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 57,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          border: Border(
              bottom:
                  BorderSide(color: Colors.grey.withOpacity(.5), width: .5))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Texts(
              title: label,
              textColor: Color(0xff797979),
              fontSize: 12,
              weight: FontWeight.normal,
              align: TextAlign.start),
          Transform.scale(
            scaleX: .7,
            scaleY: .6,
            child: CupertinoSwitch(
              activeColor: Color(0xff88D55F),
              thumbColor: Colors.white,
              trackColor: Color.fromARGB(255, 148, 150, 149),
              onChanged: (value) {},
              value: false,
            ),
          )
        ],
      ),
    );
  }
}
