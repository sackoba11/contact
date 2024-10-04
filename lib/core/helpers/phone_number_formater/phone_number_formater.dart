import 'dart:io';

class PhoneNumberFormater {
  static String? formatPhoneNumber() {
    while (true) {
      String input = stdin.readLineSync() ?? '';

      // Supprime les espaces et les tirets pour une validation plus simple
      String cleanedInput = input.replaceAll(RegExp(r'[\s-]'), '');

      // Vérifie si l'entrée ne contient que des chiffres et a une longueur appropriée
      if (RegExp(r'^[0-9]{10}$').hasMatch(cleanedInput)) {
        return cleanedInput;
      } else {
        print(
            'Numéro de téléphone invalide. Veuillez entrer un numéro valide de 10 chiffres.');
      }
    }
  }
}
