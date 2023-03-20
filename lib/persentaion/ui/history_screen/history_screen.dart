import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:limousine_driver/core/helpers/helper_functions.dart';
import 'package:limousine_driver/core/routers/routers.dart';
import 'package:limousine_driver/core/styles/colors.dart';
import 'package:limousine_driver/data/models/history_response.dart';

import '../../../core/utlis/enums.dart';
import '../../../core/utlis/strings.dart';
import '../../../core/widgets/loading_widget.dart';
import '../../../core/widgets/texts.dart';
import '../../controller/trip_cubit/trip_cubit.dart';
import '../home_screen/components/app_bar_home.dart';
import '../home_screen/components/container_details_trip.dart';
import '../home_screen/components/container_point_widget.dart';
import '../home_screen/components/drawer_widget.dart';

class HistoryScreen extends StatefulWidget {
  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  int index = 1;
  @override
  void initState() {
    super.initState();
    TripCubit.get(context).getHistoriesTrips();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TripCubit, TripState>(
      builder: (context, state) {
        return Scaffold(
          key: _scaffoldKey,
          drawer: DrawerWidget(
            scaffoldKey: _scaffoldKey,
          ),
          appBar: PreferredSize(
              preferredSize: Size.fromHeight(50.0),
              child: AppBarHome(
                title: Strings.history,
                onTap: () {
                  _scaffoldKey.currentState!.openDrawer();
                },
                child: Container(
                  margin: EdgeInsets.all(12),
                  height: 16,
                  width: 26,
                  child: SvgPicture.asset(
                    "assets/icons/login.svg",
                    color: Colors.white,
                    height: 16,
                    width: 26,
                  ),
                ),
              )),
          body: state.getHistoriesState == RequestState.loading
              ? Center(child: LoadingWidget(height: 55, color: homeColor))
              : Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 27),
                  child: Column(children: [
                    // tabs
                    Container(
                      height: 56,
                      decoration: BoxDecoration(
                          color: Color(0xffF7F7F7),
                          border: Border.all(
                            width: 1,
                            color: Color(0xffF7F7F7),
                          ),
                          borderRadius: BorderRadius.circular(25)),
                      child: Row(
                        children: [
                          // TabHistoryWidget(
                          //   title: Strings.coming,
                          //   textColor1: index == 0 ? Colors.white : homeColor,
                          //   containerColor: index == 0 ? homeColor : Colors.transparent,
                          //   onTap: () {},
                          // ),

                          TabHistoryWidget(
                            title: Strings.done,
                            textColor1: index == 1 ? Colors.white : homeColor,
                            containerColor:
                                index == 1 ? homeColor : Colors.transparent,
                            onTap: () {
                              setState(() {
                                index = 1;
                              });
                            },
                          ),
                          TabHistoryWidget(
                            title: Strings.canceled,
                            textColor1: index == 2 ? Colors.white : homeColor,
                            containerColor:
                                index == 2 ? homeColor : Colors.transparent,
                            onTap: () {
                             setState(() {
                                index = 2;
                             });
                            },
                          ),
                        ],
                      ),
                    ),
                    sizedHeight(18)
                    // list Of history
                    ,
                    Expanded(
                      child: index == 1 ? DoneTripsList(
                        status: 1,list: state.histories!.doneTrips!,
                      ) : DoneTripsList(status: 2,list: state.histories!.canceledTrips!,),
                    )
                  ]),
                ),
        );
      },
    );
  }
}

class DoneTripsList extends StatelessWidget {
  final List<HistoryModel> list;
  final int status;

  DoneTripsList({required this.list, required this.status});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) {
          HistoryModel historyModel = list[index];
          return ItemListHistory(historyModel,status);
        });
  }
}

class ItemListHistory extends StatelessWidget {
 final HistoryModel historyModel;
  final int status;
  const ItemListHistory(this.historyModel,this.status);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14),
      margin: EdgeInsets.only(bottom: 13),
      decoration: BoxDecoration(
          color:status==1? Color(0xffFFF9EC):Color.fromARGB(255, 242, 221, 227), borderRadius: BorderRadius.circular(8)),
      child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SvgPicture.asset("assets/icons/airport.svg"),
            sizedWidth(13),
            Expanded(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Texts(
                          title: "طلب رقم : ${historyModel.trip!.id}",
                          textColor: Color(0xffA5A5A5),
                          fontSize: 12,
                          weight: FontWeight.bold,
                          align: TextAlign.start),
                      Texts(
                          title:historyModel.trip!.createdAt.split("T")[0],
                          textColor: Colors.black,
                          fontSize: 12,
                          weight: FontWeight.bold,
                          align: TextAlign.start)
                    ],
                  ),
                  sizedHeight(3),
                  Divider(
                    height: .8,
                  ),
                  ContainerDetailsTrip(
                    icon: "assets/icons/wallet.svg",
                    label: Strings.cost,
                    textColor: Colors.black,
                    value1: historyModel.trip!.price.toString(),
                    value2: "ر.س",
                    value3: "كاش",
                  ),
                  ContainerDetailsTrip(
                    icon: "assets/icons/history_home.svg",
                    label: Strings.timeTrip,
                    textColor: Colors.black,
                    value1: "45",
                    value2: "دقيقة",
                    value3: "12  كم",
                  ),
                  sizedHeight(12),
                  ContainerStartingPointWidget(
                    value:
                       historyModel.trip!.startAddress,
                    label: Strings.startPoint,
                    color: buttonsColor,
                  ),
                  sizedHeight(15),
                  ContainerStartingPointWidget(
                    value:
                         historyModel.trip!.endAddress,
                    label: Strings.endPoint,
                    color: Color(0xff88D55F),
                  ),
                ],
              ),
            ),
          ],
        ),
      ]),
    );
  }
}

class ContainerStartingPointWidget extends StatelessWidget {
  final String label, value;
  final Color color;

  ContainerStartingPointWidget(
      {required this.label, required this.color, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 12,
          width: 12,
          decoration: BoxDecoration(shape: BoxShape.circle, color: color),
        ),
        sizedWidth(10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Texts(
                  title: label,
                  textColor: Colors.black,
                  fontSize: 10,
                  weight: FontWeight.w800,
                  align: TextAlign.start),
              Texts(
                  title: value,
                  textColor: Color(0xffA5A5A5),
                  fontSize: 10,
                  weight: FontWeight.normal,
                  align: TextAlign.start),
            ],
          ),
        ),
      ],
    );
  }
}

class TabHistoryWidget extends StatelessWidget {
  final Color textColor1;
  final Color containerColor;
  final String title;
  final void Function() onTap;

  TabHistoryWidget(
      {required this.textColor1,
      required this.containerColor,
      required this.onTap,
      required this.title});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: containerColor,
            borderRadius: BorderRadius.circular(25),
          ),
          child: Center(
            child: Texts(
                title: title,
                textColor: textColor1,
                fontSize: 18,
                weight: FontWeight.normal,
                align: TextAlign.center),
          ),
        ),
      ),
    );
  }
}
