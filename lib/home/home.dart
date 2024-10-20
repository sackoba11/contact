import 'package:contact/models/contact.dart';

import '../core/helpers/usage/usage.dart';
import '../core/utilities/contact_manager/contact_manager.dart';
import '../core/utilities/generic_message/generic_message.dart';
// import '../core/utilities/input_controller/input_controller.dart';
import '../usecases/base_usecases.dart';

class Home {
  static void launch({required String choix, required List<String> args}) {
    var baseusecases = BaseUsecases();

    // while (true) {
    // print('\nGestion des contacts:');
    // print('1. Ajouter un contact');
    // print('2. Afficher tous les contacts');
    // print('3. Modifier un contact');
    // print('4. Supprimer un contact');
    // print('5. Quitter');

    // String? choix = InputController.inputController(
    //     title: 'Choisissez une option (1-5): ');

    switch (choix) {
      case '-add':
        Contact newContact = ContactManager.createContact();
        baseusecases.addContact(newContact: newContact);
        break;
      case '-display':
        baseusecases.displayContacts();
        break;
      case '-update':
        baseusecases.updateContact();
        break;
      case '-delete':
        baseusecases.removeContact();
        break;
      // case '5':
      //   print('Au revoir !');
      //   return;
      default:
        PrintGenericMessage('Option invalide. Veuillez réessayer.').getMessage();
        Usage.printUsage();
        return;
    }
  }
}
// }
