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
    final contactList = getAllContacts();
    if (contactList.isEmpty) {
      print('Aucun contact enregistré.');
    } else {
      for (var i = 0; i < contactList.length; i++) {
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
    final file = File(fileName);

    if (file.existsSync()) {
      // Lire le contenu actuel du fichier
      List<String> lines = file.readAsLinesSync();
      // Afficher le contenu actuel avec des numéros de ligne
      print('Contenu actuel du fichier:');
      if (lines.isNotEmpty) {
        for (int i = 0; i < lines.length; i++) {
          print('${i + 1}: ${lines[i]}');
        }
      } else {
        print("Aucun contact trouvé. Veuillez ajouter des contacts !");
        return;
      }

      // Demander à l'utilisateur quelle(s) ligne(s) supprimer
      stdout.write(
          'Entrez les numéros des lignes à supprimer (séparés par des virgules, ex: 1,3,5) : ');
      String input = stdin.readLineSync() ?? '';

      List<int> linesToDelete = input
          .split(',')
          .map((s) => int.tryParse(s.trim()) ?? 0)
          .where((n) => n > 0 && n <= lines.length)
          .toList();

      if (linesToDelete.isEmpty) {
        print('Aucune ligne valide à supprimer.');
        return;
      }

      // Trier les numéros de ligne dans l'ordre décroissant pour éviter les problèmes d'index
      linesToDelete.sort((a, b) => b.compareTo(a));

      // Supprimer les lignes spécifiées
      for (int lineNumber in linesToDelete) {
        lines.removeAt(lineNumber - 1);
        print('Ligne $lineNumber supprimée avec succès.');
      }

      // Écrire le contenu modifié dans le fichier
      file.writeAsStringSync(lines.join('\n'));
    } else {
      print("Veuillez réessayer.");
      return;
    }
  }

  @override
  void updateContact() {
    final contactList = getAllContacts();
    if (contactList.isNotEmpty) {
      // Afficher le contenu actuel avec des numéros de ligne
      displayContacts();
    } else {
      print("Aucun contact trouvé. Veuillez ajouter des contacts !");
      return;
    }
    // Demander à l'utilisateur quelle ligne modifier
    stdout.write(
        'Entrez le numéro de la ligne à modifier (1-${contactList.length}) : ');
    int lineNumber = int.tryParse(stdin.readLineSync() ?? '') ?? 0;

    if (lineNumber < 1 || lineNumber > contactList.length) {
      print('Numéro de ligne invalide.');
      return;
    }
    // Afficher la ligne actuelle
    var contact = contactList[lineNumber - 1];
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
    saveContacts();
    print('Contact modifié avec succès.');

    return;
  }
}
