import 'package:nucleo/core/core.dart';

class PollingProviderConfig extends EventProviderConfig {
  final Uri url;
  final Duration interval;
  final Duration timeout;
  final Map<String, String>? headers;

  PollingProviderConfig({
    required this.url,
    this.interval = const Duration(minutes: 1),
    this.timeout = const Duration(seconds: 30),
    this.headers,
  });
}
