class EventKey {
  final String hash;
  final String key;

  EventKey({
    required this.key,
  }) : hash = _generateHash(key);

  static String _generateHash(String key) {
    return key.hashCode.toString();
  }
}
