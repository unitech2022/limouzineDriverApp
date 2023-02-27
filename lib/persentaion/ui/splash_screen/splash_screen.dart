import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:limousine_driver/core/helpers/functions.dart';

import '../../../core/styles/colors.dart';
import '../../../core/utlis/strings.dart';

import '../../../core/widgets/texts.dart';
import '../../controller/app_cubit/cubit/app_cubit.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLocation();
    AppCubit.get(context).getPage(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: homeColor,
          body: Container(
            alignment: Alignment.center,
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: 80,
                        width: 80,
                        child: SvgPicture.asset(
                          "assets/icons/login.svg",
                          width: 80,
                          height: 80,
                        ),
                      ),
                      // Texts(
                      //     title: Strings.limozine,
                      //     textColor: Colors.white,
                      //     fontSize: 28,
                      //     family: "alex_bold",
                      //     align: TextAlign.center,
                      //     weight: FontWeight.bold),
                      // Texts(
                      //     title: Strings.driver,
                      //     textColor: Colors.white,
                      //     fontSize: 28,
                      //     family: "alex_bold",
                      //     align: TextAlign.center,
                      //     weight: FontWeight.bold)
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                      padding: const EdgeInsets.only(bottom: 50),
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      )),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
