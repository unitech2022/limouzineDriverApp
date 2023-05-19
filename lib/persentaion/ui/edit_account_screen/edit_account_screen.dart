import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/helpers/helper_functions.dart';
import '../../../core/styles/colors.dart';
import '../../../core/utlis/api_constatns.dart';
import '../../../core/utlis/enums.dart';
import '../../../core/utlis/strings.dart';
import '../../../core/widgets/buttons.dart';
import '../../../core/widgets/circle_image_widget.dart';
import '../../../core/widgets/loading_widget.dart';
import '../../../core/widgets/texts.dart';
import '../../controller/auth_cubit/auth_cubit.dart';
import '../home_screen/components/app_bar_home.dart';
import '../home_screen/components/drawer_widget.dart';

class EditAccountScreen extends StatefulWidget {
  @override
  State<EditAccountScreen> createState() => _EditAccountScreenState();
}

class _EditAccountScreenState extends State<EditAccountScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final _controllerName = TextEditingController();
  final _controllerEmail = TextEditingController();
  final _controllerPhone = TextEditingController();

  @override
  void initState() {
    super.initState();

    AuthCubit.get(context).getUserDetails().then((value) {
      if (AuthCubit.get(context).userDetail != null) {
        _controllerName.text = AuthCubit.get(context).userDetail!.fullName!;
        _controllerEmail.text = AuthCubit.get(context).userDetail!.email!;
        _controllerPhone.text = AuthCubit.get(context).userDetail!.userName!;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        return Scaffold(
          key: _scaffoldKey,
          drawer: DrawerWidget(
            scaffoldKey: _scaffoldKey,
          ),
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(50.0),
            child: AppBarHome(
              title: Strings.myProfiel.tr(),
              onTap: () {
                _scaffoldKey.currentState!.openDrawer();
              },
              child: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.more_vert,
                    color: Colors.white,
                  )),
            ),
          ),
          body: state.getUserState == RequestState.loading
              ? Center(
                  child: LoadingWidget(height: 40, color: homeColor),
                )
              : Padding(
                  padding: const EdgeInsets.all(25),
                  child: SingleChildScrollView(
                      child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 135,
                            width: 120,
                            child: Stack(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    AuthCubit.get(context).uploadImage();
                                  },
                                  child: Container(
                                    height: 120,
                                    width: 120,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: buttonsColor, width: 3),
                                        shape: BoxShape.circle),
                                    child: state.imageStet ==
                                            RequestState.loading
                                        ? LoadingWidget(
                                            height: 120, color: homeColor)
                                        : CircleImageWidget(
                                            height: 120,
                                            width: 120,
                                            image: state.image == ""
                                                ? ApiConstants.imageUrl(state
                                                    .getUserDetails!
                                                    .profileImage!)
                                                : ApiConstants.imageUrl(
                                                    state.image)),
                                  ),
                                ),
                                Positioned(
                                  bottom: 1,
                                  left: 0,
                                  right: 0,
                                  child: Container(
                                    height: 31,
                                    width: 31,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: buttonsColor),
                                    child: Icon(
                                      Icons.camera_alt_outlined,
                                      size: 17,
                                      color: Colors.white,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      sizedHeight(12),
                      Texts(
                          title: state.getUserDetails!.fullName!,
                          textColor: Colors.black,
                          fontSize: 20,
                          family: "alex_bold",
                          weight: FontWeight.normal,
                          align: TextAlign.start),
                      sizedHeight(19),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Texts(
                                title: Strings.name.tr(),
                                textColor: Color(0xff464646),
                                fontSize: 10,
                                family: "alex_bold",
                                weight: FontWeight.normal,
                                align: TextAlign.start),
                          ),
                        ],
                      ),
                      sizedHeight(4),
                      FieldEditProfileWidget(
                          controller: _controllerName, raduis: 30),
                      sizedHeight(31),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Texts(
                                title: Strings.email.tr(),
                                textColor: Color(0xff464646),
                                fontSize: 10,
                                family: "alex_bold",
                                weight: FontWeight.normal,
                                align: TextAlign.start),
                          ),
                        ],
                      ),
                      sizedHeight(4),
                      FieldEditProfileWidget(
                          controller: _controllerEmail,
                          type: TextInputType.emailAddress,
                          raduis: 30),
                      sizedHeight(31),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Texts(
                                title: Strings.number.tr(),
                                textColor: Color(0xff464646),
                                fontSize: 10,
                                family: "alex_bold",
                                weight: FontWeight.normal,
                                align: TextAlign.start),
                          ),
                        ],
                      ),
                      sizedHeight(4),
                      FieldEditProfileWidget(
                        controller: _controllerPhone,
                        type: TextInputType.number,
                        enabel: false,
                        raduis: 30,
                      ),
                      // sizedHeight(31),
                      // Row(
                      //   children: [
                      //     Padding(
                      //       padding: const EdgeInsets.symmetric(horizontal: 20),
                      //       child: Texts(
                      //           title: Strings.birthday,
                      //           textColor: Color(0xff464646),
                      //           fontSize: 10,
                      //           family: "alex_bold",
                      //           weight: FontWeight.normal,
                      //           align: TextAlign.start),
                      //     ),
                      //   ],
                      // ),
                      // sizedHeight(4),
                      // FieldEditProfileWidget(controller: _controller,
                      //   raduis: 30),
                      // sizedHeight(31),
                      // Row(
                      //   children: [
                      //     Padding(
                      //       padding: const EdgeInsets.symmetric(horizontal: 20),
                      //       child: Texts(
                      //           title: Strings.gender,
                      //           textColor: Color(0xff464646),
                      //           fontSize: 10,
                      //           family: "alex_bold",
                      //           weight: FontWeight.normal,
                      //           align: TextAlign.start),
                      //     ),
                      //   ],
                      // ),
                      // sizedHeight(4),
                      // FieldEditProfileWidget(controller: _controller,
                      //   raduis: 30),
                      // sizedHeight(31),
                      // Row(
                      //   children: [
                      //     Padding(
                      //       padding: const EdgeInsets.symmetric(horizontal: 20),
                      //       child: Texts(
                      //           title: Strings.password,
                      //           textColor: Color(0xff464646),
                      //           fontSize: 10,
                      //           family: "alex_bold",
                      //           weight: FontWeight.normal,
                      //           align: TextAlign.start),
                      //     ),
                      //   ],
                      // ),
                      // sizedHeight(4),
                      // FieldEditProfileWidget(
                      //   controller: _controller,
                      //   type: TextInputType.visiblePassword,
                      //   raduis: 30,
                      // ),

                      sizedHeight(31),
                      // Row(
                      //   children: [
                      //     Padding(
                      //       padding: const EdgeInsets.symmetric(horizontal: 20),
                      //       child: Texts(
                      //           title: Strings.reapat,
                      //           textColor: Color(0xff464646),
                      //           fontSize: 10,
                      //           family: "alex_bold",
                      //           weight: FontWeight.normal,
                      //           align: TextAlign.start),
                      //     ),
                      //   ],
                      // ),
                      // sizedHeight(4),
                      // FieldEditProfileWidget(
                      //   controller: _controller,
                      //   type: TextInputType.visiblePassword,
                      //   raduis: 30,
                      // ),
                      sizedHeight(28),
                      state.updateUserState == RequestState.loading
                          ? LoadingWidget(height: 55, color: buttonsColor)
                          : SizedBox(
                              width: double.infinity,
                              child: Buttons2(
                                onPress: () {
                                  AuthCubit.get(context).updateUser(
                                      fullName: _controllerName.text,
                                      email: _controllerEmail.text,
                                      image: state.image == ""
                                          ? state.getUserDetails!.profileImage!
                                          : state.image);
                                },
                                radus: 10,
                                height: 44,
                                color: homeColor,
                                child: Texts(
                                    title: Strings.save.tr(),
                                    textColor: Colors.white,
                                    fontSize: 14,
                                    weight: FontWeight.normal,
                                    align: TextAlign.center),
                              ),
                            ),
                    ],
                  )),
                ),
        );
      },
    );
  }
}

class FieldEditProfileWidget extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType type;
  final double raduis, height;
  final bool enabel;
  const FieldEditProfileWidget(
      {required this.controller,
      this.type = TextInputType.text,
      required this.raduis,
      this.enabel = true,
      this.height = 40});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 27),
      decoration: BoxDecoration(
        color: Color(0xffF7F7F7),
        borderRadius: BorderRadius.circular(raduis),
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: type,
        enabled: enabel,
        style: TextStyle(color: Color(0xff7C7C7C), fontSize: 16),
        decoration: InputDecoration(
          isDense: true,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
