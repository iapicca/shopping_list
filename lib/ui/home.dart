import 'package:connectivity/connectivity.dart';
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
    final tabController = useTabController(initialLength: 2);
    final connectivity = useProvider(connectivityResultPod);
    final fetch = useProvider(fetchItemsPod);
    final onlineSnack = useProvider(onlineSnackPod);
    final offlineSnack = useProvider(offlineSnackPod);

    useMemoized(() {
      fetch();
      connectivity.addListener(() {
        if (connectivity.value != ConnectivityResult.none) {
          onlineSnack(context, connectivity.value);
          fetch();
        } else {
          offlineSnack(context);
        }
      });
    });
    return SafeArea(
      key: const ValueKey('SafeArea@HomePage'),
      child: ValueListenableBuilder<ConnectivityResult>(
        valueListenable: connectivity,
        builder: (context, value, child) {
          return Stack(
            key: const ValueKey('Stack@HomePage'),
            children: [
              child!,
              IndexedStack(
                key: const ValueKey('IndexedStack@HomePage'),
                index: value == ConnectivityResult.none ? 0 : null,
                children: [
                  const AbsorbPointer(
                    key: ValueKey('AbsorbPointer@HomePage'),
                    absorbing: true,
                    child: SizedBox.expand(
                      key: ValueKey('SizedBox.expand@HomePage'),
                      child: ColoredBox(
                        key: ValueKey('ColoredBox@HomePage'),
                        color: Color.fromRGBO(0, 0, 0, .7),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        },
        child: Scaffold(
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
        ),
      ),
    );
  }
}
