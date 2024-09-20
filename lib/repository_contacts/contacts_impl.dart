import 'dart:convert';
import 'dart:io';

import 'package:contact/models/contact.dart';
import 'package:contact/repository_contacts/contacts_repository.dart';

class ContactsImpl implements ContactRepository {
  List<Contact> contacts = [];
  final String nomFichier = 'contacts.txt';

  @override
  void addContact({required Contact nouveauContact}) {
    Contact? contactExiste = searchContact(nouveauContact.numeroTelephone);

    if (contactExiste != null) {
      print(
          'Un contact avec ce numéro de téléphone ${contactExiste.numeroTelephone} existe déjà.');
    } else {
      contacts.add(nouveauContact);
      print('Contact ajouté avec succès : ${nouveauContact.toString()}');
      sauvegarderContacts();
    }
  }

  Contact? searchContact(String nouveauContact) {
    for (var contact in contacts) {
      if (contact.numeroTelephone == nouveauContact) {
        return contact;
      }
    }
    return null;
  }

  void sauvegarderContacts() {
    final file = File(nomFichier);
    final content =
        contacts.map((contact) => json.encode(contact.toJson())).join('\n');
    file.writeAsStringSync(content);
    print('Contacts sauvegardés dans $nomFichier');
  }

  @override
  List<Contact> getAllContacts() {
    final file = File(nomFichier);
    if (file.existsSync()) {
      final content = file.readAsStringSync();
      contacts = content
          .split('\n')
          .where((line) => line.isNotEmpty)
          .map((line) => Contact.fromJson(json.decode(line)))
          .toList();
      print('${contacts.length} contact(s) chargé(s) depuis $nomFichier');
      return contacts;
    } else {
      print('Aucun fichier de contacts trouvé. Une nouvelle liste sera créée.');
      return contacts;
    }
  }

  @override
  void displayContacts() {
    final file = File(nomFichier);
    final content = file.readAsStringSync();
    if (content.isEmpty) {
      print('Aucun contact enregistré.');
    } else {
      contacts = content
          .split('\n')
          .where((line) => line.isNotEmpty)
          .map((line) => Contact.fromJson(json.decode(line)))
          .toList();
      for (var i = 0; i < contacts.length; i++) {
        print('${i + 1}. ${contacts[i]}');
      }
    }
  }

  @override
  Contact editContact() {
    print('Saisie d\'un nouveau contact:');

    stdout.write('Nom: ');
    String nom = stdin.readLineSync() ?? '';

    stdout.write('Prénom: ');
    String prenom = stdin.readLineSync() ?? '';

    stdout.write('Numéro de téléphone: ');
    String numeroTelephone = stdin.readLineSync() ?? '';

    stdout.write('Email (optionnel, appuyez sur Entrée pour passer): ');
    String? email = stdin.readLineSync();
    email = email!.isEmpty ? null : email;

    return Contact(
      nom: nom,
      prenom: prenom,
      numeroTelephone: numeroTelephone,
      email: email,
    );
  }

  @override
  void deletteContact() {
    final file = File(nomFichier);

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
    final file = File(nomFichier);
    if (file.existsSync()) {
      // Lire le contenu actuel du fichier
      List<String> lines = file.readAsLinesSync();
      // Afficher le contenu actuel avec des numéros de ligne
      print('Contenu actuel du fichier:');
      if (lines.isNotEmpty) {
        print(lines.length);
        for (int i = 0; i < lines.length; i++) {
          print('${i + 1}: ${lines[i]}');
        }
      } else {
        print("Aucun contact trouvé. Veuillez ajouter des contacts !");
        return;
      }

      // Demander à l'utilisateur quelle ligne modifier
      stdout.write(
          'Entrez le numéro de la ligne à modifier (1-${lines.length}) : ');
      int lineNumber = int.tryParse(stdin.readLineSync() ?? '') ?? 0;

      if (lineNumber < 1 || lineNumber > lines.length) {
        print('Numéro de ligne invalide.');
        return;
      }
      // Afficher la ligne actuelle
      print('Ligne actuelle: ${lines[lineNumber - 1]}');

      // Demander le nouveau contenu pour cette ligne
      stdout.write('Entrez le nouveau contenu pour cette ligne : ');
      Contact newContent = editContact();

      // Modifier la ligne spécifiée
      lines[lineNumber - 1] = json.encode(newContent.toJson());

      // Écrire le contenu modifié dans le fichier
      file.writeAsStringSync(lines.join('\n'));
      print('La ligne $lineNumber a été modifiée avec succès.');
      return;
    }
  }
}
