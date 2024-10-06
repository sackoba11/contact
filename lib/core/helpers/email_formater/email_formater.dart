import 'package:contact/core/utilities/input_controller/input_controller.dart';

class EmailFormater {
  static String? formatEmail({String? title}) {
    final emailRegex =
        RegExp(r'^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$');

    while (true) {
      String input =
          InputController.inputController(title:title);
      if (input.isEmpty) {
        return null;
      }

      if (emailRegex.hasMatch(input)) {
        return input;
      } else {
        print(
            'Adresse e-mail invalide. Veuillez entrer une adresse e-mail valide.');
      }
    }
  }
}
