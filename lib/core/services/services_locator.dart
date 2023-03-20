
import 'package:get_it/get_it.dart';
import 'package:limousine_driver/data/data_source/remote_data_source/trip_remote_data_source.dart';
import 'package:limousine_driver/data/repository/trip_repository.dart';
import 'package:limousine_driver/domin/repository/base_driver_repository.dart';
import 'package:limousine_driver/domin/repository/trip_base_repository.dart';
import 'package:limousine_driver/domin/usese_cases/driver_uses_cases/add_driver_use_case.dart';
import 'package:limousine_driver/domin/usese_cases/trip_uses_cases/home_trip_use_case.dart';
import 'package:limousine_driver/persentaion/controller/driver_cubit/driver_cubit.dart';
import 'package:limousine_driver/persentaion/controller/notifictions_cubit/cubit/notifications_cubit.dart';
import 'package:limousine_driver/persentaion/controller/trip_cubit/trip_cubit.dart';

import '../../data/data_source/remote_data_source/app_remote_data_source.dart';
import '../../data/data_source/remote_data_source/auth_remote_data_source.dart';
import '../../data/data_source/remote_data_source/driver_remote_data_source.dart';
import '../../data/repository/app_repository.dart';
import '../../data/repository/auth_repostory.dart';
import '../../data/repository/driver_repository.dart';
import '../../domin/repository/app_repository.dart';
import '../../domin/repository/base_auth_repository.dart';
import '../../domin/usese_cases/app_use_case/app_use_case.dart';
import '../../domin/usese_cases/auth_uses_cases/check_user_name_usecase.dart';
import '../../domin/usese_cases/auth_uses_cases/login_usecase.dart';
import '../../domin/usese_cases/auth_uses_cases/signup_usecase.dart';
import '../../persentaion/controller/app_cubit/cubit/app_cubit.dart';
import '../../persentaion/controller/auth_cubit/auth_cubit.dart';





final sl = GetIt.instance;

class ServicesLocator {
  void init() {
    /// bloc

    sl.registerFactory(() => AppCubit());
    sl.registerFactory(() => AuthCubit(sl(), sl(), sl(), sl()));
    sl.registerFactory(() => DriverCubit(sl(), sl()));
    sl.registerFactory(() => TripCubit(sl()));
    sl.registerFactory(() => NotificationsCubit());

    //    sl.registerFactory(() => SearchCubit(sl()));

    /// use Cases
    sl.registerLazySingleton(() => CheckUerNameUseCase(sl()));
    sl.registerLazySingleton(() => LoginUseCase(sl()));
    sl.registerLazySingleton(() => SignUpUseCase(sl()));
    sl.registerLazySingleton(() => AppUseCase(sl()));
   sl.registerLazySingleton(() => AddDriverUseCase(sl()));
 sl.registerLazySingleton(() => HomeTripUseCase(sl()));
    // sl.registerLazySingleton(() => GetFavoritesUseCase(sl()));
    // sl.registerLazySingleton(() => GetFavoriteIdsUseCase(sl()));
    // sl.registerLazySingleton(() => AddFavoriteUseCase(sl()));
    // sl.registerLazySingleton(() => SearchCityUseCase(sl()));

    /// repository
    sl.registerLazySingleton<BaseAuthRepository>(() => AuthRepository(sl()));
    sl.registerLazySingleton<BaseAppRepository>(() => AppRepository(sl()));
    sl.registerLazySingleton<BaseDriverRepository>(() => DriverRepository(sl()));
     sl.registerLazySingleton<BaseTripRepository>(() => TripRepository(sl()));
     ///data source
    sl.registerLazySingleton<BaseAuthRemoteDataSource>(
            () => AuthRemoteDataSource());
    sl.registerLazySingleton<BaseAppRemoteDataSource>(
            () => AppRemoteDataSource());
    sl.registerLazySingleton<BaseDriverRemoteDataSource>(
            () => DriverRemoteDataSource());
             sl.registerLazySingleton<BaseTripRemoteDataSource>(
            () => TripRemoteDataSource());

  }
}
