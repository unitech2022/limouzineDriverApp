import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:limousine_driver/core/styles/colors.dart';
import 'package:limousine_driver/core/utlis/enums.dart';
import 'package:limousine_driver/core/widgets/loading_widget.dart';
import 'package:limousine_driver/persentaion/controller/trip_cubit/trip_cubit.dart';

import '../../../core/helpers/helper_functions.dart';
import '../../../core/utlis/api_constatns.dart';
import '../../../core/utlis/strings.dart';
import '../../../core/widgets/circle_image_widget.dart';
import '../../../core/widgets/icon_back_button.dart';
import '../../../core/widgets/texts.dart';
import '../../../data/models/group_details.dart';
import '../home_screen/components/container_point_widget.dart';
import '../home_screen/components/drawer_widget.dart';

class GroupDetailsScreen extends StatefulWidget {
  final int groupId;
  const GroupDetailsScreen({super.key, required this.groupId});

  @override
  State<GroupDetailsScreen> createState() => _GroupDetailsScreenState();
}

class _GroupDetailsScreenState extends State<GroupDetailsScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    TripCubit.get(context).getGroupDetails(groupId: widget.groupId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: DrawerWidget(
        scaffoldKey: _scaffoldKey,
      ),
      appBar: AppBar(
        title: Text(Strings.detailsTrip.tr()),
        actions: [
          IconButton(
              onPressed: () {
                _scaffoldKey.currentState!.openDrawer();
              },
              icon: Icon(Icons.menu, color: Colors.white)),
        ],
        leading: IconBackButton(),
      ),
      body: BlocBuilder<TripCubit, TripState>(builder: (context, state) {
        return state.getGroupDetailsState == RequestState.loading
            ? Center(child: LoadingWidget(height: 55, color: homeColor))
            : SingleChildScrollView(
                child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Texts(
                            title: Strings.peopls,
                            textColor: homeColor,
                            fontSize: 25,
                            weight: FontWeight.bold,
                            align: TextAlign.right),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    GridView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount:
                            state.groupDetails!.groupLocationResponses.length,
                        gridDelegate:
                            const SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 300,
                                childAspectRatio: 2 / 2,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10),
                        itemBuilder: (ctx, index) {
                          GroupLocationResponses groupLocationResponse =
                              state.groupDetails!.groupLocationResponses[index];
                          return Card(
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            child: Container(
                              padding: EdgeInsets.all(20),
                              child: Column(
                                children: [
                                  CircleImageWidget(
                                      height: 70,
                                      width: 70,
                                      image: ApiConstants.imageUrl(
                                          groupLocationResponse.userDetail
                                                      .profileImage !=
                                                  null
                                              ? groupLocationResponse
                                                  .userDetail.profileImage
                                              : "")),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Texts(
                                      title: groupLocationResponse
                                          .userDetail.fullName!,
                                      textColor: Colors.black,
                                      fontSize: 16,
                                      weight: FontWeight.normal,
                                      align: TextAlign.right),
                                ],
                              ),
                            ),
                          );
                        }),
                    SizedBox(
                      height: 25,
                    ),
                    Row(
                      children: [
                        Texts(
                            title: Strings.detailsTrip,
                            textColor: homeColor,
                            fontSize: 25,
                            weight: FontWeight.bold,
                            align: TextAlign.right),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: .8),
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white,
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 15,
                          ),
                          sizedHeight(15),
                          ContainerPointWidget(
                            color: buttonsColor,
                            width: 16,
                            label: Strings.startPoint.tr(),
                            value: state.groupDetails!.group.startCity,
                          ),
                          sizedHeight(15),
                          ContainerPointWidget(
                            width: 16,
                            color: Color(0xff88D55F),
                            label: Strings.endPoint.tr(),
                            value: state.groupDetails!.group.endCity,
                          ),
                          sizedHeight(10),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
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
                                  title: state.groupDetails!.group.peoples
                                      .toString(),
                                  textColor: Colors.black,
                                  fontSize: 16,
                                  weight: FontWeight.normal,
                                  align: TextAlign.right),
                            ],
                          ),
                          sizedHeight(10),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
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
                                  title: state.groupDetails!.group.price
                                      .toString(),
                                  textColor: Colors.black,
                                  fontSize: 16,
                                  weight: FontWeight.normal,
                                  align: TextAlign.right),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    state.groupDetails!.group.status == 0
                        ? state.acceptGroupState == RequestState.loading
                            ? LoadingWidget(height: 42, color: homeColor)
                            : SizedBox(
                                width: double.infinity,
                                child: MaterialButton(
                                    color: homeColor,
                                    child: Texts(
                                        title: Strings.acceptTrip.tr(),
                                        textColor: Colors.white,
                                        fontSize: 14,
                                        weight: FontWeight.normal,
                                        align: TextAlign.center),
                                    height: 42,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                    ),
                                    onPressed: () {
                                      print("object");
                                      TripCubit.get(context).acceptTrip(
                                          groupId: state.groupDetails!.group.id,
                                          status: 1,context:context);
                                    }),
                              )
                        : SizedBox()
                  ],
                ),
              ));
      }),
    );
  }
}
