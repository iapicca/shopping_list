import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shopping_list/logic/all.dart';

import 'all.dart';

/// the homepage for the app
class HomePage extends HookWidget {
  /// allows a `const` constructor
  const HomePage() : super(key: const ValueKey('HomePage'));

  @override
  Widget build(BuildContext context) {
    final fetch = useProvider(fetchItemsPod);
    useMemoized(fetch);
    return DefaultTabController(
      key: ValueKey('DefaultTabController@$key'),
      length: 2,
      child: Scaffold(
        key: ValueKey('Scaffold@$key'),
        appBar: AppBar(
          key: ValueKey('AppBar@$key'),
          bottom: const TabBar(
            tabs: [
              Tab(child: Text('To do')),
              Tab(child: Text('Completed')),
            ],
          ),
          title: const Text('Shopping List'),
        ),
        body: const TabBarView(
          children: [
            ItemsList(),
            CompletedList(),
          ],
        ),
        floatingActionButton: const AnimatedFab(),
      ),
    );
  }
}
