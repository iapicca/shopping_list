import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shopping_list/ui/all.dart';

/// implements the material app
class App extends StatelessWidget {
  /// allows a `const` constructor
  const App() : super(key: const ValueKey('App'));

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      key: const ValueKey('ProviderScope@App'),
      child: MaterialApp(
        key: const ValueKey('MaterialApp@App'),
        title: 'Shopping List',
        theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: Colors.teal,
          accentColor: Colors.cyan,
        ),
        home: const HomePage(),
      ),
    );
  }
}
