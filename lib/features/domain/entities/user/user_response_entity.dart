import 'package:equatable/equatable.dart';

import './user_entity.dart';

class UserResponseEntity extends Equatable {
  final List<UserEntity> data;
  final int page;
  final int per_page;
  final int total;
  final int total_pages;

  UserResponseEntity({
    this.data,
    this.page,
    this.per_page,
    this.total,
    this.total_pages,
  });

  @override
  List<Object> get props {
    return [
      data,
      page,
      per_page,
      total,
      total_pages,
    ];
  }
}
