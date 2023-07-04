
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:limousine_driver/persentaion/controller/app_cubit/cubit/app_cubit.dart';
import 'package:limousine_driver/persentaion/controller/auth_cubit/auth_cubit.dart';
import 'package:limousine_driver/persentaion/controller/driver_cubit/driver_cubit.dart';
import 'package:limousine_driver/persentaion/controller/notifictions_cubit/cubit/notifications_cubit.dart';
import 'package:limousine_driver/persentaion/controller/trip_cubit/trip_cubit.dart';
import 'package:limousine_driver/persentaion/ui/badges_screen/badges_screen.dart';
import 'package:limousine_driver/persentaion/ui/chose_lang_screen/chose_screen.dart';
import 'package:limousine_driver/persentaion/ui/edit_account_screen/edit_account_screen.dart';
import 'package:limousine_driver/persentaion/ui/external_details_screen/external_trip_detials_screen.dart';
import 'package:limousine_driver/persentaion/ui/external_trip_screen/add_external_trip_screen.dart';
import 'package:limousine_driver/persentaion/ui/external_trip_screen/external_trip_screen.dart';
import 'package:limousine_driver/persentaion/ui/history_screen/history_screen.dart';
import 'package:limousine_driver/persentaion/ui/home_screen/home_screen.dart';
import 'package:limousine_driver/persentaion/ui/login_screen/login_screen.dart';
import 'package:limousine_driver/persentaion/ui/my_groups_screen/my_groups_screen.dart';
import 'package:limousine_driver/persentaion/ui/notifications_screen/notifications_screen.dart';
import 'package:limousine_driver/persentaion/ui/policy_screen/policy_screen.dart';
import 'package:limousine_driver/persentaion/ui/settings_screen/settings_screen.dart';
import 'package:limousine_driver/persentaion/ui/sign_up_screen/steps_sign_screens/create_account_driver_screen.dart';
import 'package:limousine_driver/persentaion/ui/splash_screen/splash_screen.dart';

import 'package:limousine_driver/persentaion/ui/support_screen/support_screen.dart';
import 'package:limousine_driver/persentaion/ui/trip_screen/trip_screen.dart';
import 'package:limousine_driver/persentaion/ui/welcome_screen/welcome_screen.dart';

import 'core/helpers/functions.dart';
import 'core/routers/routers.dart';
import 'core/services/services_locator.dart';
import 'core/thems/them.dart';
import 'persentaion/ui/account_screen/account_screen.dart';
import 'persentaion/ui/my_walet_screen/my_walet_screen.dart';

Future<void> _messageHandler(RemoteMessage message) async {}
AndroidNotificationChannel? channel =
    AndroidNotificationChannel("key1", "chat");

/// Initialize the [FlutterLocalNotificationsPlugin] package.
FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
void main() async {
  ServicesLocator().init();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await EasyLocalization.ensureInitialized();
  await readToken();
  await getLocation();
  FirebaseMessaging.onBackgroundMessage(_messageHandler);
  FirebaseMessaging.onMessageOpenedApp;

  // initLocalNotification();
  runApp(
    EasyLocalization(
        supportedLocales: const [Locale("ar"), Locale("en"),Locale("ur")],
        path: "assets/translations",
        // <-- change the path of the translation files
        fallbackLocale: const Locale("ar"),
        startLocale: const Locale("ar"),
        child: const MyApp()),
  );
}

// void initLocalNotification() {
//   AwesomeNotifications().initialize('resource://drawable/logo', [
//     NotificationChannel(
//       channelKey: 'limozin',
//       channelName: 'limozin',
//       channelDescription: "Notification nawte",
//       defaultColor: Colors.transparent,
//       ledColor: Colors.blue,
//       channelShowBadge: true,

//       importance: NotificationImportance.High,
//       // playSound: true,
//       // enableLights:true,
//       // enableVibration: false
//     )
//   ]);
// }

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.white));

    return MultiBlocProvider(
      providers: [
        BlocProvider<AppCubit>(
            create: (BuildContext context) => sl<AppCubit>()),
        BlocProvider<AuthCubit>(
            create: (BuildContext context) => sl<AuthCubit>()),
        BlocProvider<DriverCubit>(
            create: (BuildContext context) => sl<DriverCubit>()),
        BlocProvider<TripCubit>(
            create: (BuildContext context) => sl<TripCubit>()),
        BlocProvider<NotificationsCubit>(
            create: (BuildContext context) => sl<NotificationsCubit>()),
      ],
      child: BlocBuilder<AppCubit, AppState>(
        builder: (context, state) {
          return MaterialApp(
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            debugShowCheckedModeBanner: false,
            theme: theme,
            initialRoute: splash,
            routes: {
              splash: (context) => const SplashScreen(),
              login: (context) => LoginScreen(),

              editAccount: (context) => EditAccountScreen(),
              home: (context) => HomeScreen(),

              account: (context) => AccountScreen(),
              notifications: (context) => NotificationsScreen(),
              history: (context) => HistoryScreen(),
              badges: (context) => BadgesScreen(),
              trip: (context) => TripScreen(),
              policy: (context) => PolicyScreen(),
              welcome: (context) => WelcomeScreen(),
              lang: (context) => ChoseLangScreen(),
              signUp: (context) => CreateAccountDriverScreen(),
              // subscription:(context) => SubscriptionsScreen(),
              settings: (context) => SettingsScreen(),
              support: (context) => SupportScreen(),
              externalTrip: (context) => ExternalTripScreen(),
               wallet:(context) => MyWalletScreen()
              // addExternalTrip: (context) => AddExternalTripScreen(),
            },
          );
        },
      ),
    );
  }
}
