import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:limousine_driver/core/utlis/app_model.dart';

import 'package:limousine_driver/data/models/city_model.dart';
import 'package:limousine_driver/data/models/external_trip.dart';
import 'package:limousine_driver/persentaion/ui/map_screen/map_screen.dart';

import '../../../core/helpers/functions.dart';
import '../../../core/helpers/helper_functions.dart';
import '../../../core/styles/colors.dart';
import '../../../core/utlis/enums.dart';
import '../../../core/utlis/strings.dart';

import '../../../core/widgets/circle_image_widget.dart';
import '../../../core/widgets/loading_widget.dart';
import '../../../data/models/address_model.dart';
import '../../controller/trip_cubit/trip_cubit.dart';
import '../home_screen/components/drawer_widget.dart';

class AddExternalTripScreen extends StatefulWidget {
  ExternalTrip? externalTrip;
  final int type; //  0 =  add  , 1 = update
  AddExternalTripScreen({super.key, this.externalTrip, required this.type});

  @override
  State<AddExternalTripScreen> createState() => _AddExternalTripScreenState();
}

class _AddExternalTripScreenState extends State<AddExternalTripScreen> {
  final _controllerName = TextEditingController();
  final _controllerPrice = TextEditingController();
  final _controllerSets = TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  double startLat = 0.0;
  double endLat = 0.0;
  double starLng = 0.0;
  double endLng = 0.0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.type == 1) {
      City startCity = cities.firstWhere(
          (element) => element.name == widget.externalTrip!.startCity);

      City endCity = cities.firstWhere(
          (element) => element.name == widget.externalTrip!.endCity);
      TripCubit.get(context).setCityPoint(startCity, 'start');
      TripCubit.get(context).setCityPoint(endCity, 'end');
      startLat = widget.externalTrip!.startPointLat;
      endLat = widget.externalTrip!.endPointLat;

      starLng = widget.externalTrip!.startPointLng;
      endLng = widget.externalTrip!.endPointLng;
      AddressModel startAddress =
          AddressModel(label: "start", lang: starLng, lat: startLat);
      AddressModel endAddress =
          AddressModel(label: "end", lang: endLng, lat: endLat);

      TripCubit.get(context)
          .getStartLocation(startAddress, type: 0, context: context);
      TripCubit.get(context)
          .getStartLocation(endAddress, type: 1, context: context);

      // TripCubit.get(context).setTimeTrip(widget.externalTrip!.startingAt, 0);
      // TripCubit.get(context).setTimeTrip(widget.externalTrip!.endTime, 1);
      TripCubit.get(context)
          .getStartLocation(endAddress, type: 1, context: context);

      _controllerName.text = widget.externalTrip!.name;
      _controllerPrice.text = widget.externalTrip!.price.toString();
      _controllerSets.text = widget.externalTrip!.sets.toString();
    }
  }

  @override
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();
    _controllerName.dispose();
    _controllerPrice.dispose();
    _controllerSets.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: DrawerWidget(
        scaffoldKey: _scaffoldKey,
      ),
      appBar: AppBar(
        backgroundColor: Color(0xffEAEB15),
        title: Text(Strings.tripExternal.tr(),
            style: TextStyle(color: Colors.black)),
        leading: IconButton(
            onPressed: () {
              pop(context);
            },
            icon: Icon(Icons.arrow_back, color: Colors.black)),
      ),
      body: BlocBuilder<TripCubit, TripState>(
        builder: (context, state) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 20, left: 20, right: 20, bottom: 20),
              child: Column(
                children: [
                  TitleField(
                    title: "عنوان الرحلة".tr(),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    height: 70,
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color: const Color(0xffffffff),
                      border: Border.all(
                          width: 1.0, color: const Color(0x63707070)),
                    ),
                    child: Center(
                      child: TextField(
                        controller: _controllerName,
                        keyboardType: TextInputType.text,
                        cursorColor: Colors.grey,
                        decoration: InputDecoration(
                            counterText: "",
                            hintStyle: TextStyle(fontSize: 14),
                            isDense: true,
                            hintText: "عنوان الرحلة".tr(),
                            border: InputBorder.none),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: Column(
                        children: [
                          TitleField(
                            title: "محطة الذهاب".tr(),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          ContainerSelectCity(
                            icon: Icons.arrow_drop_down_rounded,
                            onTap: () {
                              TripCubit.get(context).filteredList = cities;
                              showCitySheet(type: "start");
                            },
                            value: state.startCity != null
                                ? (AppModel.lang == "ar"
                                    ? state.startCity!.name!
                                    : state.startCity!.name_eng!)
                                : "اختار".tr(),
                          ),
                        ],
                      )),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                          child: Column(
                        children: [
                          TitleField(
                            title: "محطة الوصول".tr(),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          ContainerSelectCity(
                            icon: Icons.arrow_drop_down_rounded,
                            onTap: () {
                              TripCubit.get(context).filteredList = cities;
                              showCitySheet(type: "end");
                            },
                            value: state.endCity != null
                                ? (AppModel.lang == "ar"
                                    ? state.endCity!.name!
                                    : state.endCity!.name_eng!)
                                : "اختار".tr(),
                          )
                        ],
                      ))
                    ],
                  ),

                  /// *** time trip
                  SizedBox(
                    height: 25,
                  ),

                  TitleField(
                    title: "وقت  الذهاب".tr(),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  GestureDetector(
                    onTap: () {
                      showDateTimePicker2(context, onConfirm: (dateTime) {
                        final date =
                            DateFormat('dd-MM-yyyy  HH:mm a').format(dateTime);
                        print(date);
                        TripCubit.get(context).setTimeTrip(date.toString(), 0);
                        pop(context);
                      });
                    },
                    child: Container(
                      height: 70,
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        color: const Color(0xffffffff),
                        border: Border.all(
                            width: 1.0, color: const Color(0x63707070)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                              child: Text(
                            state.dateTrip != null
                                ? state.dateTrip!
                                : "حدد وقت الذهاب".tr(),
                            style: TextStyle(
                              fontFamily: 'Segoe UI',
                              fontSize: 18,
                              color: state.dateTrip != null
                                  ? const Color(0xff000000)
                                  : Color(0xff959595),
                              fontWeight: FontWeight.w700,
                            ),
                            textAlign: TextAlign.start,
                          )),
                          Image.asset("assets/images/clock.png")
                        ],
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 25,
                  ),

                  TitleField(
                    title: "وقت  الوصول".tr(),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  GestureDetector(
                    onTap: () {
                      showDateTimePicker2(context, onConfirm: (dateTime) {
                        final date =
                            DateFormat('dd-MM-yyyy  HH:mm a')
                                .format(dateTime);
                        TripCubit.get(context).setTimeTrip(date.toString(), 1);

                        print(dateTime);
                        pop(context);
                      });
                      // showDateTimePicker(
                      //     context: context,
                      //     onConfirm: (dateTime, List<int> index) {
                      //       // final date =
                      //       //     DateFormat('dd-MM-yyyy  HH:mm a', AppModel.lang)
                      //       //         .format(dateTime);
                      //       TripCubit.get(context)
                      //           .setTimeTrip(dateTime, 1);
                      //     });
                    },
                    child: Container(
                      height: 70,
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        color: const Color(0xffffffff),
                        border: Border.all(
                            width: 1.0, color: const Color(0x63707070)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                              child: Text(
                            state.endDateTrip != null
                                ? state.endDateTrip!
                                : "حدد وقت الوصول".tr(),
                            style: TextStyle(
                              fontFamily: 'Segoe UI',
                              fontSize: 18,
                              color: state.dateTrip != null
                                  ? const Color(0xff000000)
                                  : Color(0xff959595),
                              fontWeight: FontWeight.w700,
                            ),
                            textAlign: TextAlign.start,
                          )),
                          Image.asset("assets/images/clock.png")
                        ],
                      ),
                    ),
                  )

                  // ContainerSelectCity(
                  //   icon: Icons.add_alarm_rounded,
                  //   onTap: () {

                  //   },
                  //   value: ,

//*
                  //* Select Location Map */

                  ,
                  SizedBox(
                    height: 25,
                  ),
                  TitleField(
                    title: "الموقع".tr(),
                  ),
                  SizedBox(
                    height: 37,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            height: 91,
                            width: 91,
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.grey, width: 1),
                                shape: BoxShape.circle),
                                child:  CircleImageWidget(
                            height: 90,
                            width: 90,
                            icon: Icons.location_on_outlined,
                            image:state.startPoint!=null?
                                "https://maps.googleapis.com/maps/api/staticmap?zoom=18&size=600x300&maptype=roadmap&markers=${state.startPoint!.lat},${state.startPoint!.lang}&key=AIzaSyDFZhFfswZpcjeUDYm6C7H46JLdSonK0f4":"not",
                          ),
                                                
                          ),
                          SizedBox(
                            height: 19,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                // Create the SelectionScreen in the next step.
                                MaterialPageRoute(
                                    builder: (context) => MapScreen()),
                              ).then((value) {
                                TripCubit.get(context).getStartLocation(
                                    value as AddressModel,
                                    type: 0);
                              });
                            },
                            child: Container(
                              height: 25,
                              width: 80,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: const Color(0xff1485f6),
                                borderRadius: BorderRadius.circular(23.0),
                              ),
                              child: Center(
                                child: Text(
                                  'الذهاب'.tr(),
                                  style: TextStyle(
                                      fontFamily: 'Segoe UI',
                                      fontSize: 16,
                                      color: const Color(0xffffffff),
                                      height: 1.2),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                        ],
                      )),
                      Expanded(
                          child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            height: 91,
                            width: 91,
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.grey, width: 1),
                                shape: BoxShape.circle),
                                child:  CircleImageWidget(
                            height: 90,
                            width: 90,
                            icon: Icons.location_on_outlined,
                            image:state.endPoint!=null?
                                "https://maps.googleapis.com/maps/api/staticmap?zoom=18&size=600x300&maptype=roadmap&markers=${state.endPoint!.lat},${state.endPoint!.lang}&key=AIzaSyDFZhFfswZpcjeUDYm6C7H46JLdSonK0f4":"not",
                          ),
                                                
                          
                          ),
                          
                          SizedBox(
                            height: 19,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                // Create the SelectionScreen in the next step.
                                MaterialPageRoute(
                                    builder: (context) => MapScreen()),
                              ).then((value) {
                                TripCubit.get(context).getStartLocation(
                                    value as AddressModel,
                                    type: 1);
                              });
                            },
                            child: Container(
                              height: 25,
                              width: 80,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(23.0),
                              ),
                              child: Center(
                                child: Text(
                                  'الوصول'.tr(),
                                  style: TextStyle(
                                      fontFamily: 'Segoe UI',
                                      fontSize: 16,
                                      color: const Color(0xffffffff),
                                      height: 1.2),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ))
                    ],
                  ),

//**=============== */

                  // )

                  //  ** add sets

                  SizedBox(
                    height: 25,
                  ),

                  TitleField(
                    title: "عدد الأشخاص".tr(),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    height: 70,
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                        color: const Color(0xffffffff),
                        border: Border.all(
                            width: 1.0, color: const Color(0x63707070))),
                    child: Center(
                      child: TextField(
                        controller: _controllerSets,
                        keyboardType: TextInputType.number,
                        cursorColor: Colors.grey,
                        decoration: InputDecoration(
                            counterText: "",
                            hintStyle: TextStyle(fontSize: 14),
                            isDense: true,
                            hintText: "اكتب عدد الأشخاص".tr(),
                            border: InputBorder.none),
                      ),
                    ),
                  ),

                  //  ** add price
                  SizedBox(
                    height: 25,
                  ),

                  TitleField(
                    title: "السعر لكل راكب".tr(),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    height: 70,
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                        color: const Color(0xffffffff),
                        border: Border.all(
                            width: 1.0, color: const Color(0x63707070))),
                    child: Center(
                      child: TextField(
                        controller: _controllerPrice,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r"[0-9.]")),
                          TextInputFormatter.withFunction((oldValue, newValue) {
                            try {
                              final text = newValue.text;
                              if (text.isNotEmpty) double.parse(text);
                              return newValue;
                            } catch (e) {}
                            return oldValue;
                          }),
                        ],
                        cursorColor: Colors.grey,
                        decoration: InputDecoration(
                            counterText: "",
                            hintStyle: TextStyle(fontSize: 14),
                            isDense: true,
                            hintText: "اكتب السعر لكل راكب".tr(),
                            border: InputBorder.none),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 35,
                  ),
                  state.addExternalTripState == RequestState.loading ||
                          state.updateExternalTripState == RequestState.loading
                      ? LoadingWidget(height: 42, color: homeColor)
                      : SizedBox(
                          width: double.infinity,
                          child: MaterialButton(
                              color: Color(0xffEAEB15),
                              elevation: 15,
                              child: Text(
                                widget.type == 0
                                    ? "إضافة الرحلة".tr()
                                    : "تعديل الرحلة".tr(),
                                style: TextStyle(
                                  fontFamily: 'Segoe UI',
                                  fontSize: 20,
                                  color: const Color(0xff000000),
                                  fontWeight: FontWeight.w700,
                                ),
                                textAlign: TextAlign.right,
                              ),
                              height: 55,
                              onPressed: () {
                                print("object");
                                if (validateGroup(state)) {
                                  if (widget.type == 0) {
                                    TripCubit.get(context).addExternalTrip(
                                        price: _controllerPrice.text,
                                        sets: _controllerSets.text,
                                        name: _controllerName.text,
                                        cityStart: state.startCity!.name,
                                        cityEnd: state.endCity!.name,
                                        startLat: state.startPoint!.lat,
                                        startLng: state.startPoint!.lang,
                                        endLat: state.endPoint!.lat,
                                        endLng: state.endPoint!.lang,
                                        date: state.dateTrip,
                                        endTirpTime: state.endDateTrip,
                                        context: context);
                                  } else {
                                    // print(_controllerName.text);
                                    TripCubit.get(context).updateExternalTrip(
                                        price: _controllerPrice.text,
                                        sets: _controllerSets.text,
                                        name: _controllerName.text,
                                        cityStart: state.startCity!.name,
                                        cityEnd: state.endCity!.name,
                                        startLat: state.startPoint!.lat,
                                        startLng: state.startPoint!.lang,
                                        endLat: state.endPoint!.lat,
                                        endLng: state.endPoint!.lang,
                                        date: state.dateTrip,
                                        endTirpTime: state.endDateTrip,
                                        id: widget.externalTrip!.id,
                                        context: context);
                                  }
                                }
                              })),
                  SizedBox(
                    height: 35,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // SHOW CITIES
  showCitySheet({type}) => showModalBottomSheet(
      context: context,
      builder: (context) {
        return BlocBuilder<TripCubit, TripState>(builder: (context, stat) {
          return Container(
              // height: 300,

              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30))),
              padding: const EdgeInsets.all(20),
              child: ListView.separated(
                separatorBuilder: (BuildContext context, int index) {
                  return const Divider();
                },
                itemBuilder: (ctx, i) => i == 0
                    ? Row(
                        children: [
                          IconButton(
                              onPressed: () {
                                pop(context);
                              },
                              icon: const Icon(Icons.arrow_back)),
                          Expanded(
                            child: TextFormField(
                              onChanged: (v) {
                                TripCubit.get(context).searchCity(v.toString());
                              },
                              keyboardType: TextInputType.text,
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 18),
                              decoration: InputDecoration(
                                  isDense: true,
                                  //to reduce the size of icon, use if you want. I used, because my custom font icon is big
                                  labelText: "ابحث باسم المدينة".tr(),
                                  contentPadding: EdgeInsets.only(left: 0),
                                  //to make the base line of icon & text in same
                                  labelStyle: TextStyle(color: Colors.grey),
                                  prefixIcon: Icon(Icons.search)),
                            ),
                          ),
                        ],
                      )
                    : GestureDetector(
                        onTap: () {
                          pop(context);
                          TripCubit.get(context).setCityPoint(
                              TripCubit.get(context).filteredList[i - 1], type);
                        },
                        child: Container(
                          height: 50,
                          color: Colors.white,
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              // Icon(Icons.point)
                              const SizedBox(
                                width: 10,
                              ),
                              const SizedBox(
                                width: 10,
                              ),

                              Text(
                                AppModel.lang == "ar"
                                    ? TripCubit.get(context)
                                        .filteredList[i - 1]
                                        .name!
                                    : TripCubit.get(context)
                                        .filteredList[i - 1]
                                        .name_eng!,
                                style: const TextStyle(
                                  fontSize: 18.0,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  height: 1.92,
                                ),
                                textAlign: TextAlign.right,
                              ),
                            ],
                          ),
                        ),
                      ),
                itemCount: TripCubit.get(context).filteredList.length + 1,
              ));
        });
      });

  bool validateGroup(TripState state) {
    if (_controllerName.text.isEmpty) {
      showSnakeBar(message: "اكتب عنوان الرحلة".tr(), context: context);
      return false;
    } else if (state.startCity == null) {
      showSnakeBar(message: "اختار قرية البداية".tr(), context: context);
      return false;
    } else if (state.endCity == null) {
      showSnakeBar(message: "اختار قرية الوصول".tr(), context: context);
      return false;
    } else if (state.startPoint == null) {
      showSnakeBar(message: "اختار موقع الذهاب".tr(), context: context);
      return false;
    } else if (state.endPoint == null) {
      showSnakeBar(message: "اختار موقع الوصول".tr(), context: context);
      return false;
    } else if (state.dateTrip == null) {
      showSnakeBar(message: "اختار وقت الذهاب".tr(), context: context);
      return false;
    }  else if (state.endDateTrip == null) {
      showSnakeBar(message: "اختار وقت الوصول".tr(), context: context);
      return false;
    } 
    else if (_controllerSets.text.isEmpty) {
      showSnakeBar(message: "اكتب عدد الأشخاص".tr(), context: context);
      return false;
    } else if (_controllerPrice.text.isEmpty) {
      showSnakeBar(message: "اكتب السعر لكل شخص".tr(), context: context);
      return false;
    } else {
      return true;
    }
  }
}

class TitleField extends StatelessWidget {
  final String title;
  const TitleField({required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: TextStyle(
            fontFamily: 'Segoe UI',
            fontSize: 20,
            color: const Color(0xff000000),
            fontWeight: FontWeight.w700,
          ),
          textAlign: TextAlign.right,
        )
      ],
    );
  }
}

class ContainerSelectCity extends StatelessWidget {
  final void Function() onTap;
  final String value;
  final IconData icon;

  const ContainerSelectCity(
      {super.key,
      required this.onTap,
      required this.value,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 70,
        padding: EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: const Color(0xffffffff),
          border: Border.all(width: 1.0, color: const Color(0x63707070)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                child: Text(
              value,
              style: TextStyle(
                fontFamily: 'Segoe UI',
                fontSize: 18,
                color: const Color(0xff000000),
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.right,
            )),
            Icon(icon)
          ],
        ),
      ),
    );
  }
}
