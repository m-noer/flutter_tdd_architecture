import 'dart:convert';

import 'package:flutter/rendering.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/error/exception.dart';
import '../../models/user/users_response.dart';

abstract class UserLocalDataSource {
  /// Get the cached

  Future<UsersResponse> getUser();

  Future<void> cacheUser(UsersResponse usersResponse);
}

const CACHED_USER = "CHACHED_USER";

class UserLocalDataSourceImpl implements UserLocalDataSource {
  final SharedPreferences sp;

  UserLocalDataSourceImpl({
    this.sp,
  });
  // var box = Hive.box('myBox');

  @override
  Future<void> cacheUser(UsersResponse usersResponse) {
    // return box.put(CACHED_USER, json.encode(usersResponse.toJson()));
    // debugPrint("${usersResponse.toJson()}");
    String sd = json.encode(usersResponse.toJson());
    return sp.setString(CACHED_USER, sd);
  }

  @override
  Future<UsersResponse> getUser() {
    // final jsonString = box.get(CACHED_USER);
    final jsonString = sp.get(CACHED_USER);
    print(jsonString);
    // Map<String, dynamic> listUser = json.decode(jsonString);
    if (jsonString != null) {
      return Future.value(UsersResponse.fromJson(json.decode(jsonString)));
    }
  }
}
