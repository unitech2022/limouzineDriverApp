import 'package:limousine_driver/data/models/driver_model.dart';
import 'package:limousine_driver/data/models/user_response.dart';
import 'package:limousine_driver/data/models/wallet.dart';
import 'package:limousine_driver/domin/entities/driver.dart';

class WalletResponse {
  final UserDetail user;
  final List<Wallet> wallets;
  final Driver driver;
  WalletResponse( {required this.driver,required this.user, required this.wallets});

  factory WalletResponse.fromJson(Map<String, dynamic> json) => WalletResponse(
     driver: DriverModel.fromJson(json['driver']),
      user: UserDetail.fromJson(json['user']),
      wallets: List<Wallet>.from(
          (json['wallets'] as List).map((e) => Wallet.fromJson(e))));
}
