import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class UserEntity extends Equatable {
  final int id;
  final String email;
  final String firstName;
  final String lastName;
  final String avatar;

  UserEntity({
    @required this.id,
    @required this.email,
    @required this.firstName,
    this.lastName,
    this.avatar,
  }) : assert(id != null && email != null && firstName != null);

  @override
  List<Object> get props {
    return [
      id,
      email,
      firstName,
      lastName,
      avatar,
    ];
  }
}
