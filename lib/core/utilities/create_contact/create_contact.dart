import 'dart:io';

import '../../../models/contact.dart';
import '../../helpers/email_formater/email_formater.dart';
import '../../helpers/phone_number_formater/phone_number_formater.dart';

class CreateContact {
  static Contact createContact() {
    print('Saisie d\'un nouveau contact:');

    stdout.write('Nom: ');
    String firstName = stdin.readLineSync() ?? '';

    stdout.write('Prénom: ');
    String lastName = stdin.readLineSync() ?? '';

    // stdout.write('Numéro de téléphone: ');
    String phoneNumber = PhoneNumberFormater.formatPhoneNumber()!;

    // stdout.write('Email (optionnel, appuyez sur Entrée pour passer): ');
    String? email = EmailFormater.formatEmail();

    return Contact(
      firstName: firstName,
      lastName: lastName,
      phoneNumber: phoneNumber,
      email: email,
    );
  }
}
