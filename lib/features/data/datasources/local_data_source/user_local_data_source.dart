import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter_tdd_architecture/core/error/exception.dart';
import 'package:flutter_tdd_architecture/features/data/models/user/users_response.dart';

abstract class UserLocalDataSource {
  /// Get the cached

  Future<UsersResponse> getUser();

  Future<void> cacheUser(UsersResponse usersResponse);
}

const CACHED_USER = "CHAcHED_USER";

class UserLocalDataSourceImpl implements UserLocalDataSource {
  final SharedPreferences sp;

  UserLocalDataSourceImpl({
    this.sp,
  });
  // var box = Hive.box('myBox');

  @override
  Future<void> cacheUser(UsersResponse usersResponse) {
    // return box.put(CACHED_USER, json.encode(usersResponse.toJson()));
    return sp.setString(CACHED_USER, json.encode(usersResponse.toJson()));
  }

  @override
  Future<UsersResponse> getUser() {
    // final jsonString = box.get(CACHED_USER);
    final jsonString = sp.get(CACHED_USER);
    if (jsonString != null) {
      return Future.value(UsersResponse.fromJson(json.decode(jsonString)));
    } else {
      throw CacheException();
    }
  }
}
