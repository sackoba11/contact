import 'dart:io';

import 'package:contact/models/contact.dart';
import 'package:contact/repository_contacts/contacts_repository.dart';

import '../core/utilities/contact_storage_manager/contact_storage_manager.dart';

class ContactsRepositoryImpl implements ContactRepository {
  ContactStorageManager contactStorageManager = ContactStorageManagerImpl();
  Map<String, Contact> contacts = {};

  @override
  Contact? addContact({required Contact newContact}) {
    try {
      contacts[newContact.phoneNumber.toString()] = newContact;
      contactStorageManager.saveContacts(contacts: contacts);
      return newContact;
    } catch (e) {
      print(e);
    }
    return null;
  }

  @override
  Map<String, Contact>? getAllContacts() {
    try {
      contacts = contactStorageManager.readContact()!;
      return contacts;
    } catch (e) {
      print(e);
    }
    return null;
  }

  @override
  void deleteContact({required String contactToDelete}) {
    try {
      contacts.remove(contactToDelete);
      contactStorageManager.saveContacts(contacts: contacts);
    } catch (e) {
      print(e);
    }

    return;
  }

  @override
  void updateContact({required Map<String, Contact> contactsUpdated}) {
    contactStorageManager.saveContacts(contacts: contactsUpdated);
  }
}
