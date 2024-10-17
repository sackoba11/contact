import 'package:contact/models/contact.dart';

abstract class ContactRepository {
  bool addContact({required Contact newContact});
  Map<String, Contact>? getAllContacts();
  bool deleteContact({required String contactToDelete});
  Contact updateContact({required String updateNumber});
}
