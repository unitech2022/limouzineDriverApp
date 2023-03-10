import 'package:dartz/dartz.dart';


import '../../../core/failur/failure.dart';

import '../../entities/user.dart';
import '../../repository/base_auth_repository.dart';

class LoginUseCase{
  final BaseAuthRepository repository;

  LoginUseCase(this.repository);

  Future<Either<Failure, User>> execute({userName,deviceToken,code})async{

    return await repository.login(userName:userName,deviceToken: deviceToken,code: code);
  }
}