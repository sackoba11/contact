import 'package:contact/models/contact.dart';

abstract class ContactRepository {
  void addContact({required Contact newContact});
  Map<String, Contact> getAllContacts();

  void deleteContact();
  void updateContact();
}
