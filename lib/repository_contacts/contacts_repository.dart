import 'package:contact/models/contact.dart';

abstract class ContactRepository {
  void addContact({required Contact nouveauContact});
  List<Contact> getAllContacts();
  void displayContacts();
  Contact editContact();
  void deletteContact();
  void updateContact();
}
