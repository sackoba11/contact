import '../core/utilities/input_controller/input_controller.dart';
import '../usecases/base_usecases.dart';

class Home {
  static void launch() {
    var baseusecases = BaseUsecases();
  

    while (true) {
      print('\nGestion des contacts:');
      print('1. Ajouter un contact');
      print('2. Afficher tous les contacts');
      print('3. Modifier un contact');
      print('4. Supprimer un contact');
      print('5. Quitter');

      String? choix = InputController.inputController(
          title: 'Choisissez une option (1-5): ');

      switch (choix) {
        case '1':
          baseusecases.addContact();
          break;
        case '2':
          baseusecases.displayContacts();
          break;
        case '3':
          baseusecases.updateContact();
          break;
        case '4':
          baseusecases.removeContact();
          break;
        case '5':
          print('Au revoir !');
          return;
        default:
          print('Option invalide. Veuillez réessayer.');
      }
    }
  }
}
