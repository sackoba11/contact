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
        final newContact = ContactManager.createContactWithArgs(args: args);
        newContact.fold((error) => error.printMessage(), (newContact) {
          baseusecases.addContact(newContact: newContact);
        });
        break;
      case '-display':
        baseusecases.displayContacts();
        break;

      case '-search':
        if (args.isEmpty || args.length > 1) {
          GenericMessageImpl('Veuillez saisir le numéro à chercher.')
              .printMessage();
          break;
        }
        baseusecases.search(searchContact: args[0]);
        break;
      case '-update':
        if (args.isEmpty || args.length > 1) {
          GenericMessageImpl('Veuillez ajouter le numéro à modifier.')
              .printMessage();
          break;
        }
        baseusecases.updateContact(updateNumber: args[0]);
        break;
      case '-remove':
        if (args.isEmpty || args.length > 1) {
          GenericMessageImpl('Veuillez ajouter le numéro à supprimer.')
              .printMessage();
          break;
        }
        baseusecases.removeContact(number: args[0]);
        break;

      default:
        GenericMessageImpl('Option invalide. Veuillez réessayer.')
            .printMessage();
        Usage.printUsage();
        break;
    }
  }
}
