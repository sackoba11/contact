import 'dart:io';

import 'package:contact/core/utilities/generic_message/generic_message.dart';

enum TypeData { email, phoneNumber }

class InputController {
  static String formatPhoneNumber({required String input}) {
    while (true) {
      // Supprime les espaces et les tirets pour une validation plus simple
      String cleanedInput = input.replaceAll(RegExp(r'[\s-]'), '');

      // Vérifie si l'entrée ne contient que des chiffres et a une longueur appropriée
      if (RegExp(r'^[0-9]{10}$').hasMatch(cleanedInput)) {
        return cleanedInput;
      } else {
        PrintGenericMessage(
            'Numéro de téléphone invalide. Veuillez entrer un numéro valide de 10 chiffres.');
      }
    }
  }

  static String formatEmail({required String input}) {
    final emailRegex =
        RegExp(r'^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$');

    while (true) {
      if (input.isEmpty) {
        return "";
      }

      if (emailRegex.hasMatch(input)) {
        return input;
      } else {
        PrintGenericMessage(
            'Adresse e-mail invalide. Veuillez entrer une adresse e-mail valide.');
      }
    }
  }

  static String inputController({String? title, TypeData? typeData}) {
    title != null ? stdout.write(title) : "";
    String input = stdin.readLineSync()?.trim() ?? '';

    switch (typeData) {
      case TypeData.email:
        final inputData = formatEmail(input: input);
        return inputData;

      case TypeData.phoneNumber:
        final inputData = formatPhoneNumber(input: input);
        return inputData;

      default:
        return input;
    }
  }
}
