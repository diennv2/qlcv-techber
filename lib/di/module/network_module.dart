import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:mobile_rhm/core/app/eviroment_config.dart';
import 'package:mobile_rhm/core/extentions/string.dart';
import 'package:mobile_rhm/core/utils/log_utils.dart';
import 'package:mobile_rhm/data/model/response/user/me/UserProfile.dart';
import 'package:mobile_rhm/data/network/constants/constants.dart';
import 'package:mobile_rhm/data/network/constants/end_points.dart';
import 'package:mobile_rhm/data/network/constants/server_status.dart';
import 'package:mobile_rhm/data/prefs/preference_helper.dart';
import 'package:mobile_rhm/routers/app_pages.dart';

import '../../data/local/database_helper.dart';

abstract class NetworkModule {
  /// A singleton dio provider.
  ///
  /// Calling it multiple times will return the same instance.
  static Dio provideDio(PreferenceHelper sharedPrefHelper, DatabaseHelper databaseHelper) {
    final dio = Dio();
    final Dio refreshTokenDio = Dio();
    dio
      ..options.connectTimeout = const Duration(seconds: ApiConstants.connectionTimeout)
      ..options.receiveTimeout = const Duration(seconds: ApiConstants.receiveTimeout)
      ..options.headers = {'Content-Type': 'application/json; charset=utf-8'}
      ..interceptors.add(LogInterceptor(
        request: kDebugMode ? true : false,
        responseBody: kDebugMode ? true : false,
        requestBody: kDebugMode ? true : false,
        requestHeader: kDebugMode ? true : false,
      ))
      ..interceptors.add(
        InterceptorsWrapper(onRequest: (RequestOptions options, RequestInterceptorHandler handler) async {
          // getting token
          LogUtils.logE(message: '*Call URL PATH ${options.path} and URI = ${options.uri.toString()}');
          //No need add token to DOMAIN URL
          if (options.path == ApiEndpoint.DOMAIN_URL) {
            return handler.next(options);
          }

          String? baseUrl = EnvironmentConfigs.IS_SANDBOX ? EnvironmentConfigs.SANDBOX_URL : sharedPrefHelper.currentDomainUrl();
          options.path = options.path.replaceAll('@domain', baseUrl ?? '');
          var token = sharedPrefHelper.authToken();
          if (token.isNotNullOrBlank) {
            LogUtils.logE(message: 'Token Bearer $token');
            options.headers.putIfAbsent('Authorization', () => "Bearer $token");
          } else {
            if (kDebugMode) {
              LogUtils.logE(message: 'Auth token is null');
            }
          }

          return handler.next(options);
        }, onError: (DioError error, ErrorInterceptorHandler handler) async {
          LogUtils.logE(message: 'Case error response ${error.response?.statusCode}');
          if (error.response?.statusCode == ServerStatus.ERR_401) {
            LogUtils.logE(message: '#VM_FUCK_1');
            RequestOptions options = error.response!.requestOptions;
            LogUtils.logE(message: 'Option path = ${options.path}');
            if (!options.path.contains('refresh-token')) {
              // Avoid retrying refreshing token itself
              var refreshToken = sharedPrefHelper.refreshToken();
              try {
                String? baseUrl = EnvironmentConfigs.IS_SANDBOX ? EnvironmentConfigs.SANDBOX_URL : sharedPrefHelper.currentDomainUrl();
                String endPoint = ApiEndpoint.REFRESH_TOKEN_URL.replaceAll('@domain', baseUrl ?? '');
                LogUtils.logE(message: 'Refresh token endpoint = $endPoint with refresh token = $refreshToken');
                var token = sharedPrefHelper.authToken();
                var response = await refreshTokenDio.post(endPoint,
                    data: {'refreshToken': refreshToken}, options: Options(headers: {'Authorization': '$token'}));
                if (response.statusCode == ServerStatus.SUCCESS) {
                  LogUtils.logE(message: '#VM_FUCK_2');
                  LogUtils.log(response.data);
                  var newAccessToken = response.data['token'];
                  await sharedPrefHelper.saveAuthToken(newAccessToken);
                  // Retry the failed request with new token
                  options.headers['Authorization'] = "Bearer $newAccessToken";
                  try {
                    var res = await dio.fetch(options);
                    return handler.resolve(res);
                  } catch (e) {
                    return handler.reject(error);
                  }
                } else {
                  LogUtils.logE(message: '#VM_FUCK_3');
                  //Check if status 401. Do delete account
                  // if (response.statusCode == 401) {
                  if (Get.currentRoute != Routers.AUTH_LOGIN) {
                    sharedPrefHelper.saveRefreshToken('');
                    sharedPrefHelper.saveAuthToken('');
                    databaseHelper.saveUserProfile(profile: UserProfile());
                    Get.offAllNamed(Routers.AUTH_LOGIN);
                  }

                  // }
                  // return handler.reject(error); // Refresh token invalid or other issues
                }
              } catch (e) {
                LogUtils.logE(message: '#VM_FUCK_4');
                if (e is DioException) {
                  DioException err = e;
                  if (err.response?.statusCode == ServerStatus.ERR_401) {
                    LogUtils.logE(message: '#VM_FUCK_5');
                    if (Get.currentRoute != Routers.AUTH_LOGIN) {
                      sharedPrefHelper.saveRefreshToken('');
                      sharedPrefHelper.saveAuthToken('');
                      databaseHelper.saveUserProfile(profile: UserProfile());
                      Get.offAllNamed(Routers.AUTH_LOGIN);
                    }
                  }
                }

                return handler.reject(error); // Handle network errors, etc.
              }
            } else {
              return handler.reject(error); // Refresh token request itself failed
            }
          } else {
            return handler.next(error);
          }
        }),
      );

    return dio;
  }
}
