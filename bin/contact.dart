import 'dart:io';
import 'package:contact/core/utilities/create_contact/create_contact.dart';
import 'package:contact/repository_contacts/contacts_repository_impl.dart';

void main(List<String> arguments) {
  var gestionContacts = ContactsImpl();
  gestionContacts.getAllContacts();

  while (true) {
    print('\nGestion des contacts:');
    print('1. Ajouter un contact');
    print('2. Afficher tous les contacts');
    print('3. Modifier un contact');
    print('4. Supprimer un contact');
    print('5. Quitter');
    stdout.write('Choisissez une option (1-5): ');

    String? choix = stdin.readLineSync();
    switch (choix) {
      case '1':
        var nouveauContact = CreateContact.createContact();
        gestionContacts.addContact(newContact: nouveauContact);
        break;
      case '2':
        gestionContacts.displayContacts();
        break;
      case '3':
        gestionContacts.updateContact();
        break;
      case '4':
        gestionContacts.deleteContact();
        break;
      case '5':
        print('Au revoir !');
        return;
      default:
        print('Option invalide. Veuillez réessayer.');
    }
  }
}
