import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Buttons2 extends StatelessWidget {
  final double height;
  final void Function() onPress;
  final double radus;
  final Color color;
  final Widget child;

  Buttons2(
      {required this.child,
      required this.color,
      required this.height,
      required this.onPress,
      required this.radus});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: color,
      child: child,
      height: height,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radus),
      ),
      onPressed: onPress,
    );
  }
}
