import 'package:contact/core/utilities/generic_message/generic_message.dart';
import 'package:contact/models/contact.dart';
import 'package:contact/repository_contacts/contacts_repository.dart';
import 'package:dartz/dartz.dart';

import '../core/utilities/contact_manager/contact_manager.dart';
import '../core/utilities/contact_storage_manager/contact_storage_manager.dart';

class ContactsRepositoryImpl implements ContactRepository {
  ContactStorageManager contactStorageManager = ContactStorageManagerImpl();
  Map<String, Contact> contacts = {};

  @override
  Either<GenericMessage, bool> addContact({required Contact newContact}) {
    try {
      getAllContacts();
      if (contacts[newContact.phoneNumber.toString()] != null) {
        return left(GenericMessageError("Ce numéro exitse déjà."));
      } else {
        contacts[newContact.phoneNumber.toString()] = newContact;
        contactStorageManager.saveContacts(contacts: contacts);
        return right(true);
      }
    } catch (e) {
      return left(GenericMessageError("Une erreur s'est produite : \n$e"));
    }
  }

  @override
  Either<GenericMessage, Map<String, Contact>> getAllContacts() {
    try {
      final contentList = contactStorageManager.readContact()!;
      contacts
        ..clear()
        ..addEntries(contentList.map((contact) {
          final formattedContact = Contact.fromJson(contact);
          return MapEntry(formattedContact.phoneNumber, formattedContact);
        }));
      return right(contacts);
    } catch (e) {
      return left(GenericMessageError("Une erreur s'est produite : \n $e"));
    }
  }

  @override
  Either<GenericMessage, Contact> updateContact(
      {required String updateNumber}) {
    try {
      final contactToUpdate = contacts[updateNumber];
      final updatedContact =
          ContactManager.updateDataContact(contactToUpdate: contactToUpdate!);
      contacts[updateNumber] = updatedContact;
      contactStorageManager.saveContacts(contacts: contacts);

      return right(updatedContact);
    } catch (e) {
      return left(GenericMessageError("Une erreur s'est produite : \n$e"));
    }
  }

  @override
  Either<GenericMessage, bool> deleteContact(
      {required String contactToDelete}) {
    try {
      if (contacts[contactToDelete] != null) {
        contacts.remove(contactToDelete);
        contactStorageManager.saveContacts(contacts: contacts);
        return right(true);
      } else {
        return left(
            GenericMessageError("Ce numéro n'exitse pas dans le repertoire."));
      }
    } catch (e) {
      return left(GenericMessageError("Une erreur s'est produite : \n$e"));
    }
  }
}
