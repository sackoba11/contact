import 'package:contact/core/utilities/generic_message/generic_message.dart';
import 'package:dartz/dartz.dart';

import '../../../models/contact.dart';
import '../input_controller/input_controller.dart';

class ContactManager {
  static Contact createContact() {
    GenericMessageImpl("Saisie d'un nouveau contact:");

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

  static Either<GenericMessage, Contact> createContactWithArgs(
      {required List<String> args}) {
    late String number;
    late String email;
    late String errorNumber;
    late String errorEmail;

    if (args.length == 4) {
      final numberformated =
          InputController.formatPhoneNumberFromArg(input: args[2]);
      final emailFormated = InputController.formatEmailFromArg(input: args[3]);
      numberformated.fold((error) {
        errorNumber = error.getMessage();
      }, (numb) {
        number = numb;
      });
      emailFormated.fold((error) {
        errorEmail = error.getMessage();
      }, (mail) {
        email = mail;
      });

      if (numberformated.isRight() && emailFormated.isRight()) {
        return right(Contact(
          firstName: args[0],
          lastName: args[1],
          phoneNumber: number,
          email: email,
        ));
      }
      return left(GenericMessageError("$errorNumber \n$errorEmail"));
    } else if (args.length == 3) {
      final numberformated =
          InputController.formatPhoneNumberFromArg(input: args[2]);
      numberformated.fold((error) {
        errorNumber = error.getMessage();
      }, (numb) {
        number = numb;
      });
      if (numberformated.isRight()) {
        return right(Contact(
          firstName: args[0],
          lastName: args[1],
          phoneNumber: number,
          email: "",
        ));
      }
      return left(GenericMessageError(errorNumber));
    } else if (args.length == 2) {
      final numberformated =
          InputController.formatPhoneNumberFromArg(input: args[1]);
      numberformated.fold((error) {
        errorNumber = error.getMessage();
      }, (numb) {
        number = numb;
      });
      if (numberformated.isRight()) {
        return right(Contact(
          firstName: args[0],
          lastName: "",
          phoneNumber: number,
          email: "",
        ));
      }
      return left(GenericMessageError(errorNumber));
    } else {
      final numberformated =
          InputController.formatPhoneNumberFromArg(input: args[0]);
      numberformated.fold((error) {
        errorNumber = error.getMessage();
      }, (numb) {
        number = numb;
      });
      if (numberformated.isRight()) {
        return right(Contact(
          firstName: "",
          lastName: "",
          phoneNumber: number,
          email: "",
        ));
      }
      return left(GenericMessageError(errorNumber));
    }
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
