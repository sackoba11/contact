import 'package:contact/core/utilities/generic_message/generic_message.dart';
import 'package:contact/models/contact.dart';
import 'package:contact/repository_contacts/contacts_repository.dart';

import '../core/utilities/contact_manager/contact_manager.dart';
import '../core/utilities/contact_storage_manager/contact_storage_manager.dart';

class ContactsRepositoryImpl implements ContactRepository {
  ContactStorageManager contactStorageManager = ContactStorageManagerImpl();
  Map<String, Contact> contacts = {};

  @override
  Contact? addContact({required Contact newContact}) {
    try {
      getAllContacts();
      contacts[newContact.phoneNumber.toString()] = newContact;
      contactStorageManager.saveContacts(contacts: contacts);
      return newContact;
    } catch (e) {
      PrintGenericMessageError("Une erreur s'est produite : $e").getMessage();
    }
    return null;
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
  void deleteContact({required String contactToDelete}) {
    try {
      contacts.remove(contactToDelete);
      contactStorageManager.saveContacts(contacts: contacts);
    } catch (e) {
      PrintGenericMessageError("Une erreur s'est produite : $e").getMessage();
    }

    return;
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
