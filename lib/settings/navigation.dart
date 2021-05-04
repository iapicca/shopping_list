import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import '../ui/all.dart';

/// provides the `locations` for `navigator 2.0`
class ItemsLocation extends BeamLocation {
  ///
  ItemsLocation(BeamState state) : super(state);

  @override
  final pathBlueprints = ['/item/:itemId'];

  @override
  List<BeamPage> pagesBuilder(BuildContext context, BeamState state) {
    return [
      BeamPage(
        key: const ValueKey('home'),
        child: const HomePage(),
      ),
      if (state.pathParameters.containsKey('itemId'))
        BeamPage(
          key: ValueKey('item-${state.pathParameters['itemId']}'),
          child: Container(),
        ),
    ];
  }
}
