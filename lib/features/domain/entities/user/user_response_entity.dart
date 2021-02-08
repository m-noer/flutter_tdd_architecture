import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

import 'user_entity.dart';

class UserResponseEntity extends Equatable {
  final List<UserEntity> data;
  final int page;
  final int perPage;
  final int total;
  final int totalPages;

  UserResponseEntity({
    this.data,
    @required this.page,
    @required this.perPage,
    @required this.total,
    @required this.totalPages,
  }) : assert(page != null &&
            perPage != null &&
            total != null &&
            totalPages != null);

  @override
  List<Object> get props {
    return [
      data,
      page,
      perPage,
      total,
      totalPages,
    ];
  }
}
