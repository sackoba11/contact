import 'package:contact/core/helpers/usage/usage.dart';
import 'package:contact/home/home.dart';

void main(List<String> arguments) {
  if (arguments.isEmpty) {
    Usage.printUsage();
    return;
  }
  final command = arguments[0];
  final args = arguments.sublist(1);

  Home.launch(choix: command, args: args);
}
