import '../../../models/contact.dart';
import '../../helpers/email_formater/email_formater.dart';
import '../../helpers/phone_number_formater/phone_number_formater.dart';
import '../input_controller/input_controller.dart';

class CreateContact {
  static Contact createContact() {
    print("Saisie d'un nouveau contact:");

    String firstName = InputController.inputController(title: 'Nom: ');

    String lastName = InputController.inputController(title: 'Prénom: ');

    String phoneNumber =
        PhoneNumberFormater.formatPhoneNumber(title: 'Numéro de téléphone: ')!;

    String? email = EmailFormater.formatEmail(title: 'Adresse e-mail: ');

    return Contact(
      firstName: firstName,
      lastName: lastName,
      phoneNumber: phoneNumber,
      email: email,
    );
  }
}
