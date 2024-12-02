<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/tools/pub/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/to/develop-packages).
-->

TODO: Put a short description of the package here that helps potential users
know whether this package might be useful for them.

## Features

TODO: List what your package can do. Maybe include images, gifs, or videos.

## Getting started

TODO: List prerequisites and provide or point to information on how to
start using the package.

## Usage

TODO: Include short and useful examples for package users. Add longer examples
to `/example` folder.

```dart
const like = 'sample';
```

## Additional information

TODO: Tell users more about the package: where to find more information, how to
contribute to the package, how to file issues, what response they can expect
from the package authors, and more.




i provider devono esporre la configurazione iniziale, la funzione di dipose e lo stream degli eventi.

alla ricezione di un evento, per ogni singolo provider, viene eseguito il dispatch dell'evento all interno del provider verso un controller di stream.

l event handler deve deve avere un provider, ascoltare lo stream e per ogni evento ricevuto, eseguire il dispatch.

ci deve essere poi un controller di stream che espone l'evento finale, che un widget può ascoltare.

un widget wrapper che espone lo stream finale e on receive che ne permette il consume