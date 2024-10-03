import 'dart:io';

class EmailFormater {
  static String? formatEmail() {
    final emailRegex =
        RegExp(r'^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$');

    while (true) {
      stdout.write('Adresse e-mail: ');
      String input = stdin.readLineSync()?.trim() ?? '';
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
