import 'dart:convert';

import 'package:flutter_tdd_architecture/features/data/models/user/user_model.dart';
import 'package:flutter_tdd_architecture/features/domain/entities/user/user_response_entity.dart';
import 'package:meta/meta.dart';

class ListUser extends UserResponseEntity {
  final List<UserModel> data;
  final int page;
  final int per_page;
  final int total;
  final int total_pages;

  ListUser({
    @required this.data,
    @required this.page,
    @required this.per_page,
    @required this.total,
    @required this.total_pages,
  }) : super(
          data: data,
          page: page,
          per_page: per_page,
          total: total,
          total_pages: total_pages,
        );

  Map<String, dynamic> toMap() {
    return {
      'data': data?.map((x) => x?.toMap())?.toList(),
      'page': page,
      'per_page': per_page,
      'total': total,
      'total_pages': total_pages,
    };
  }

  factory ListUser.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return ListUser(
      data: List<UserModel>.from(map['data']?.map((x) => UserModel.fromMap(x))),
      page: map['page'],
      per_page: map['per_page'],
      total: map['total'],
      total_pages: map['total_pages'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ListUser.fromJson(String source) =>
      ListUser.fromMap(json.decode(source));
}
