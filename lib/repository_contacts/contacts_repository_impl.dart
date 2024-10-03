import 'dart:convert';
import 'dart:io';

import 'package:contact/models/contact.dart';
import 'package:contact/repository_contacts/contacts_repository.dart';

import '../core/utilities/save_contact/save_contact.dart';

class ContactsImpl implements ContactRepository {
  @override
  void addContact({required Contact newContact}) {
    SaveContact.contacts[newContact.phoneNumber.toString()] = newContact;
    print(
        'Contact ajouté avec succès :  Nom: ${newContact.firstName}, Prénom: ${newContact.lastName}, Numéro: ${newContact.phoneNumber} ${newContact.email != null ? ", Email:${newContact.email} " : ""} "');
    SaveContact.saveContacts();
  }

  @override
  Map<String, Contact> getAllContacts() {
    final file = File(SaveContact.fileName);
    if (file.existsSync()) {
      final contentString = file.readAsStringSync();
      final contentList = json.decode(contentString) as List;
      SaveContact.contacts
        ..clear()
        ..addEntries(contentList.map((contact) {
          final formattedContact = Contact.fromJson(contact);
          return MapEntry(formattedContact.phoneNumber, formattedContact);
        }));
      print(
          '${SaveContact.contacts.length} contact(s) chargé(s) depuis ${SaveContact.fileName}');
      return SaveContact.contacts;
    } else {
      print('Aucun fichier de contacts trouvé. Une nouvelle liste sera créée.');
      return SaveContact.contacts;
    }
  }

  void displayContacts() {
    if (SaveContact.contacts.isEmpty) {
      print('Aucun contact enregistré.');
    } else {
      print(SaveContact.contacts);
      // for (var i = 0; i < SaveContact.contacts.length; i++) {
      //   print(
      //       "${i + 1}: Nom: ${SaveContact.contact.firstName}, Prénom: ${SaveContact.contacts[i].lastName}, Numéro: ${contacts[i].phoneNumber} ${contacts[i].email != null ? ", Email:${contacts[i].email} " : ""} ");
      // }
    }
  }

  @override
  void deleteContact() {
    if (SaveContact.contacts.isEmpty) {
      print('Aucun contact à supprimer.');
      return;
    }
    displayContacts();
    // Demander à l'utilisateur quelle(s) ligne(s) supprimer
    stdout.write('Entrez le numéro du contact à supprimer : ');
    final input = int.tryParse(stdin.readLineSync() ?? '');
    if (input == null || input < 1 || input > SaveContact.contacts.length) {
      print('Choix invalide. veuillez réessayer !');
      return;
    }
    // final delettecontact = contacts.removeAt(input - 1);
    SaveContact.saveContacts();
    // print('Contact ${delettecontact.phoneNumber} supprimé avec succès.');
    return;
  }

  @override
  void updateContact() {
    if (SaveContact.contacts.isNotEmpty) {
      // Afficher le contenu actuel avec des numéros de ligne
      displayContacts();
    } else {
      print("Aucun contact trouvé. Veuillez ajouter des contacts !");
      return;
    }
    // Demander à l'utilisateur quelle ligne modifier
    stdout.write(
        'Entrez le numéro de la ligne à modifier (1-${SaveContact.contacts.length}) : ');
    int lineNumber = int.tryParse(stdin.readLineSync() ?? '') ?? 0;

    if (lineNumber < 1 || lineNumber > SaveContact.contacts.length) {
      print('Numéro de ligne invalide.');
      return;
    }
    // Afficher la ligne actuelle
    var contact = SaveContact.contacts[lineNumber - 1];
    print('Modification du contact : ${contact.toString()}');
    print('Laissez vide pour conserver la valeur actuelle.');

    // stdout.write('Nouveau nom (${contact.firstName}): ');
    // final newFirstName = stdin.readLineSync();
    // if (newFirstName?.isNotEmpty == true) {
    //   contact = contact.copyWith(firstName: newFirstName!);
    // }
    // stdout.write('Nouveau prénom (${contact.lastName}): ');
    // final newLastName = stdin.readLineSync();
    // if (newLastName?.isNotEmpty == true) {
    //   contact = contact.copyWith(lastName: newLastName!);
    // }
    // stdout.write('Nouveau numéro de téléphone (${contact.phoneNumber}): ');
    // final newPhoneNumber = stdin.readLineSync();
    // if (newPhoneNumber?.isNotEmpty == true) {
    //   contact = contact.copyWith(phoneNumber: newPhoneNumber!);
    // }
    // stdout.write('Nouvel email (${contact.email ?? "Non défini"}): ');
    // final newEmail = stdin.readLineSync();
    // if (newEmail?.isNotEmpty == true) {
    //   contact = contact.copyWith(email: newEmail!);
    // }

    // contacts[lineNumber - 1] = contact;
    SaveContact.saveContacts();
    print("");
    // "Nom: ${contact.firstName}, Prénom: ${contact.lastName}, Numéro: ${contact.phoneNumber} ${contact.email != null ? ", Email:${contact.email} " : ""} ");
    print('Contact modifié avec succès.');
    return;
  }
}
