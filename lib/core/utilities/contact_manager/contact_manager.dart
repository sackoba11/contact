import 'package:contact/core/utilities/generic_message/generic_message.dart';

import '../../../models/contact.dart';
import '../input_controller/input_controller.dart';

class ContactManager {
  static Contact createContact() {
    PrintGenericMessage("Saisie d'un nouveau contact:");

    String firstName = InputController.inputController(title: 'Nom: ');

    String lastName = InputController.inputController(title: 'Prénom: ');

    String phoneNumber = InputController.inputController(
        title: 'Numéro de téléphone: ', typeData: TypeData.phoneNumber);

    String? email = InputController.inputController(
        title: 'Adresse e-mail: ', typeData: TypeData.email);

    return Contact(
      firstName: firstName,
      lastName: lastName,
      phoneNumber: phoneNumber,
      email: email,
    );
  }

  static Contact updateDataContact({required Contact contactToUpdate}) {
    final newFirstName = InputController.inputController(
        title: 'Nouveau nom (${contactToUpdate.firstName}): ');
    if (newFirstName.isNotEmpty) {
      contactToUpdate = contactToUpdate.copyWith(firstName: newFirstName);
    }
    final newLastName = InputController.inputController(
        title: 'Nouveau prénom (${contactToUpdate.lastName}): ');
    if (newLastName.isNotEmpty) {
      contactToUpdate = contactToUpdate.copyWith(lastName: newLastName);
    }

    final newPhoneNumber = InputController.inputController(
        title:
            'Nouveau numéro de téléphone (${contactToUpdate.phoneNumber}): ');
    if (newPhoneNumber.isNotEmpty) {
      contactToUpdate = contactToUpdate.copyWith(phoneNumber: newPhoneNumber);
    }
    final newEmail = InputController.inputController(
        title: 'Nouvel email (${contactToUpdate.email ?? "Non défini"}): ');
    if (newEmail.isNotEmpty) {
      contactToUpdate = contactToUpdate.copyWith(email: newEmail);
    }

    return contactToUpdate;
  }
}
