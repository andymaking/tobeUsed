import 'dart:async';

import 'package:dhoro_mobile/data/cache/user_cache_impl.dart';
import 'package:dhoro_mobile/domain/model/token/token_meta_data.dart';
import 'package:dhoro_mobile/domain/model/user/user.dart';
import 'package:dhoro_mobile/domain/viewmodel/login_viewmodel.dart';
import 'package:dhoro_mobile/domain/viewmodel/overview_viewmodel.dart';
import 'package:dhoro_mobile/domain/viewmodel/request_viewmodel.dart';
import 'package:dhoro_mobile/domain/viewmodel/signup_viewmodel.dart';
import 'package:dhoro_mobile/domain/viewmodel/verify_account_viewmodel.dart';
import 'package:dhoro_mobile/ui/login/login.dart';
import 'package:dhoro_mobile/route/routes.dart';
import 'package:dhoro_mobile/utils/change_statusbar_color.dart';
import 'package:dhoro_mobile/utils/color.dart';
import 'package:dhoro_mobile/utils/navigation_helper.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'data/cache/user_cache.dart';
import 'data/core/config.dart';
import 'data/remote/user_remote/user_remote.dart';
import 'data/remote/user_remote/user_remote_impl.dart';
import 'data/repository/user_repository.dart';
import 'data/repository/user_repository_impl.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupDb();
  await Hive.initFlutter();
  Config.appFlavor = Flavor.DEVELOPMENT;
  setupLocator();
  runZonedGuarded(() {
    runApp(ProviderScope(child: MyApp()));
  }, (dynamic error, dynamic stack) {
    print(error);
    print(stack);
  });
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    changeStatusAndNavBarColor(
        Pallet.colorWhite, Pallet.colorWhite, false, false);
    return MaterialApp(
      title: 'Dhoro App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LoginPage(),
      onGenerateRoute: AppRouter.generateRoute,
    );
  }
}

GetIt locator = GetIt.instance;

void setupLocator() {
  setupDio();
  locator.registerLazySingleton(() => NavigationHelper());
  locator.registerFactory<UserCache>(() => UserCacheImpl());
  locator.registerFactory<UserRemote>(() => UserRemoteImpl(locator<Dio>()));
  locator.registerFactory<UserRepository>(
          () => UserRepositoryImpl(locator<UserRemote>(), locator<UserCache>()));

  registerViewModels();
}

void setupDio() {
  locator.registerFactory(() {
    Dio dio = Dio();
    /*TODO Confirm headers*/
    // dio.options.headers['Client-Id'] = NetworkConfig.CLIENT_ID;
    // dio.options.headers['Client-key'] = NetworkConfig.CLIENT_KEY;
    // dio.options.headers['Client-Secret'] = NetworkConfig.CLIENT_SECRET;
    dio.interceptors.add(PrettyDioLogger());
// customization
    dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90));
    return dio;
  });
}

void registerViewModels() {
  /* TODO Setup viewModels*/
  locator.registerFactory(() => SignUpViewModel());
  locator.registerFactory(() => VerifyAccountViewModel());
  locator.registerFactory(() => LoginViewModel());
  locator.registerFactory(() => OverviewViewModel());
  //locator.registerFactory(() => ForgotPasswordViewModel());
  //locator.registerFactory(() => ProfileViewModel());
  //locator.registerFactory(() => ChangePasswordViewModel());
  //locator.registerFactory(() => LogoutViewModel());
  locator.registerFactory(() => RequestViewModel());
}

Future<void> setupDb() async {
  Hive.registerAdapter<User>(UserAdapter());
  Hive.registerAdapter<TokenMetaData>(TokenMetaDataAdapter());
}