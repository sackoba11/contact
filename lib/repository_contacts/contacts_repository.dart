import 'package:contact/models/contact.dart';

abstract class ContactRepository {
  void addContact({required Contact newContact});
  List<Contact> getAllContacts();
  void displayContacts();
  Contact editContact();
  void deletteContact();
  void updateContact();
}
