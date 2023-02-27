part of 'app_cubit.dart';

class AppState extends Equatable {
  final String changLang;
 final String page;
  AppState({ this.changLang="",this.page=""});
  @override
  List<Object> get props => [changLang,page];
}
