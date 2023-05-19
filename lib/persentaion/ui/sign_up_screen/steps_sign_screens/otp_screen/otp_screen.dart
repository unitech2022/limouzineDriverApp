import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:limousine_driver/core/styles/colors.dart';
import 'package:limousine_driver/persentaion/controller/auth_cubit/auth_cubit.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../../../core/helpers/helper_functions.dart';
import '../../../../../core/utlis/enums.dart';
import '../../../../../core/utlis/strings.dart';
import '../../../../../core/widgets/app_bar_widget.dart';
import '../../../../../core/widgets/button_widget.dart';
import '../../../../../core/widgets/loading_widget.dart';
import '../../../../../core/widgets/texts.dart';
import 'dart:ui' as ui;
class OtpScreen extends StatefulWidget {
  final String phone;


  OtpScreen({required this.phone});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  String code = "";
    Timer? _timer;

      int _start = 60;
  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }
 @override
  void initState() {
    // TODO: implement initState
    super.initState();
     startTimer();
  }
    @override
  void dispose() {
    _timer!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  BlocBuilder<AuthCubit, AuthState>(
  builder: (context, state) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(50.0),
          child: AppBarWidget(
            title: Strings.codeOtp.tr(),
          )),
      body: Container(
        color: Colors.white,
        margin: const EdgeInsets.only(top: 31,left: 20,right: 20,bottom: 80),
        child: SingleChildScrollView(child:
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

           Texts(
                   title: Strings.enterCodeOtp.tr(),
                   textColor: textColor,
                   fontSize: 30,
                   align: TextAlign.start,
                   weight: FontWeight.bold),
           Texts(
                    title: Strings.codeOtp.tr(),
                    textColor: textColor,
                    fontSize: 30,
                    align: TextAlign.start,
                    weight: FontWeight.bold),
                    sizedHeight(15),

                  Text.rich(
              TextSpan(
                text: Strings.timeCode.tr(),
                style: TextStyle(color: Color(0xffA5A5A5),fontSize: 15),
                children: <InlineSpan>[
                  TextSpan(
                    text: "$_start",
                    style: TextStyle(fontSize:15,fontWeight: FontWeight.bold,color: buttonsColor),
                  )
                ]
              )
            ),



                sizedHeight(15),
                Directionality(
                textDirection: ui.TextDirection.ltr,
                child: PinCodeTextField(
                  appContext: context,
                  pastedTextStyle: const TextStyle(
                    color: textColor2,
                    fontSize: 40,
                    fontWeight: FontWeight.normal,
                  ),
                  length: 5,
                  obscureText: false,
                  obscuringCharacter: '*',
                  textStyle: const TextStyle(
                    color: textColor2,
                    fontSize: 40,
                    fontWeight: FontWeight.normal,
                  ),
                  blinkWhenObscuring: true,
                  boxShadows: const [
                    BoxShadow(
                      offset: Offset(0, 0),
                      blurRadius: 3,
                      spreadRadius: 3,
                      color: Color.fromARGB(25, 0, 0, 0),
                    ),
                  ],
                  animationType: AnimationType.fade,
                  validator: (v) {
                    return null;

                    // if (v.toString().length < 3) {
                    //   return "";
                    // } else {
                    //   return null;
                    // }
                  },
                  pinTheme: PinTheme(
                    fieldOuterPadding: const EdgeInsets.only(left: 2),
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(4),
                    fieldHeight: 78,
                    fieldWidth: 52,
                    borderWidth: 0,
                    inactiveColor: Colors.white,
                    inactiveFillColor: Colors.white,
                    selectedFillColor: const Color(0xFFE2E2E2),
                    activeFillColor: Colors.white,
                  ),
                  cursorColor: Colors.black,
                  animationDuration: const Duration(milliseconds: 300),
                  backgroundColor: Colors.white,
                  enableActiveFill: true,
                  keyboardType: TextInputType.number,
                  onCompleted: (v) {},
                  onChanged: (value) {},
                  beforeTextPaste: (text) {
                    return true;
                  },
                ),
              )
            ,sizedHeight(43),

             Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [

                     Texts(
                        title: Strings.reSendCode.tr(),
                        textColor: Colors.grey,
                        fontSize: 14,
                        align: TextAlign.center,
                        weight: FontWeight.bold),
                    Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: const Icon(
                          Icons.arrow_forward,
                          size: 20,
                          color: Colors.grey,
                        ))
                  ],
                ),
            sizedHeight(30),
            state.loginStet==RequestState.loading?LoadingWidget(height: 55, color: buttonsColor)   : ButtonWidget(
                height: 55,
                color: homeColor,
                onPress: () {
                  AuthCubit.get(context).loginUser(userName: widget.phone,context: context);
                },
                child: Texts(
                    title: Strings.continueLogin.tr(),
                    textColor: Colors.white,
                    fontSize: 14,
                    weight: FontWeight.normal,
                    align: TextAlign.center)),



          ],)),
      ),
    );
  },
);

  }
}