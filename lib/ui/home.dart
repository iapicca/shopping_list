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
    final tabController = useTabController(initialLength: 2);
    useMemoized(fetch);
    return Scaffold(
      key: const ValueKey('Scaffold@HomePage'),
      appBar: AppBar(
        key: const ValueKey('AppBar@HomePage'),
        bottom: TabBar(
          key: const ValueKey('TabBar@HomePage'),
          controller: tabController,
          tabs: [
            const Tab(
              key: ValueKey('Tab:todo@HomePage'),
              child: Text('To do'),
            ),
            const Tab(
              key: ValueKey('Tab:completed@HomePage'),
              child: Text('Completed'),
            ),
          ],
        ),
        title: const Text('Shopping List'),
      ),
      body: TabBarView(
        key: const ValueKey('TabBarView@HomePage'),
        controller: tabController,
        children: [
          const TodoItemsList(),
          const CompletedItemsList(),
        ],
      ),
      floatingActionButton: AnimatedFab(
        callback: () {
          if (tabController.index != 0) {
            tabController.animateTo(0);
          }
        },
      ),
    );
  }
}
