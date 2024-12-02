import 'package:event_manager/core/core.dart';

abstract class EventProvider<T> {
  Stream<EventModel<T>> get eventStream;

  Future<void> initialize();

  Future<void> dispose();
}
