import 'package:contact/models/contact.dart';

abstract class ContactRepository {
  Contact? addContact({required Contact newContact});
  Map<String, Contact>? getAllContacts();
  void deleteContact({required String contactToDelete});
  void updateContact({required Map<String, Contact> contactsUpdated});
}
