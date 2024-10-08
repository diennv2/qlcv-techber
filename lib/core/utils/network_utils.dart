import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkUtils {
  static Future<bool> isNetworkConnected() async {
    var result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.none) {
      return false;
    }
    return true;
  }
}
