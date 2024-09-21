import 'package:freezed_annotation/freezed_annotation.dart';

part 'contact.freezed.dart';
part 'contact.g.dart';

@freezed
class Contact with _$Contact {
  factory Contact({
    required String firstName,
    required String lastName,
    required String phoneNumber,
    required String? email,
  }) = _Contact;
  factory Contact.fromJson(Map<String, dynamic> json) =>
      _$ContactFromJson(json);
}
