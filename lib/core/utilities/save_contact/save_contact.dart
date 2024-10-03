import 'dart:convert';
import 'dart:io';

import '../../../models/contact.dart';

class SaveContact {
  static final String fileName = 'contacts.json';
  static Map<String, Contact> contacts = {};

  static void saveContacts() {
    final file = File(fileName);
    final contentList =
        contacts.entries.map((contact) => contact.value.toJson()).toList();
    final content = json.encode(contentList);
    file.writeAsStringSync(content);
    print('Contacts sauvegardés dans $fileName');
  }
}
