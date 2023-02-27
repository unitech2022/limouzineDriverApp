import 'package:equatable/equatable.dart';

class User extends Equatable {

  final String token;
  final String id;

  final String fullName;
  final String email;
  final String userName;
  final String profileImage;
  final bool isDriver;
  final String role;

  final String deviceToken;

  User({required this.token,
    required this.id,
    required this.fullName,
    required this.email,
    required this.userName,
    required this.profileImage,
    required this.role,
    required this.isDriver,
    required this.deviceToken});

  @override
  List<Object> get props => [
        token,
        id,
        fullName,
        email,
        userName,
        profileImage,
        role,
        deviceToken,
    isDriver
      ];
}
