import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:nucleo/core/interfaces/event_provider.dart';
import 'package:nucleo/core/models/event_key.dart';
import 'package:nucleo/core/models/event_metadata.dart';
import 'package:nucleo/core/models/event_model.dart';
import 'package:nucleo/providers/firebase/firebase_background_handler.dart';
import 'package:nucleo/providers/firebase/firebase_provider_config.dart';

/// A provider that handles Firebase Cloud Messaging events.
///
/// This provider implements [EventProvider] to handle push notifications through Firebase.
/// It supports both web and mobile platforms, handles permission requests, and manages
/// the lifecycle of Firebase messaging events.
///
/// Usage:
/// ```dart
/// // Using an existing Firebase instance
/// final provider = FirebaseMessagingProvider.fromInstance(FirebaseMessaging.instance);
///
/// // Or with configuration
/// final provider = FirebaseMessagingProvider.withConfig(
///   FirebaseProviderConfig(
///     options: DefaultFirebaseOptions.currentPlatform,
///     vapidKey: 'your-vapid-key', // Required for web
///   ),
/// );
///
/// await provider.initialize();
/// ```
class FirebaseMessagingProvider implements EventProvider<RemoteMessage> {
  /// Storage key used for persisting provider data
  static const String storageKey = 'FIREBASE_MESSAGING_PROVIDER_STORAGE_KEY';

  /// The underlying Firebase Messaging instance
  final FirebaseMessaging _messaging;

  /// Provider configuration
  final FirebaseProviderConfig? _config;

  /// Controller for broadcasting message events
  final _eventController =
      StreamController<EventModel<RemoteMessage>>.broadcast();

  /// Private constructor to enforce factory usage
  ///
  /// [messaging] The Firebase Messaging instance to use
  /// [config] Optional configuration for the provider
  FirebaseMessagingProvider._({
    required FirebaseMessaging messaging,
    FirebaseProviderConfig? config,
  })  : _messaging = messaging,
        _config = config;

  /// Creates a provider from an existing Firebase Messaging instance
  ///
  /// Use this when Firebase is already initialized in your app.
  ///
  /// [messaging] The pre-configured Firebase Messaging instance
  factory FirebaseMessagingProvider.fromInstance(FirebaseMessaging messaging) =>
      FirebaseMessagingProvider._(
        messaging: messaging,
      );

  /// Creates a provider with the specified configuration
  ///
  /// This will initialize Firebase if needed and configure messaging.
  ///
  /// [config] The configuration for Firebase and the provider
  /// Throws [AssertionError] if VAPID key is missing for web platform
  factory FirebaseMessagingProvider.withConfig(FirebaseProviderConfig config) {
    if (Firebase.apps.isEmpty) {
      Firebase.initializeApp(options: config.options);
    }

    final messaging = FirebaseMessaging.instance;

    if (kIsWeb) {
      assert(config.vapidKey != null, 'VAPID key is required for web');
      messaging.getToken(vapidKey: config.vapidKey);
    }

    return FirebaseMessagingProvider._(
      messaging: messaging,
      config: config,
    );
  }

  /// Requests notification permissions from the user
  ///
  /// Returns the [AuthorizationStatus] indicating whether permissions were granted
  Future<AuthorizationStatus> _requestPermission() async {
    final permission = await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    return permission.authorizationStatus;
  }

  /// Initializes the provider and sets up message handlers
  ///
  /// This method:
  /// 1. Requests permissions if configured
  /// 2. Sets up foreground message handling
  /// 3. Sets up background message handling
  /// 4. Processes any initial message that launched the app
  @override
  Future<void> initialize() async {
    if (_config?.requestUserPermission ?? true) {
      await _requestPermission();
      // We continue initialization regardless of the permission status
      // The app will just not receive notifications if denied
    }

    FirebaseMessaging.onMessage.listen(handleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
    FirebaseMessaging.onBackgroundMessage(firebaseBackgroundHandler);

    final initialMessage = await _messaging.getInitialMessage();

    if (initialMessage != null) {
      await handleMessage(initialMessage);
    }
  }

  /// Cleans up resources used by the provider
  @override
  Future<void> dispose() async {
    await _eventController.close();
  }

  /// Stream of Firebase message events
  ///
  /// Subscribe to this stream to receive Firebase Cloud Messages as [EventModel]s
  @override
  Stream<EventModel<RemoteMessage>> get eventStream => _eventController.stream;

  /// Handles incoming Firebase messages
  ///
  /// Converts the [RemoteMessage] to an [EventModel] and broadcasts it
  /// through the event stream.
  @override
  Future<void> handleMessage(RemoteMessage message) async {
    // TODO: add a specific key for the message
    // TODO: give user the possibility to andle the metadata
    _eventController.sink.add(
      EventModel(
        key: EventKey(key: 'message'),
        metadata: EventMetadata(),
        data: message,
      ),
    );
  }
}
