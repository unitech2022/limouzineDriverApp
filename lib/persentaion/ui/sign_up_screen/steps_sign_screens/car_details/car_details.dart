import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:limousine_driver/core/utlis/data.dart';
import 'package:limousine_driver/persentaion/ui/sign_up_screen/steps_sign_screens/car_details/components/drop_car_details_widget.dart';

import '../../../../../core/helpers/helper_functions.dart';
import '../../../../../core/styles/colors.dart';
import '../../../../../core/utlis/strings.dart';
import '../../../../../core/widgets/custom_drop_down_widget.dart';
import '../../../../../core/widgets/texts.dart';
import '../offical_screen/components/container_add_photo_widget.dart';

class CartDetailsScreen extends StatelessWidget {
  const CartDetailsScreen({super.key});

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
                title: Strings.carDetails,
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
          // ContainerAddPhotoWidget(
          //   title: Strings.photoCarDetails,
          // ),
/*          DropCarDetailsWidget(title: Strings.brandCar,),
           DropCarDetailsWidget(title: Strings.typeCar,),
           DropCarDetailsWidget(title: Strings.modelCar,),
           DropCarDetailsWidget(title: Strings.noteCar,),
           DropCarDetailsWidget(title: Strings.madeCar,),
           DropCarDetailsWidget(title: Strings.sizeCar,),
           DropCarDetailsWidget(title: Strings.colorCar,),*/
          
        ],
      )),
    );
  }
}

