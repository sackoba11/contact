import '../models/contact.dart';

class BaseUsecases {
  Map<String, Contact> contacts = {};

  void addContact() {

    
  }

  void displayContacts({required Map<String, Contact> contacts}) {}

  void updateContact({required newContact}) {}

  void removeContact({required String idContact}) {}
}
