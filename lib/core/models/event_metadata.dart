class EventMetadata {
  final DateTime timestamp;
  final String? source;
  final String? version;
  final Map<String, dynamic>? extra;

  EventMetadata({
    this.source,
    this.version,
    this.extra,
  }) : timestamp = DateTime.now();
}
