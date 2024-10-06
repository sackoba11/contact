import 'dart:io';

class InputController {
  static String inputController({String? title}) {
    title!=null? stdout.write(title):"";
    String input = stdin.readLineSync()?.trim() ?? '';
    return input;
  }
}
