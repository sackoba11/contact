import 'package:contact/models/contact.dart';
import '../input_controller/input_controller.dart';

class UpdateDatacontact {
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
