import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'user.freezed.dart';

@freezed
class User with _$User{
  const factory User({
    required String id,
    required String title,
    required String firstName,
    required String lastName,
    required String gender,
    String? email,
    String? dateOfBirth,
    String? phone,
    required String picture,
}) = _User;
}