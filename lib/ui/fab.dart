import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:shopping_list/model/all.dart';

import 'all.dart';

const _fabDimension = 56.0;

/// a fab
class AnimatedFab extends StatelessWidget {
  /// allows a `const` constructor
  const AnimatedFab({
    required this.callback,
  }) : super(key: const ValueKey('AnimatedFab'));

  /// a `callback` that triggers when  `OpenContainer` closes
  final VoidCallback callback;
  @override
  Widget build(BuildContext context) {
    return OpenContainer<Item?>(
      onClosed: (value) => callback(),
      key: ValueKey('OpenContainer@$key'),
      transitionType: ContainerTransitionType.fade,
      closedBuilder: (context, action) {
        return SizedBox(
          key: const ValueKey('SizedBox@AnimatedFab'),
          height: _fabDimension,
          width: _fabDimension,
          child: Center(
            key: const ValueKey('Center@AnimatedFab'),
            child: Icon(
              Icons.add,
              key: const ValueKey('Icon@AnimatedFab'),
              color: Theme.of(context).colorScheme.onSecondary,
            ),
          ),
        );
      },
      closedElevation: 6.0,
      closedShape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(_fabDimension * .5)),
      ),
      closedColor: Theme.of(context).colorScheme.secondary,
      openBuilder: (context, action) {
        return NewItem();
      },
    );
  }
}
