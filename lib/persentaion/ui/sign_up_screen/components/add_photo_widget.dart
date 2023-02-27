import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:limousine_driver/core/widgets/circle_image_widget.dart';

class AddPhotoWidget extends StatelessWidget {
  final double height, width;
  final String image;
  AddPhotoWidget({required this.height, required this.width,required this.image});

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        height: height,
        width: width,
     /*   decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/image_person.png"),
                colorFilter: ColorFilter.mode(
                  Colors.white.withOpacity(0.3),
                  BlendMode.modulate,
                )),
            color: Color.fromARGB(207, 233, 230, 230),
            shape: BoxShape.circle),*/
        child:image=="" ?Image.asset("assets/images/image_person.png"):CircleImageWidget(height: height,width: width,image: image,),
      ),
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
    ]);
  }
}
