import 'dart:io';

import 'package:contact/models/contact.dart';

class UpdateDatacontact {
  static Contact updateDataContact({required Contact contactToUpdate}) {
    stdout.write('Nouveau nom (${contactToUpdate.firstName}): ');
    final newFirstName = stdin.readLineSync();
    if (newFirstName?.isNotEmpty == true) {
      contactToUpdate = contactToUpdate.copyWith(firstName: newFirstName!);
    }
    stdout.write('Nouveau prénom (${contactToUpdate.lastName}): ');
    final newLastName = stdin.readLineSync();
    if (newLastName?.isNotEmpty == true) {
      contactToUpdate = contactToUpdate.copyWith(lastName: newLastName!);
    }
    stdout.write(
        'Nouveau numéro de téléphone (${contactToUpdate.phoneNumber}): ');
    final newPhoneNumber = stdin.readLineSync();
    if (newPhoneNumber?.isNotEmpty == true) {
      contactToUpdate = contactToUpdate.copyWith(phoneNumber: newPhoneNumber!);
    }
    stdout.write('Nouvel email (${contactToUpdate.email ?? "Non défini"}): ');
    final newEmail = stdin.readLineSync();
    if (newEmail?.isNotEmpty == true) {
      contactToUpdate = contactToUpdate.copyWith(email: newEmail!);
    }

    return contactToUpdate;
  }
}
