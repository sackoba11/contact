import 'package:contact/core/utilities/generic_message/generic_message.dart';
import 'package:contact/models/contact.dart';
import 'package:contact/repository_contacts/contacts_repository.dart';

import '../core/utilities/contact_manager/contact_manager.dart';
import '../core/utilities/contact_storage_manager/contact_storage_manager.dart';

class ContactsRepositoryImpl implements ContactRepository {
  ContactStorageManager contactStorageManager = ContactStorageManagerImpl();
  Map<String, Contact> contacts = {};

  @override
  bool addContact({required Contact newContact}) {
    try {
      getAllContacts();
      if (contacts[newContact.phoneNumber.toString()] != null) {
        PrintGenericMessageError("Ce numéro exitse déjà.").getMessage();
        return false;
      } else {
        contacts[newContact.phoneNumber.toString()] = newContact;
        contactStorageManager.saveContacts(contacts: contacts);
      }
      return true;
    } catch (e) {
      PrintGenericMessageError("Une erreur s'est produite : $e").getMessage();
    }
    return false;
  }

  @override
  Map<String, Contact>? getAllContacts() {
    try {
      final contentList = contactStorageManager.readContact()!;
      contacts
        ..clear()
        ..addEntries(contentList.map((contact) {
          final formattedContact = Contact.fromJson(contact);
          return MapEntry(formattedContact.phoneNumber, formattedContact);
        }));
      return contacts;
    } catch (e) {
      PrintGenericMessageError("Une erreur s'est produite : $e").getMessage();
    }
    return null;
  }

  @override
  bool deleteContact({required String contactToDelete}) {
    try {
      if (contacts[contactToDelete] != null) {
        contacts.remove(contactToDelete);
        contactStorageManager.saveContacts(contacts: contacts);
        return true;
      } else {
        PrintGenericMessageError("Ce numéro n'exitse pas dans le repertoire.")
            .getMessage();
        return false;
      }
    } catch (e) {
      PrintGenericMessageError("Une erreur s'est produite : $e").getMessage();
    }

    return false;
  }

  @override
  Contact updateContact({required String updateNumber}) {
    final contactToUpdate = contacts[updateNumber];
    final updatedContact =
        ContactManager.updateDataContact(contactToUpdate: contactToUpdate!);
    contacts[updateNumber] = updatedContact;
    contactStorageManager.saveContacts(contacts: contacts);

    return updatedContact;
  }
}
