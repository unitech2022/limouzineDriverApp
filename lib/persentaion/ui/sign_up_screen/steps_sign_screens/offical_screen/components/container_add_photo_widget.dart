
import 'package:flutter/material.dart';


import '../../../../../../core/styles/colors.dart';
import '../../../../../../core/utlis/strings.dart';
import '../../../../../../core/widgets/texts.dart';


class ContainerAddPhotoWidget extends StatelessWidget {
  final String title;
  final String image;
  final Widget imageWidget;
  final void Function() onTap;
  ContainerAddPhotoWidget({required this.title,required this.image,required this.onTap,required this.imageWidget});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      alignment: Alignment.center,
     /* decoration: BoxDecoration(
          border: Border(
              bottom:
                  BorderSide(color: Colors.grey.withOpacity(.5), width: .5))),*/
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Texts(
                    title:title,
                    textColor: textColor3,
                    fontSize: 12,
                    align: TextAlign.start,
                    weight: FontWeight.normal),
                Texts(
                    title: Strings.typeImage,
                    textColor: Color(0xffCCCCCC),
                    fontSize: 12,
                    align: TextAlign.start,
                    weight: FontWeight.normal),
                Texts(
                    title: Strings.sizeImage,
                    textColor: Color(0xffCCCCCC),
                    fontSize: 12,
                    align: TextAlign.start,
                    weight: FontWeight.normal),
              ],
            ),
          ),
          GestureDetector(
              onTap: onTap,
              child: Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.grey, width: 1)),
                  child:Stack(children: [
                   imageWidget,
                    Positioned(
                      left: 0,
                      right: 0,
                      top: 0,
                      bottom: 0,
                      child: Icon(
                        Icons.camera_alt_outlined,
                        size: 30,
                        color: Color.fromARGB(255, 125, 124, 124),
                      ),
                    ),
                    Positioned(
                        left: 0,
                        top: 5,
                        child: Container(
                          padding: EdgeInsets.all(1),
                          decoration:
                          BoxDecoration(color: Color(0xffA5A5A5), shape: BoxShape.circle),
                          child: Icon(
                            Icons.close,
                            color: Colors.white,
                            size: 17,
                          ),
                        ))
                  ])))
        ],
      ),
    );
  }
}
