import 'package:limousine_driver/data/models/user_response.dart';
import 'group.dart';
import 'group_location.dart';

class GroupDetails {
  final Group group;
  final List<GroupLocationResponses> groupLocationResponses;

  GroupDetails({required this.group, required this.groupLocationResponses});

  factory GroupDetails.fromJson(Map<String, dynamic> json) => GroupDetails(
      group: Group.fromJson(json['group']),
      groupLocationResponses: List<GroupLocationResponses>.from(
          (json['groupLocationResponses'] as List)
              .map((e) => GroupLocationResponses.fromJson(e))));
}

class GroupLocationResponses {
  final GroupLocation groupLocation;
  final UserDetail userDetail;

  GroupLocationResponses(
      {required this.groupLocation, required this.userDetail});

  factory GroupLocationResponses.fromJson(Map<String, dynamic> json) =>
      GroupLocationResponses(
          groupLocation: GroupLocation.fromJson(json['groupLocation']),
          userDetail: UserDetail.fromJson(json['userDetail']));
}
