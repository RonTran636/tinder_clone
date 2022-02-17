// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_User _$$_UserFromJson(Map<String, dynamic> json) => _$_User(
      id: json['id'] as String,
      title: json['title'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      age: json['age'] as int?,
      gender: json['gender'] as String?,
      email: json['email'] as String?,
      dateOfBirth: json['dateOfBirth'] as String?,
      phone: json['phone'] as String?,
      picture: json['picture'] as String,
    );

Map<String, dynamic> _$$_UserToJson(_$_User instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'age': instance.age,
      'gender': instance.gender,
      'email': instance.email,
      'dateOfBirth': instance.dateOfBirth,
      'phone': instance.phone,
      'picture': instance.picture,
    };
