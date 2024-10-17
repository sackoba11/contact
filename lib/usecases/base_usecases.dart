import 'package:contact/core/utilities/generic_message/generic_message.dart';
import 'package:contact/core/utilities/input_controller/input_controller.dart';
import 'package:contact/repository_contacts/contacts_repository.dart';

import '../core/helpers/config/storage_config.dart';
import '../core/utilities/contact_manager/contact_manager.dart';
import '../repository_contacts/contacts_repository_impl.dart';

class BaseUsecases {
  ContactRepository contactRepository = ContactsRepositoryImpl();

  void addContact() {
    try {
      var newContact = ContactManager.createContact();
      var contact = contactRepository.addContact(newContact: newContact);
      if (contact != null) {
        PrintGenericMessage(
                'Contact ajouté avec succès : Nom: ${contact.firstName}, Prénom: ${contact.lastName}, Numéro: ${contact.phoneNumber} ${contact.email != null ? ", Email:${contact.email} " : ""}')
            .getMessage();
      } else {
        PrintGenericMessage("Impossible d'ajouter ce contact").getMessage();
      }
    } catch (e) {
      PrintGenericMessageError("Une erreur s'est produite : $e").getMessage();
    }
  }

  void displayContacts() {
    try {
      final contacts = contactRepository.getAllContacts();

      if (contacts != null) {
        PrintGenericMessage(
                '${contacts.length} contact(s) chargé(s) depuis ${StorageConfig.storageFileName}')
            .getMessage();

        var number = 1;
        contacts.forEach((key, contact) {
          PrintGenericMessage(
                  "$number : Nom: ${contact.firstName}, Prénom: ${contact.lastName}, Numéro: ${contact.phoneNumber} ${contact.email != null ? ", Email:${contact.email} " : ""} ")
              .getMessage();
          number++;
        });
      } else {
        PrintGenericMessage('Aucun contact enregistré.').getMessage();
      }
    } catch (e) {
      PrintGenericMessageError("Une erreur s'est produite : $e").getMessage();
    }
  }

  void updateContact() {
    final contacts = contactRepository.getAllContacts();
    if (contacts!.isNotEmpty) {
      displayContacts();
    } else {
      PrintGenericMessage(
              "Aucun contact trouvé. Veuillez ajouter des contacts !")
          .getMessage();
      return;
    }
    // Demander à l'utilisateur quel numéro modifier
    String updateNumber = InputController.inputController(
        title: 'Entrez le numéro à modifier parmi le(s) numéro(s) ci-dessus : ',
        typeData: TypeData.phoneNumber);

    if (contacts[updateNumber] != null) {
      PrintGenericMessage(
              'Modification du contact : ${updateNumber.toString()}')
          .getMessage();
      PrintGenericMessage('Laissez vide pour conserver la valeur actuelle.')
          .getMessage();
      final updatedContact =
          contactRepository.updateContact(updateNumber: updateNumber);

      PrintGenericMessage(
              "Nom: ${updatedContact.firstName}, Prénom: ${updatedContact.lastName}, Numéro: ${updatedContact.phoneNumber} ${updatedContact.email != null ? ", Email:${updatedContact.email} " : ""} ")
          .getMessage();
      PrintGenericMessage('Contact modifié avec succès.').getMessage();
    } else {
      PrintGenericMessage(
              "Aucun contact ne correspond au contact : $updateNumber")
          .getMessage();
    }
  }

  void removeContact() {
    final contacts = contactRepository.getAllContacts();
    if (contacts!.isEmpty) {
      PrintGenericMessage('Aucun contact à supprimer.').getMessage();
      return;
    }

    displayContacts();
    final contactToDelete = InputController.inputController(
        title: 'Entrez le numéro du contact à supprimer : ',
        typeData: TypeData.phoneNumber);

    contactRepository.deleteContact(contactToDelete: contactToDelete);
    PrintGenericMessage('Contact $contactToDelete supprimé avec succès.')
        .getMessage();
  }
}
