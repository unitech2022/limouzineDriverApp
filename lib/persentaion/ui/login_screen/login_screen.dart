import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:limousine_driver/core/widgets/app_bar_widget.dart';
import 'package:limousine_driver/persentaion/controller/auth_cubit/auth_cubit.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';

import '../../../core/helpers/functions.dart';
import '../../../core/helpers/helper_functions.dart';
import '../../../core/routers/routers.dart';
import '../../../core/styles/colors.dart';
import '../../../core/utlis/enums.dart';
import '../../../core/utlis/strings.dart';
import '../../../core/widgets/button_widget.dart';
import '../../../core/widgets/loading_widget.dart';
import '../../../core/widgets/text_field_widget.dart';
import '../../../core/widgets/texts.dart';
import 'dart:ui' as ui;
class LoginScreen extends StatelessWidget {
  final _controllerPhone = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        return Scaffold(
            appBar: PreferredSize(
                preferredSize: Size.fromHeight(50.0),
                child: AppBarWidget(
                  title: Strings.login.tr(),
                )),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 31),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Texts(
                      title: Strings.login1.tr(),
                      textColor: textColor,
                      fontSize: 30,
                      align: TextAlign.start,
                      weight: FontWeight.bold),
                  Texts(
                      title: Strings.login2.tr(),
                      textColor: textColor,
                      fontSize: 30,
                      align: TextAlign.start,
                      weight: FontWeight.bold),
                  sizedHeight(15),
                  Texts(
                      title: Strings.descLogin.tr(),
                      textColor: Colors.grey,
                      fontSize: 14,
                      align: TextAlign.start,
                      weight: FontWeight.bold),


                  sizedHeight(70),
                  Directionality(
                    textDirection: ui.TextDirection.ltr,
                    child: Container(
                      height: 55,
                      padding: EdgeInsets.symmetric(horizontal: 25),
                      decoration: BoxDecoration(
                        color: Colors.white,
                  
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: const[
                          BoxShadow(
                              color: Color.fromARGB(70, 158, 158, 158), //New
                              blurRadius: 20.0,
                              offset: Offset(1, 1))
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          sizedWidth(8),
                          Image.asset("assets/images/flag.png"),
                          sizedWidth(8),
                          const Texts(
                              title: Strings.codeNumber,
                              textColor: Color(0xff464646),
                              fontSize: 14,
                              weight: FontWeight.bold,
                              align: TextAlign.center),
                          sizedWidth(8),
                          Expanded(
                            child: SizedBox(
                                height: 60,
                                child: Center(
                                  child: TextField(
                                    controller: _controllerPhone,
                                    keyboardType: TextInputType.number,
                                    cursorColor: Colors.grey,
                                    maxLength: 9,
                                    decoration: InputDecoration(
                                        counterText: "",
                                        hintStyle: TextStyle(fontSize: 14),
                                        isDense: true,
                                        hintText: Strings.enterNumber.tr(),
                                        border: InputBorder.none
                                    ),
                                  ),
                                )),
                          ),
                          sizedWidth(8),
                  
                  
                        ],
                      ),
                  
                    ),
                  )
                  // TextFieldWidget(
                  //   hint: Strings.hintEmail,
                  //   suffixIcon: const SizedBox(),
                  //   prefixIcon: Icons.email,
                  //   input: TextInputType.emailAddress,
                  //   controller: _controller,
                  // ),
                  // sizedHeight(21),
                  // TextFieldWidget(
                  //   hint: Strings.hintPass,
                  //   suffixIcon: IconButton(
                  //       onPressed: () {},
                  //       icon: const Icon(
                  //         Icons.remove_red_eye_sharp,
                  //         color: Color(0xffDBDBDB),
                  //       )),
                  //   prefixIcon: Icons.lock_rounded,
                  //   input: TextInputType.visiblePassword,
                  //   controller: _controller,
                  // ),
                  , sizedHeight(21),
                  state.checkUserStet==RequestState.loading?  LoadingWidget(height: 55,color: homeColor,)  : ButtonWidget(
                      height: 55,
                      color: homeColor,
                      onPress: () {


                        if(_controllerPhone.text.isEmpty||_controllerPhone.text.length<9){
                           showTopMessage(
                                context: context,
                                customBar: CustomSnackBar.error(
                                    backgroundColor: Colors.red,
                                    message: Strings.pleasEnterPhone.tr(),
                                    textStyle: TextStyle(
                                        fontFamily: "font",
                                        fontSize: 16,
                                        color: Colors.white)));
                        }else{
                          AuthCubit.get(context).checkUser(userName: Strings.codeNumber+_controllerPhone.text,context: context);
                        }
                      },
                      child: Texts(
                          title: Strings.login.tr(),
                          textColor: Colors.white,
                          fontSize: 14,
                          weight: FontWeight.normal,
                          align: TextAlign.center)),
                  sizedHeight(20),
                  /*  Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Texts(
                      title: Strings.forgetPass,
                      textColor: Color(0xffA5A5A5),
                      fontSize: 15,
                      weight: FontWeight.normal,
                      align: TextAlign.center),
                  Texts(
                      title: Strings.forgetUserName,
                      textColor: Color(0xffA5A5A5),
                      fontSize: 15,
                      weight: FontWeight.normal,
                      align: TextAlign.center)
                ],
              ),
              Spacer(),
              ButtonWidget(
                isElevation: false,
                height: 55,
                color: Color(0xffF7F7F7),
                onPress: () {
                  Navigator.pushNamed(context, signUp);
                },
                child: const Texts(
                    title: Strings.signUp,
                    textColor: Colors.grey,
                    fontSize: 14,
                    align: TextAlign.center,
                    weight: FontWeight.bold),
              ),*/
                ],
              ),
            ));
      },
    );
  }
}
