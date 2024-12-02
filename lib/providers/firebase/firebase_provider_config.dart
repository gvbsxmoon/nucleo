import 'package:event_manager/core/interfaces/event_provider_config.dart';
import 'package:firebase_core/firebase_core.dart';

class FirebaseProviderConfig extends EventProviderConfig {
  FirebaseOptions options;
  String? vapidKey;
  bool requestUserPermission;

  FirebaseProviderConfig({
    required this.options,
    this.vapidKey,
    this.requestUserPermission = true,
  });
}
