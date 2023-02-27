import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/helpers/helper_functions.dart';
import '../../../../core/styles/colors.dart';
import '../../../../core/widgets/texts.dart';

class ContainerTabWidget extends StatelessWidget {
  final String index;
  final String icon, label;
  final void Function() onTap;

  ContainerTabWidget(
      {required this.index,
      required this.icon,
      required this.label,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 32,
        width: 107,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(35),
            border: index == label
                ? Border.all(color: buttonsColor, width: 1.5)
                : null,
            color: Color(0xffF7F7F7)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              icon,
              color: index == label ? Colors.black : Color(0xffA5A5A5),
            ),
            sizedWidth(10),
            Texts(
                title: label,
                textColor: index == label ? Colors.black : Color(0xffA5A5A5),
                fontSize: 9,
                weight: FontWeight.normal,
                align: TextAlign.center),
          ],
        ),
      ),
    );
  }
}
