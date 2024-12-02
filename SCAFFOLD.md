lib/
├── src/
│   ├── core/
│   │   ├── interfaces/
│   │   │   ├── event_provider.dart        # Base provider interface
│   │   │   ├── event_handler.dart         # Base handler interface
│   │   │   └── event_action.dart          # Base action interface
│   │   │
│   │   ├── models/
│   │   │   ├── event_model.dart           # Base event model
│   │   │   └── event_key.dart             # Event key type
│   │   │
│   │   ├── exceptions/
│   │   │   └── event_exceptions.dart      # Custom exceptions
│   │   │
│   │   └── core.dart                      # Exports core components
│   │
│   ├── providers/
│   │   ├── firebase/
│   │   │   ├── firebase_provider.dart
│   │   │   └── firebase_background_handler.dart
│   │   │
│   │   ├── websocket/
│   │   │   └── websocket_provider.dart
│   │   │
│   │   ├── polling/
│   │   │   └── polling_provider.dart
│   │   │
│   │   └── providers.dart                 # Exports all providers
│   │
│   ├── services/
│   │   ├── queue/
│   │   │   └── event_queue_service.dart
│   │   │
│   │   ├── storage/
│   │   │   └── event_storage_service.dart
│   │   │
│   │   └── services.dart                  # Exports all services
│   │
│   ├── widgets/
│   │   ├── event_manager_provider.dart
│   │   ├── event_listener.dart
│   │   └── widgets.dart                   # Exports all widgets
│   │
│   └── event_manager.dart                 # Main manager class
│
├── event_manager.dart                     # Main library file
└── testing.dart                           # Testing utilities