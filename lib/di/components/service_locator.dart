import 'package:dio/dio.dart';
import 'package:mobile_rhm/data/app_repository_manager.dart';
import 'package:mobile_rhm/data/local/app_database_helper.dart';
import 'package:mobile_rhm/data/local/database_helper.dart';
import 'package:mobile_rhm/data/network/api/api_helper.dart';
import 'package:mobile_rhm/data/network/api/app_api_helper.dart';
import 'package:mobile_rhm/data/network/dio_client.dart';
import 'package:mobile_rhm/data/prefs/app_preference_helper.dart';
import 'package:mobile_rhm/data/prefs/preference_helper.dart';
import 'package:mobile_rhm/data/repository_manager.dart';
import 'package:mobile_rhm/di/module/local_module.dart';
import 'package:mobile_rhm/di/module/network_module.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

Future<void> setupLocator() async {
  //Provide Box
  getIt.registerSingletonAsync<AppHiveBox>(() => LocalModule.provideBox());

  //Provide Local Database
  getIt.registerSingleton<DatabaseHelper>(AppDatabaseHelper(await getIt.getAsync<AppHiveBox>()));

  /**
   * Async singletons
   * */

  getIt.registerSingletonAsync<SharedPreferences>(() => LocalModule.provideSharedPreferences());
  /**
   * Singletons
   * */
  //Provide Preference helper
  getIt.registerSingleton<PreferenceHelper>(AppPreferenceHelper(await getIt.getAsync<SharedPreferences>()));

  //Provide Dio
  getIt.registerSingleton<Dio>(NetworkModule.provideDio(getIt<PreferenceHelper>(), getIt<DatabaseHelper>()));

  //Provide Dio client
  getIt.registerSingleton<DioClient>(DioClient(getIt<Dio>()));

  //Provide Api helper
  getIt.registerSingleton<ApiHelper>(AppApiHelper(getIt<DioClient>()));

  //Provide Data manager
  getIt.registerSingleton<RepositoryManager>(AppRepositoryManager(getIt<DatabaseHelper>(), getIt<PreferenceHelper>(), getIt<ApiHelper>()));
}
