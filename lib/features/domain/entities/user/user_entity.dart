import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class UserEntity extends Equatable {
  final int id;
  final String email;
  final String first_name;
  final String last_name;
  final String avatar;

  UserEntity({
    @required this.id,
    @required this.email,
    @required this.first_name,
    @required this.last_name,
    @required this.avatar,
  });

  @override
  List<Object> get props {
    return [
      id,
      email,
      first_name,
      last_name,
      avatar,
    ];
  }
}
