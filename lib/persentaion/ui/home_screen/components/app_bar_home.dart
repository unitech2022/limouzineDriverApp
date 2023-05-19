import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../core/widgets/texts.dart';

class AppBarHome extends StatelessWidget {
  final void Function() onTap;
  final String title;
  final Widget child;
  AppBarHome({required this.onTap, required this.child,required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      leading: child,
      title: Texts(
          title: title,
          textColor: Colors.white,
          fontSize: 16,
          weight: FontWeight.normal,
          align: TextAlign.center),
      actions: [
        MaterialButton(
            onPressed: onTap, child: SvgPicture.asset("assets/icons/menu.svg")),
      ],
    );
  }
}
