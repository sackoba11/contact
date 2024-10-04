import 'dart:io';

import 'package:contact/core/utilities/update_data_contact/update_data_contact.dart';
import 'package:contact/repository_contacts/contacts_repository.dart';

import '../core/helpers/phone_number_formater/phone_number_formater.dart';
import '../core/utilities/contact_storage_manager/contact_storage_manager.dart';
import '../models/contact.dart';
import '../repository_contacts/contacts_repository_impl.dart';

class BaseUsecases {
  Map<String, Contact>? contacts = {};

  ContactRepository contactRepository = ContactsRepositoryImpl();
  var contactStorageManager = ContactStorageManagerImpl();

  void addContact({required Contact newContact}) {
    var contact = contactRepository.addContact(newContact: newContact);
    if (contact != null) {
      print(
          'Contact ajouté avec succès : Nom: ${contact.firstName}, Prénom: ${contact.lastName}, Numéro: ${contact.phoneNumber} ${contact.email != null ? ", Email:${contact.email} " : ""}');
    } else {
      print("Impossible d'ajouter ce contact");
    }
  }

  void displayContacts() {
    contacts = contactRepository.getAllContacts();

    if (contacts != null) {
      print(
          '${contacts!.length} contact(s) chargé(s) depuis ${contactStorageManager.fileName}');

      var number = 1;
      contacts!.forEach((key, contact) {
        print(
            "$number : Nom: ${contact.firstName}, Prénom: ${contact.lastName}, Numéro: ${contact.phoneNumber} ${contact.email != null ? ", Email:${contact.email} " : ""} ");
        number++;
      });
    } else {
      print('Aucun contact enregistré.');
    }
  }

  void updateContact() {
    contacts = contactRepository.getAllContacts();
    if (contacts!.isNotEmpty) {
      // Afficher le contenu actuel avec des numéros de ligne
      displayContacts();
    } else {
      print("Aucun contact trouvé. Veuillez ajouter des contacts !");
      return;
    }

    // Demander à l'utilisateur quel numéro modifier
    stdout.write(
        'Entrez le numéro à modifier parmi le(s) numéro(s) ci-dessus : ');
    String updateNumber = PhoneNumberFormater.formatPhoneNumber()!;

    var contactupdate = contacts![updateNumber];

    if (contactupdate != null) {
      print('Modification du contact : ${updateNumber.toString()}');
      print('Laissez vide pour conserver la valeur actuelle.');
      var updatedContact =
          UpdateDatacontact.updateDataContact(contactToUpdate: contactupdate);
      contacts![updateNumber] = updatedContact;
      contactRepository.updateContact(contactsUpdated: contacts!);
      print(
          "Nom: ${updatedContact.firstName}, Prénom: ${updatedContact.lastName}, Numéro: ${updatedContact.phoneNumber} ${updatedContact.email != null ? ", Email:${updatedContact.email} " : ""} ");
      print('Contact modifié avec succès.');
    } else {
      print("Aucun contact ne correspond au contact : $updateNumber");
    }
  }

  void removeContact() {
    if (contacts!.isEmpty) {
      print('Aucun contact à supprimer.');
      return;
    }

    displayContacts();
    stdout.write('Entrez le numéro du contact à supprimer : ');
    var contactToDelete = PhoneNumberFormater.formatPhoneNumber();

    contactRepository.deleteContact(contactToDelete: contactToDelete!);
    print('Contact $contactToDelete supprimé avec succès.');
  }
}
