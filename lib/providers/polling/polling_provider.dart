// import 'dart:async';
// import 'package:background_fetch/background_fetch.dart';
// import 'package:http/http.dart' as http;
// import 'package:event_manager/core/interfaces/event_provider.dart';

import 'dart:async';

import 'package:http/http.dart';
import 'package:nucleo/core/core.dart';
import 'package:nucleo/providers/polling/polling_provider_config.dart';

class PollingProvider extends EventProvider {
  final Client _client;
  final PollingProviderConfig? _config;

  PollingProvider._({
    required Client client,
    PollingProviderConfig? config,
  })  : _client = client,
        _config = config;

  factory PollingProvider.fromInstance(Client client) =>
      PollingProvider._(client: client);

  factory PollingProvider.withConfig(PollingProviderConfig config) {
    return PollingProvider._(
      client: Client(),
      config: config,
    );
  }

  @override
  Future<void> dispose() {
    // TODO: implement dispose
    throw UnimplementedError();
  }

  @override
  // TODO: implement eventStream
  Stream<EventModel> get eventStream => throw UnimplementedError();

  @override
  Future<void> handleMessage(message) {
    // TODO: implement handleMessage
    throw UnimplementedError();
  }

  @override
  Future<void> initialize() {
    // TODO: implement initialize
    throw UnimplementedError();
  }
}



// class PollingProvider implements EventProvider {
//   Timer? _pollingTimer;
//   final _client = http.Client();
// 
//   @override
//   Future<void> configure(Map<String, dynamic> config) async {
// //     if (config is! PollingConfig) {
// //       throw ArgumentError('PollingProvider requires PollingConfig');
// //     }
// // 
// //     // Set up periodic polling
// //     _pollingTimer?.cancel();
// //     _pollingTimer = Timer.periodic(config.interval, (_) => _poll(config));
// // 
// //     // Configure background polling if enabled
// //     if (config.backgroundPollingEnabled &&
// //         (Platform.isIOS || Platform.isAndroid)) {
// //       await BackgroundFetch.configure(
// //         BackgroundFetchConfig(
// //           minimumFetchInterval: config.interval.inMinutes,
// //           stopOnTerminate: false,
// //           enableHeadless: true,
// //         ),
// //         (String taskId) async {
// //           await _poll(config);
// //           BackgroundFetch.finish(taskId);
// //         },
// //       );
// //     }
//   }
// 
//   Future<void> _poll(Map<String, dynamic> config) async {
//     try {
//       final response = await _client
//           .get(Uri.parse(config.url), headers: config.headers)
//           .timeout(const Duration(seconds: 10));
// 
//       if (response.statusCode == 200) {
//         final events = response.body;
//         // Process events...
//       }
//     } catch (e) {
//       // Handle errors...
//     }
//   }
// 
//   @override
//   Future<void> dispose() {
//     // TODO: implement dispose
//     throw UnimplementedError();
//   }
// 
//   @override
//   // TODO: implement eventStream
//   Stream get eventStream => throw UnimplementedError();
// 
//   @override
//   Future<void> initialize() {
//     // TODO: implement initialize
//     throw UnimplementedError();
//   }
// }
