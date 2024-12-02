import 'dart:convert';

import 'package:event_manager/providers/firebase/index.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// A background message handler for processing notification events.
///
/// This function is triggered when a background message is received. It checks if the
/// notification event can be handled and, if so, stores the event data in secure storage.
///
/// The `@pragma('vm:entry-point')` annotation ensures that this function is retained
/// and accessible as an entry point for background message handling.
///
/// Parameters:
/// - [message]: The remote message received from Firebase Cloud Messaging.
@pragma('vm:entry-point')
BackgroundMessageHandler firebaseBackgroundHandler = (
  RemoteMessage message,
) async {
  // TODO: extend and specialize
  // Store the event data in secure storage
  // in order to retrieve them on the foreground.
  const preference = FlutterSecureStorage();

  await preference.write(
    key: FirebaseMessagingProvider.storageKey,
    value: json.encode(message.toMap()),
  );
};
