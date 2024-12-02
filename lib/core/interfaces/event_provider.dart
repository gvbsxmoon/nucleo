import 'package:nucleo/core/models/event_model.dart';

abstract class EventProvider<T> {
  Stream<EventModel<T>> get eventStream;

  Future<void> initialize();

  Future<void> dispose();

  Future<void> handleMessage(T message);
}
