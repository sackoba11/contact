import 'package:contact/models/contact.dart';

import '../core/helpers/usage/usage.dart';
import '../core/utilities/contact_manager/contact_manager.dart';
import '../core/utilities/generic_message/generic_message.dart';
import '../usecases/base_usecases.dart';

class Home {
  static void launch({required String choix, required List<String> args}) {
    var baseusecases = BaseUsecases();

    switch (choix) {
      case '-add':
        if (args.isEmpty) {
          GenericMessageImpl('Veuillez saisir au moins un numéro!')
              .printMessage();
          return;
        }
        Contact newContact = ContactManager.createContactWithArgs(args: args);
        baseusecases.addContact(newContact: newContact);
        break;
      case '-display':
        baseusecases.displayContacts();
        break;
      case '-update':
        if (args.isEmpty || args.length > 1) {
          GenericMessageImpl('Veuillez ajouter le numéro à modifier.')
              .printMessage();
          return;
        }
        
        baseusecases.updateContact(updateNumber: args[0]);
        break;
      case '-remove':
        baseusecases.removeContact(number: args[0]);
        break;

      default:
        GenericMessageImpl('Option invalide. Veuillez réessayer.').getMessage();
        Usage.printUsage();
        return;
    }
  }
}
// }
