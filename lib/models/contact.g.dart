// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contact.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ContactImpl _$$ContactImplFromJson(Map<String, dynamic> json) =>
    _$ContactImpl(
      nom: json['nom'] as String,
      prenom: json['prenom'] as String,
      numeroTelephone: json['numeroTelephone'] as String,
      email: json['email'] as String?,
    );

Map<String, dynamic> _$$ContactImplToJson(_$ContactImpl instance) =>
    <String, dynamic>{
      'nom': instance.nom,
      'prenom': instance.prenom,
      'numeroTelephone': instance.numeroTelephone,
      'email': instance.email,
    };
