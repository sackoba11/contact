import 'package:contact/core/utilities/generic_message/generic_message.dart';
import 'package:contact/models/contact.dart';
import 'package:dartz/dartz.dart';

abstract class ContactRepository {
  Either<GenericMessage, bool> addContact({required Contact newContact});
  Either<GenericMessage, Map<String, Contact>> getAllContacts();
  Either<GenericMessage, Contact> updateContact({required String updateNumber});
  Either<GenericMessage, bool> deleteContact({required String contactToDelete});
}
