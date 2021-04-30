import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final string = await rootBundle.loadString('config/api.json');
  print(string);
}
