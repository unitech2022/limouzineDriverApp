import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/helpers/functions.dart';
import '../../../../core/routers/routers.dart';
import '../../../../core/utlis/api_constatns.dart';
import '../../../../core/utlis/app_model.dart';


part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppState());
  static AppCubit get(context) => BlocProvider.of<AppCubit>(context);
  changeLang(lang, context)async {

  await  saveData(ApiConstants.langKey, lang);
    // EasyLocalization.of(context)?.setLocale(Locale(lang, ''));

    Navigator.pushNamed(context, welcome);
    emit(AppState(changLang: lang));
  }


  getLang(){
    if(AppModel.lang ==""){
      emit(AppState(changLang: "ar"));
    }else{
      emit(AppState(changLang: AppModel.lang));
    }
  }
  getPage(context) {
    Future.delayed(const Duration(seconds: 3), () {
      print(AppModel.lang);
      if (AppModel.lang == "") {
        Navigator.pushReplacementNamed(context, lang);
      }
      else {
        if(currentUser.token != null){

          Navigator.pushReplacementNamed(context, home);
        }
        else{
          Navigator.pushReplacementNamed(context, welcome);
        }

      }
      emit(AppState(page: "done"));
    });
  }
}
