import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/helpers/helper_functions.dart';
import '../../../../core/widgets/texts.dart';

class ContainerDetailsTrip extends StatelessWidget {
  final String label, value1, value2, value3, icon;
  final Color textColor;
  const ContainerDetailsTrip({
    required this.value3,
    required this.textColor,
    required this.icon,
    required this.label,
    required this.value1,
    required this.value2,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 25,
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey, width: .5))),
      child: Row(
        children: [
          SvgPicture.asset(icon),
          sizedWidth(11),
          SizedBox(
            width: 70,
            child: Texts(
                title: label,
                textColor: Colors.black,
                fontSize: 10,
                family: "alex_bold",
                weight: FontWeight.bold,
                align: TextAlign.start),
          ),
          Texts(
              title: value1,
              textColor: textColor,
              fontSize: 14,
              family: "alex_bold",
              weight: FontWeight.bold,
              align: TextAlign.start),
          sizedWidth(16),
          Texts(
              title: value2,
              textColor: Colors.black,
              fontSize: 10,
              family: "alex_bold",
              weight: FontWeight.bold,
              align: TextAlign.start),
          sizedWidth(33),
          Texts(
              title: value3,
              textColor: Colors.black,
              fontSize: 10,
              family: "alex_bold",
              weight: FontWeight.bold,
              align: TextAlign.start),
        ],
      ),
    );
  }
}
