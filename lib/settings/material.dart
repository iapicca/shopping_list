import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'all.dart';

/// the root of the material app
class App extends StatelessWidget {
  /// allows a `const` constructor
  const App() : super(key: const ValueKey('app'));

  @override
  Widget build(BuildContext context) {
    final routerDelegate = BeamerRouterDelegate(
      locationBuilder: (state) => ItemsLocation(state),
    );
    return ProviderScope(
      key: ValueKey('ProviderScope@$key'),
      child: MaterialApp.router(
        key: ValueKey('MaterialApp@$key'),
        routerDelegate: routerDelegate,
        routeInformationParser: BeamerRouteInformationParser(),
        backButtonDispatcher:
            BeamerBackButtonDispatcher(delegate: routerDelegate),
      ),
    );
  }
}
