import 'dart:convert';
import 'dart:io';

import 'package:contact/core/utilities/generic_message/generic_message.dart';

import '../../../models/contact.dart';

abstract class ContactStorageManager {
  void saveContacts({required Map<String, Contact> contacts});
  List? readContact();
}

class ContactStorageManagerImpl implements ContactStorageManager {
  final String fileName = 'contacts.json';

  @override
  void saveContacts({required Map<String, Contact> contacts}) {
    final file = File(fileName);
    final contentList =
        contacts.entries.map((contact) => contact.value.toJson()).toList();
    final content = json.encode(contentList);
    file.writeAsStringSync(content);
    PrintGenericMessage('Contacts sauvegardés dans $fileName').getMessage();
  }

  @override
  List? readContact() {
    final file = File(fileName);
    if (file.existsSync()) {
      final contentString = file.readAsStringSync();
      final contentList = json.decode(contentString) as List;

      return contentList;
    } else {
      PrintGenericMessage(
              "Aucun fichier de contacts trouvé. Une nouvelle liste sera créée lors d'un ajout de contact")
          .getMessage();
    }
    return [];
  }
}
