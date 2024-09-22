import 'dart:convert';
import 'dart:io';

import 'package:contact/models/contact.dart';
import 'package:contact/repository_contacts/contacts_repository.dart';

class ContactsImpl implements ContactRepository {
  List<Contact> contacts = [];
  final String fileName = 'contacts.json';

  @override
  void addContact({required Contact newContact}) {
    Contact? contactExiste = searchContact(newContact.phoneNumber);

    if (contactExiste != null) {
      print(
          'Un contact avec ce numéro de téléphone ${contactExiste.phoneNumber} existe déjà.');
    } else {
      contacts.add(newContact);
      print('Contact ajouté avec succès : ${newContact.toString()}');
      saveContacts();
    }
  }

  Contact? searchContact(String newContact) {
    for (var contact in contacts) {
      if (contact.phoneNumber == newContact) {
        return contact;
      }
    }
    return null;
  }

  void saveContacts() {
    final file = File(fileName);
    final contentList = contacts.map((contact) => contact.toJson()).toList();
    final content = json.encode(contentList);
    file.writeAsStringSync(content);
    print('Contacts sauvegardés dans $fileName');
  }

  @override
  List<Contact> getAllContacts() {
    final file = File(fileName);
    if (file.existsSync()) {
      final contentString = file.readAsStringSync();
      final contentList = json.decode(contentString) as List;
      contacts =
          contentList.map((contact) => Contact.fromJson(contact)).toList();
      print('${contacts.length} contact(s) chargé(s) depuis $fileName');
      return contacts;
    } else {
      print('Aucun fichier de contacts trouvé. Une nouvelle liste sera créée.');
      return contacts;
    }
  }

  @override
  void displayContacts() {
    if (contacts.isEmpty) {
      print('Aucun contact enregistré.');
    } else {
      for (var i = 0; i < contacts.length; i++) {
        print('${i + 1}. ${contacts[i]}');
      }
    }
  }

  @override
  Contact editContact() {
    print('Saisie d\'un nouveau contact:');

    stdout.write('Nom: ');
    String firstName = stdin.readLineSync() ?? '';

    stdout.write('Prénom: ');
    String lastName = stdin.readLineSync() ?? '';

    stdout.write('Numéro de téléphone: ');
    String phoneNumber = stdin.readLineSync() ?? '';

    stdout.write('Email (optionnel, appuyez sur Entrée pour passer): ');
    String? email = stdin.readLineSync();
    email = email!.isEmpty ? null : email;

    return Contact(
      firstName: firstName,
      lastName: lastName,
      phoneNumber: phoneNumber,
      email: email,
    );
  }

  @override
  void deletteContact() {
    if (contacts.isEmpty) {
      print('Aucun contact à supprimer.');
      return;
    }
    displayContacts();
    // Demander à l'utilisateur quelle(s) ligne(s) supprimer
    stdout.write('Entrez le numéro du contact à supprimer : ');
    final input = int.tryParse(stdin.readLineSync() ?? '');
    if (input == null || input < 1 || input > contacts.length) {
      print('Choix invalide. veuillez réessayer !');
      return;
    }
    final delettecontact = contacts.removeAt(input - 1);
    saveContacts();
    print('Contact ${delettecontact.toString()} supprimé avec succès.');
    return;
  }

  @override
  void updateContact() {
    if (contacts.isNotEmpty) {
      // Afficher le contenu actuel avec des numéros de ligne
      displayContacts();
    } else {
      print("Aucun contact trouvé. Veuillez ajouter des contacts !");
      return;
    }
    // Demander à l'utilisateur quelle ligne modifier
    stdout.write(
        'Entrez le numéro de la ligne à modifier (1-${contacts.length}) : ');
    int lineNumber = int.tryParse(stdin.readLineSync() ?? '') ?? 0;

    if (lineNumber < 1 || lineNumber > contacts.length) {
      print('Numéro de ligne invalide.');
      return;
    }
    // Afficher la ligne actuelle
    var contact = contacts[lineNumber - 1];
    print('Modification du contact : ${contact.toString()}');
    print('Laissez vide pour conserver la valeur actuelle.');

    stdout.write('Nouveau nom (${contact.firstName}): ');
    final newFirstName = stdin.readLineSync();
    if (newFirstName?.isNotEmpty == true) {
      contact = contact.copyWith(firstName: newFirstName!);
    }
    stdout.write('Nouveau prénom (${contact.lastName}): ');
    final newLastName = stdin.readLineSync();
    if (newLastName?.isNotEmpty == true) {
      contact = contact.copyWith(lastName: newLastName!);
    }
    stdout.write('Nouveau numéro de téléphone (${contact.phoneNumber}): ');
    final newPhoneNumber = stdin.readLineSync();
    if (newPhoneNumber?.isNotEmpty == true) {
      contact = contact.copyWith(phoneNumber: newPhoneNumber!);
    }
    stdout.write('Nouvel email (${contact.email ?? "Non défini"}): ');
    final newEmail = stdin.readLineSync();
    if (newEmail?.isNotEmpty == true) {
      contact = contact.copyWith(email: newEmail!);
    } else if (newEmail == '') {
      contact = contact.copyWith(email: null);
    }
    print(contact.toJson());
    contacts[lineNumber - 1] = contact;
    saveContacts();
    print('Contact modifié avec succès.');
    return;
  }
}
