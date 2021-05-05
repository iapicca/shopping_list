import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shopping_list/ui/home.dart';

void main() {
  runApp(const ProviderScope(child: MaterialApp(home: HomePage())));
}
