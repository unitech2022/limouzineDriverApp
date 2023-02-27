import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:limousine_driver/persentaion/controller/auth_cubit/auth_cubit.dart';

import '../../../../../core/helpers/functions.dart';
import '../../../../../core/helpers/helper_functions.dart';
import '../../../../../core/styles/colors.dart';
import '../../../../../core/utlis/api_constatns.dart';
import '../../../../../core/utlis/enums.dart';
import '../../../../../core/utlis/strings.dart';
import '../../../../../core/widgets/circle_image_widget.dart';
import '../../../../../core/widgets/loading_widget.dart';
import '../../../../../core/widgets/text_field_widget.dart';
import '../../../../../core/widgets/texts.dart';
import '../../../../../domin/entities/user.dart';
import '../../../../core/widgets/app_bar_widget.dart';
import '../../../../core/widgets/button_widget.dart';

class RegisterScreen extends StatefulWidget {
  final String phone;

  RegisterScreen(this.phone);
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _controllerUserName = TextEditingController();

  final _controllerPhone = TextEditingController();

  final _controllerEmail = TextEditingController();
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controllerPhone.text=widget.phone.split("+966")[1];
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        return Scaffold(
          appBar:  PreferredSize(
              preferredSize: Size.fromHeight(50.0),
              child: AppBarWidget(
                title: Strings.newAccount.tr(),
              )),


          body: Container(
            color: Colors.white,
            margin:
                const EdgeInsets.only(top: 31, left: 20, right: 20, bottom: 20),
            child: SingleChildScrollView(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 Texts(
                    title: Strings.signUp1.tr(),
                    textColor: textColor,
                    fontSize: 30,
                    align: TextAlign.start,
                    weight: FontWeight.bold),
                 Texts(
                    title: Strings.newAccount.tr(),
                    textColor: textColor,
                    fontSize: 30,
                    align: TextAlign.start,
                    weight: FontWeight.bold),
                sizedHeight(15),
                 Texts(
                    title: Strings.descRegister.tr(),
                    textColor: Color(0xffA5A5A5),
                    fontSize: 14,
                    align: TextAlign.start,
                    weight: FontWeight.bold),
                sizedHeight(35),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 120,
                      width: 120,
                      child: Stack(children: [
                        state.imageStet == RequestState.loading
                            ? LoadingWidget(height: 120, color: buttonsColor)
                            : CircleImageWidget(
                          height: 120,
                          width: 120,
                          image: ApiConstants.imageUrl(state.image),
                        ),
                        Positioned(
                            left: 0,
                            top: 2,
                            child: Container(
                              padding: const EdgeInsets.all(1),
                              decoration: const BoxDecoration(
                                  color: buttonsColor, shape: BoxShape.circle),
                              child: const Icon(
                                Icons.close,
                                color: Colors.white,
                                size: 20,
                              ),
                            )),
                        Positioned(
                            bottom: 0,
                            right: 2,
                            child: GestureDetector(
                              onTap: () {
                                AuthCubit.get(context).uploadImage();
                              },
                              child: SvgPicture.asset(
                                  "assets/icons/upload.svg"),
                            ))
                      ]),
                    ),
                  ],
                ),
                sizedHeight(40),
                TextFieldWidget(
                  hint: Strings.hintName.tr(),
                  suffixIcon: const SizedBox(),
                  prefixIcon: Icons.person,
                  input: TextInputType.text,
                  controller: _controllerUserName,
                ),
                sizedHeight(21),
                TextFieldWidget(
                  hint: Strings.hintEmail.tr(),
                  suffixIcon: SizedBox(),
                  prefixIcon: Icons.email,
                  input: TextInputType.emailAddress,
                  controller: _controllerEmail,
                ),
                sizedHeight(21),
                Container(
                  height: 55,
                  margin: EdgeInsets.symmetric(horizontal: 5),
                  padding: EdgeInsets.symmetric(horizontal: 25),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: const [
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
                                maxLength: 8,
                                decoration: InputDecoration(
                                    counterText: "",
                                    hintStyle: TextStyle(fontSize: 14),
                                    isDense: true,
                                    hintText: Strings.enterNumber.tr(),
                                    border: InputBorder.none),
                              ),
                            )),
                      ),
                      sizedWidth(8),
                    ],
                  ),
                ),
                sizedHeight(43),
                 Texts(
                    title: Strings.acceptPrivacy.tr(),
                    textColor: Color(0xff464646),
                    fontSize: 11,
                    align: TextAlign.start,
                    weight: FontWeight.bold),


                sizedHeight(21),
                state.signUpStet==RequestState.loading?  LoadingWidget(height: 55,color: buttonsColor,):  ButtonWidget(
                    height: 55,
                    color: homeColor,
                    onPress: () {
                      if (isValidate()) {
                        User user = User(
                          isDriver: false,
                            token: "",
                            id: "",
                            email: _controllerEmail.text,
                            fullName: _controllerUserName.text,
                            userName:Strings.codeNumber+_controllerPhone.text,
                            profileImage: state.image,
                            role: "driver",
                            deviceToken: "deviceToken");

                        AuthCubit.get(context).signUpUser(user: user,context: context);
                      }
                    },
                    child:  Texts(
                        title: Strings.continueLogin.tr(),
                        textColor: Colors.white,
                        fontSize: 14,
                        weight: FontWeight.normal,
                        align: TextAlign.center)),

              ],
            )),
          ),
        );
      },
    );
  }

  bool isValidate() {
    if (_controllerUserName.text.isEmpty) {
      showSnakeBar(
          message: Strings.pleasEnterName.tr(),
          context: context
      );
      return false;
    } else if (_controllerEmail.text.isEmpty) {
      showSnakeBar(
          message: Strings.pleasEnterEmail.tr(),
          context: context
      );
      return false;
    } else if (_controllerPhone.text.isEmpty||_controllerPhone.text.length<8) {
      showSnakeBar(
          message: Strings.pleasEnterPhone.tr(),
          context: context
      );
      return false;
    }  else {
      return true;
    }
  }
}