import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:limousine_driver/persentaion/ui/group_details_screen/group_details_screen.dart';

import '../../../core/helpers/helper_functions.dart';
import '../../../core/styles/colors.dart';

import '../../../core/utlis/enums.dart';
import '../../../core/utlis/strings.dart';
import '../../../core/widgets/icon_back_button.dart';
import '../../../core/widgets/loading_widget.dart';
import '../../../core/widgets/texts.dart';
import '../../../data/models/group.dart';
import '../../controller/trip_cubit/trip_cubit.dart';
import '../home_screen/components/container_point_widget.dart';
import '../home_screen/components/drawer_widget.dart';

import '../notifications_screen/notifications_screen.dart';

class MyGroupsScreen extends StatefulWidget {
  MyGroupsScreen({super.key});

  @override
  State<MyGroupsScreen> createState() => _MyGroupsScreenState();
}

class _MyGroupsScreenState extends State<MyGroupsScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    TripCubit.get(context).getGroups();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: DrawerWidget(
        scaffoldKey: _scaffoldKey,
      ),
      appBar: AppBar(
        title: Text(Strings.tripExternal.tr()),
        actions: [
          IconButton(
              onPressed: () {
                _scaffoldKey.currentState!.openDrawer();
              },
              icon: Icon(Icons.menu, color: Colors.white)),
        ],
        leading: IconBackButton(),
      ),
      body: BlocBuilder<TripCubit, TripState>(
        builder: (context, state) {
          return state.getGroupsState == RequestState.loading
              ? Center(
                  child: LoadingWidget(height: 55, color: homeColor),
                )
              : state.groupsLocation.isEmpty
                  ? ListEmptyWidget(
                      textColor: homeColor, title: Strings.notTrips.tr())
                  : ListView.builder(
                      itemCount: state.groupsLocation.length,
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      itemBuilder: (ctx, index) {
                        Group group = state.groupsLocation[index];
                        return GestureDetector(
                          onTap: () {
                            pushPage(context: context, page: GroupDetailsScreen(groupId: group.id));
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Card(
                              elevation: 10,
                               shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              child: Container(
                                
                                  padding: EdgeInsets.all(20),
                                 
                                  child: Column(
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Texts(
                                              title: Strings.numberTrip.tr(),
                                              textColor: Colors.black,
                                              fontSize: 16,
                                              weight: FontWeight.normal,
                                              align: TextAlign.right),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Texts(
                                              title: group.id.toString(),
                                              textColor: Colors.black,
                                              fontSize: 16,
                                              weight: FontWeight.normal,
                                              align: TextAlign.right),
                                          Spacer(),
                                          Texts(
                                              title: group.createdAt.split("T")[0],
                                              textColor: Colors.black54,
                                              fontSize: 16,
                                              weight: FontWeight.normal,
                                              align: TextAlign.right),
                                        ],
                                      ),
                            
                                      // starting point
                            
                                      sizedHeight(15),
                                      ContainerPointWidget(
                                        color: buttonsColor,
                                          width: 16,
                                        label: Strings.startPoint.tr(),
                                        value: group.startCity,
                                      ),
                                      sizedHeight(15),
                                      ContainerPointWidget(
                                          width: 16,
                                        color: Color(0xff88D55F),
                                        label: Strings.endPoint.tr(),
                                        value: group.endCity,
                                      ),
                                      sizedHeight(10),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Texts(
                                              title: Strings.numberPeoplesTrip.tr(),
                                              textColor: Colors.black,
                                              fontSize: 16,
                                              weight: FontWeight.normal,
                                              align: TextAlign.right),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Texts(
                                              title: group.peoples.toString(),
                                              textColor: Colors.black,
                                              fontSize: 16,
                                              weight: FontWeight.normal,
                                              align: TextAlign.right),
                                        ],
                                      ),
                                      sizedHeight(10),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Texts(
                                              title: Strings.cost.tr(),
                                              textColor: Colors.black,
                                              fontSize: 16,
                                              weight: FontWeight.normal,
                                              align: TextAlign.right),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Texts(
                                              title: " : ",
                                              textColor: Colors.black,
                                              fontSize: 16,
                                              weight: FontWeight.normal,
                                              align: TextAlign.right),
                                          Texts(
                                              title: group.price.toString(),
                                              textColor: Colors.black,
                                              fontSize: 16,
                                              weight: FontWeight.normal,
                                              align: TextAlign.right),
                                        ],
                                      ),
                                    ],
                                  )),
                            ),
                          ),
                        );
                      });
        },
      ),
    );
  }
}

List<String> statusTrip = [
  "جارى البحث عن سائق",
  "تم قبول الرحلة",
  "رحلة منتهية",
  "تم الغاء الرحلة"
];
List<Color> statusTripColor = [
  Colors.orange,
  Colors.green,
  Colors.grey,
  Colors.red
];
