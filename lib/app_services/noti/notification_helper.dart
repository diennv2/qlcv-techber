abstract class NotificationHelper {
  Future<dynamic> pushFirebaseToken({required String firebaseToken});

  Future<dynamic> deleteFirebaseToken();

  Future<bool?> requestPermission();

  Future<void> handleNotification();

  Future<bool> isGrantedNotification();
}