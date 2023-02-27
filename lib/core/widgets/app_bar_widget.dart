import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';
import 'package:limousine_driver/core/widgets/icon_button_back.dart';
import 'package:limousine_driver/core/widgets/texts.dart';

import '../helpers/helper_functions.dart';

class AppBarWidget extends StatelessWidget {
  final String title;

  const AppBarWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      leading:   Container(
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
      title: Texts(
          title: title,
          textColor: Colors.white,
          fontSize: 16,
          weight: FontWeight.normal,
          align: TextAlign.center),
      actions: [


         IconButton(onPressed: () => pop(context), icon: const Icon(Icons.arrow_forward,
         color: Colors.white,)),
      
      ],
    );
  }
}
