import 'dart:convert';

import '../../../domain/entities/user/user_entity.dart';
import 'package:meta/meta.dart';

class UserModel extends UserEntity {
  UserModel({
    @required id,
    @required email,
    @required first_name,
    @required last_name,
    @required avatar,
  }) : super(
            id: id,
            email: email,
            first_name: first_name,
            last_name: last_name,
            avatar: avatar);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'first_name': first_name,
      'last_name': last_name,
      'avatar': avatar,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return UserModel(
      id: map['id'],
      email: map['email'],
      first_name: map['first_name'],
      last_name: map['last_name'],
      avatar: map['avatar'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));
}
