import 'package:event_bus/event_bus.dart';
import 'package:get/get.dart';

class EventBusService extends GetxService {
  EventBus? _eventBus;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    _eventBus = EventBus();
  }

  void listenEvent<T>({required Function onListen}) {
    _eventBus?.on<T>().listen((event) {
      onListen(event);
    });
  }

  void fireEvent<T>({required T event}) {
    _eventBus?.fire(event);
  }
}

class EventNewTaskAdd {}

class EventUpdateTask {}

class EventUpdateSingleReport {}

class EventNewReportAdd {}

class EventUpdateReport {}
