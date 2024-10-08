import 'package:mobile_rhm/core/utils/log_utils.dart';
import 'package:url_launcher/url_launcher.dart';

class FileUtils {
  static openRemoteFile({required String file}) {
    try {
      LogUtils.logE(message: 'Open remote file with mode $file');
      launchUrl(Uri.parse(file), mode: LaunchMode.inAppBrowserView);
    } catch (e) {
      LogUtils.logE(message: 'Cannot open file');
    }
  }
}
