import 'dart:convert';
import 'dart:io';

import '../../../models/contact.dart';

abstract class ContactStorageManager {
  void saveContacts({required Map<String, Contact> contacts});
  Map<String, Contact>? readContact();
}

class ContactStorageManagerImpl implements ContactStorageManager {
  final String fileName = 'contacts.json';
  static Map<String, Contact> contacts = {};

  @override
  void saveContacts({required Map<String, Contact> contacts}) {
    final file = File(fileName);
    final contentList =
        contacts.entries.map((contact) => contact.value.toJson()).toList();
    final content = json.encode(contentList);
    file.writeAsStringSync(content);
    print('Contacts sauvegardés dans $fileName');
  }

  @override
  Map<String, Contact>? readContact() {
    final file = File(fileName);
    if (file.existsSync()) {
      final contentString = file.readAsStringSync();
      final contentList = json.decode(contentString) as List;
      contacts
        ..clear()
        ..addEntries(contentList.map((contact) {
          final formattedContact = Contact.fromJson(contact);
          return MapEntry(formattedContact.phoneNumber, formattedContact);
        }));
      return contacts;
    } else {
      print(
          "Aucun fichier de contacts trouvé. Une nouvelle liste sera créée lors d'un ajout de contact");
    }
    return contacts;
  }
}
