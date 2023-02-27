import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/helpers/helper_functions.dart';
import '../../../../core/widgets/texts.dart';

class ContainerPointWidget extends StatelessWidget {
  final String label, value;
  final Color color;
  const ContainerPointWidget(
      {required this.label, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 12,
            width: 12,
            decoration: BoxDecoration(shape: BoxShape.circle, color: color),
          ),
          sizedWidth(10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Texts(
                    title: label,
                    textColor: Colors.black,
                    fontSize: 10,
                    weight: FontWeight.w800,
                    align: TextAlign.start),
                Texts(
                    title: value,
                    textColor: Colors.black,
                    fontSize: 10,
                    weight: FontWeight.normal,
                    align: TextAlign.start),
              ],
            ),
          ),
          sizedWidth(20),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 10,
              ),
              SvgPicture.asset(
                "assets/icons/map.svg",
                color: Colors.black,
                height: 18,
                width: 18,
              ),
            ],
          )
        ],
      ),
    );
  }
}
