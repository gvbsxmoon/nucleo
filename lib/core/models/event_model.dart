import 'package:event_manager/core/models/event_key.dart';
import 'package:event_manager/core/models/event_metadata.dart';

class EventModel<T> {
  final EventKey key;
  final EventMetadata metadata;
  final T data;

  EventModel({
    required this.key,
    required this.metadata,
    required this.data,
  });
}
