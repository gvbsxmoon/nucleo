import 'dart:async';

import 'package:nucleo/core/core.dart';

class PollingProviderConfig extends EventProviderConfig {
  final Timer timer;

  PollingProviderConfig({
    required this.timer,
  });
}
