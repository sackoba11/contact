import 'dart:io';

import 'package:contact/core/utilities/generic_message/generic_message.dart';

enum TypeData { email, phoneNumber }

class InputController {
  static String inputDataMethode({String? title}) {
    title != null ? stdout.write(title) : "";
    String input = stdin.readLineSync()?.trim() ?? '';
    return input;
  }

  static String formatPhoneNumber({String? title}) {
    while (true) {
      String input = inputDataMethode(title: title);

      // Supprime les espaces et les tirets pour une validation plus simple
      String cleanedInput = input.replaceAll(RegExp(r'[\s-]'), '');

      // Vérifie si l'entrée ne contient que des chiffres et a une longueur appropriée
      if (RegExp(r'^[0-9]{10}$').hasMatch(cleanedInput)) {
        return cleanedInput;
      } else {
        PrintGenericMessage(
                'Numéro de téléphone invalide. Veuillez entrer un numéro valide de 10 chiffres.')
            .getMessage();
      }
    }
  }

  static String formatEmail({String? title}) {
    final emailRegex =
        RegExp(r'^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$');

    while (true) {
      String input = inputDataMethode(title: title);
      if (input.isEmpty) {
        return "";
      }

      if (emailRegex.hasMatch(input)) {
        return input;
      } else {
        PrintGenericMessage(
                'Adresse e-mail invalide. Veuillez entrer une adresse e-mail valide.')
            .getMessage();
      }
    }
  }

  static String inputController({String? title, TypeData? typeData}) {
    switch (typeData) {
      case TypeData.email:
        final inputData = formatEmail(title: title);
        return inputData;

      case TypeData.phoneNumber:
        final inputData = formatPhoneNumber(title: title);
        return inputData;

      default:
        String input = inputDataMethode(title: title);
        return input;
    }
  }
}
