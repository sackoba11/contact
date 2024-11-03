import 'dart:convert';
import 'dart:io';

import 'package:contact/core/helpers/config/storage_config.dart';
import 'package:contact/core/utilities/generic_message/generic_message.dart';

import '../../../models/contact.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart' as p;

abstract class ContactStorageManager {
  void saveContacts({required Map<String, Contact> contacts});
  List? readContact();
}

class ContactStorageManagerImpl implements ContactStorageManager {
  final path = p.join(p.current, "lib", "data", StorageConfig.storageFileName);

  @override
  void saveContacts({required Map<String, Contact> contacts}) {
    final file = File(path);
    final contentList =
        contacts.entries.map((contact) => contact.value.toJson()).toList();
    final content = json.encode(contentList);
    file.writeAsStringSync(content);
    GenericMessageImpl(
            'Contacts sauvegardés dans ${StorageConfig.storageFileName}')
        .getMessage();
  }

  @override
  List? readContact() {
    final file = File(path);
    if (file.existsSync()) {
      final contentString = file.readAsStringSync();
      final contentList = json.decode(contentString) as List;
      return contentList;
    }
    return [];
  }
}
