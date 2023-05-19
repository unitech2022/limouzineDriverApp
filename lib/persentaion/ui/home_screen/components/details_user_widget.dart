import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:limousine_driver/core/utlis/api_constatns.dart';
import '../../../../core/helpers/helper_functions.dart';
import '../../../../core/styles/colors.dart';
import '../../../../core/utlis/strings.dart';
import '../../../../core/widgets/circle_image_widget.dart';
import '../../../../core/widgets/texts.dart';
import '../../../../data/data_source/local_data/models/UserDetalsPref.dart';


class DetailsUserWidget extends StatelessWidget {
  final UserDetailsPref userDetail;
  const DetailsUserWidget({required this.userDetail});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleImageWidget(
            height: 50, width: 50, image: ApiConstants.imageUrl(userDetail !=null ?userDetail.profileImage :"")),
        sizedWidth(20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Texts(
                title: Strings.welcome.tr(),
                textColor: Colors.black,
                fontSize: 11,
                weight: FontWeight.normal,
                align: TextAlign.center),
            Texts(
                title: userDetail.fullName!,
                textColor: buttonsColor,
                fontSize: 18,
                weight: FontWeight.bold,
                align: TextAlign.center),
          ],
        ),
      ],
    );
  }
}
