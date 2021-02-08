import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_tdd_architecture/core/error/exception.dart';

import 'package:flutter_tdd_architecture/features/data/models/user/users_response.dart';
import 'package:meta/meta.dart';

abstract class UserRemoteDataSource {
  /// Call the endpoint
  ///

  Future<UsersResponse> getUser();
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final Dio dio;

  UserRemoteDataSourceImpl({
    @required this.dio,
  });

  @override
  Future<UsersResponse> getUser() =>
      _getUserFromUrl('https://reqres.in/api/users?page=2');

  Future<UsersResponse> _getUserFromUrl(String url) async {
    final response = await dio.get(
      url,
      options: Options(
        headers: {'Content-Type': 'application/json'},
      ),
    );

    if (response.statusCode == 200) {
      return UsersResponse.fromJson(response.data);
    } else {
      throw DioError();
    }
  }
}
