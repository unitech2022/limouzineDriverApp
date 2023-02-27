import 'dart:io';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:limousine_driver/persentaion/ui/sign_up_screen/register_screen/register_screen.dart';

import '../../../core/helpers/functions.dart';
import '../../../core/utlis/app_model.dart';
import '../../../core/utlis/enums.dart';
import '../../../domin/entities/response_login.dart';
import '../../../domin/entities/response_signup.dart';
import '../../../domin/entities/user.dart';
import '../../../domin/usese_cases/app_use_case/app_use_case.dart';
import '../../../domin/usese_cases/auth_uses_cases/check_user_name_usecase.dart';
import '../../../domin/usese_cases/auth_uses_cases/login_usecase.dart';
import '../../../domin/usese_cases/auth_uses_cases/signup_usecase.dart';
import '../../ui/home_screen/home_screen.dart';
import '../../ui/sign_up_screen/steps_sign_screens/create_account_driver_screen.dart';
import '../../ui/sign_up_screen/steps_sign_screens/otp_screen/otp_screen.dart';



part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  CheckUerNameUseCase checkUerNameUseCase;
  LoginUseCase loginUseCase;
  SignUpUseCase signUpUseCase;
  AppUseCase appUseCase;

  AuthCubit(this.checkUerNameUseCase, this.loginUseCase, this.signUpUseCase,this.appUseCase)
      : super(AuthState());
  static AuthCubit get(context) => BlocProvider.of<AuthCubit>(context);

  checkUser({userName,context}) async {
    emit( AuthState(checkUserStet: RequestState.loading));
    final result = await checkUerNameUseCase.execute(userName: userName);
    result.fold(
        (l) => emit(AuthState(
            checkUserStet: RequestState.error, checkUserMessage: l.message)),
        (r) {
          print(r.status);
      if (r.status == 0) {
       pushPage(context: context, page: RegisterScreen(userName));
      } else {
        pushPage(context: context, page: OtpScreen(phone :userName));
      }
      emit(AuthState(
            responseLogin: r, checkUserStet: RequestState.loaded));
        });
  }



  loginUser({userName,context}) async {
    emit(state.copyWith(loginStet: RequestState.loading));
    final result = await loginUseCase.execute(userName: userName,code:"0000",deviceToken: "fffffffff");
    result.fold(
        (l) => emit(state.copyWith(
            loginStet: RequestState.error, loginMessage: l.message)),
        (r) async{
          // print(r);

          currentUser..token="Bearer "+r.token;
          currentUser..profileImage=r.profileImage;
          currentUser..userName=r.userName;
          currentUser..id=r.id;
          currentUser..fullName=r.fullName;
          currentUser.deviceToken=r.deviceToken;

          print(currentUser);
         await saveToken();
         if(r.isDriver){
           pushPage(context: context,page: HomeScreen());
         }else{
           pushPage(context: context,page: CreateAccountDriverScreen());
         }


          emit(state.copyWith(user: r, loginStet: RequestState.loaded));
        });
  }

  signUpUser({user,context}) async {
    emit(state.copyWith(signUpStet: RequestState.loading));
    final result = await signUpUseCase.execute(user: user);
    result.fold(
        (l) => emit(state.copyWith(
            signUpStet: RequestState.error, loginMessage: l.message)),
        (r) {
          print(r);
          if(r.status){
            pushPage(context: context,page: OtpScreen(phone: user.userName));
          }else{
            showSnakeBar(
              message: r.message,
              context: context,

            );
          }
          emit(
            state.copyWith(responseSignUp: r, signUpStet: RequestState.loaded));
        });
  }

  uploadImage()async{
    File _image;
    final picker = ImagePicker();

    var _pickedFile = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 50, // <- Reduce Image quality
        maxHeight: 500,  // <- reduce the image size
        maxWidth: 500);

    if(_pickedFile!=null){

      _image =  File(_pickedFile.path); ;

      emit(state.copyWith(imageStet: RequestState.loading));
      final result = await appUseCase.execute(file: _image);
      result.fold(
              (l) => emit(state.copyWith(
                  imageStet: RequestState.error, errorImageMessage: l.message)),
              (r) {
                print(r);
                emit(
              state.copyWith(image: r, imageStet: RequestState.loaded));
              });
    }


  }
}
