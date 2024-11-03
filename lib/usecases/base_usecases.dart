import 'package:contact/core/utilities/generic_message/generic_message.dart';
import 'package:contact/repository_contacts/contacts_repository.dart';

import '../core/helpers/config/storage_config.dart';
import '../models/contact.dart';
import '../repository_contacts/contacts_repository_impl.dart';

class BaseUsecases {
  ContactRepository contactRepository = ContactsRepositoryImpl();

  void addContact({required Contact newContact}) {
    final result = contactRepository.addContact(newContact: newContact);
    if (result.isRight()) {
      GenericMessageImpl(
              'Contact ajouté avec succès : ${newContact.firstName != "" ? "Nom: ${newContact.firstName} ," : ""} ${newContact.lastName != "" ? " Prénom: ${newContact.lastName} ," : ""} Numéro: ${newContact.phoneNumber} ${newContact.email != "" ? ", Email:${newContact.email} " : ""} ')
          .printMessage();
    } else {
      result.fold((l) => l.printMessage(), (r) => r);
    }
  }

  void displayContacts() {
    try {
      final contacts = contactRepository.getAllContacts();
      contacts.fold((error) => error.printMessage(), (contacts) {
        if (contacts.isNotEmpty) {
          GenericMessageImpl(
                  '${contacts.length} contact(s) chargé(s) depuis ${StorageConfig.storageFileName}')
              .printMessage();

          var number = 1;
          contacts.forEach((key, contact) {
            GenericMessageImpl(
                    "$number : ${contact.firstName != "" ? "Nom: ${contact.firstName} ," : ""} ${contact.lastName != "" ? " Prénom: ${contact.lastName} ," : ""} Numéro: ${contact.phoneNumber} ${contact.email != "" ? ", Email:${contact.email} " : ""} ")
                .printMessage();
            number++;
          });
        } else {
          GenericMessageImpl('Aucun contact enregistré.').printMessage();
        }
      });
    } catch (e) {
      GenericMessageError("Une erreur s'est produite : $e").printMessage();
    }
  }

  void search({required String searchContact}) {
    try {
      final contacts = contactRepository.getAllContacts();
      contacts.fold((error) => error.printMessage(), (contacts) {
        if (contacts.isEmpty) {
          GenericMessageImpl(
                  "Le repertoire est vide. Veuillez ajouter des contacts !")
              .printMessage();
          return;
        }
        if (contacts[searchContact] == null) {
          GenericMessageImpl(
                  "Aucun contact du repertoire ne correspond au numéro : $searchContact")
              .printMessage();
          return;
        }
        final contact = contacts[searchContact];
        GenericMessageImpl(
                " Contact trouvé : \nNom: ${contact!.firstName}, Prénom: ${contact.lastName}, Numéro: ${contact.phoneNumber} ${contact.email != null ? ", Email:${contact.email} " : ""}")
            .printMessage();
      });
    } catch (e) {
      print(e);
    }
  }

  void updateContact({required String updateNumber}) {
    final contacts = contactRepository.getAllContacts();
    contacts.fold((error) => error.printMessage(), (contacts) {
      if (contacts.isEmpty) {
        GenericMessageImpl(
                "Aucun contact trouvé. Veuillez ajouter des contacts !")
            .printMessage();
        return;
      }
      displayContacts();

      if (contacts[updateNumber] == null) {
        GenericMessageImpl(
                "Aucun contact du repertoire ne correspond au numéro : $updateNumber")
            .printMessage();
        return;
      }
      GenericMessageImpl(
              'Modification du contact : ${updateNumber.toString()}. \nLaissez vide pour conserver la valeur actuelle.')
          .printMessage();
      final updatedContact =
          contactRepository.updateContact(updateNumber: updateNumber);

      updatedContact.fold((error) => error.printMessage(), (updatedContact) {
        GenericMessageImpl(
                "Nom: ${updatedContact.firstName}, Prénom: ${updatedContact.lastName}, Numéro: ${updatedContact.phoneNumber} ${updatedContact.email != null ? ", Email:${updatedContact.email} " : ""} modifié avec succès.")
            .printMessage();
      });
    });
  }

  void removeContact({required String number}) {
    final contacts = contactRepository.getAllContacts();

    contacts.fold((error) => error.printMessage(), (contacts) {
      if (contacts.isEmpty) {
        GenericMessageImpl('Aucun contact à supprimer.').printMessage();
        return;
      }
      final result = contactRepository.deleteContact(contactToDelete: number);
      result.fold((error) => error.printMessage(), (result) {
        GenericMessageImpl('Contact $number supprimé avec succès.')
            .printMessage();
      });
    });
  }
}
