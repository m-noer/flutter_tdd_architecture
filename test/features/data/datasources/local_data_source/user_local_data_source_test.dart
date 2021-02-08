import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:flutter_tdd_architecture/core/error/exception.dart';
import 'package:flutter_tdd_architecture/features/data/datasources/local_data_source/user_local_data_source.dart';
import 'package:flutter_tdd_architecture/features/data/models/models.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  UserLocalDataSourceImpl dataSource;
  MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    dataSource = UserLocalDataSourceImpl(sp: mockSharedPreferences);
  });

  group('getLastUser', () {
    final tUsersResponse =
        UsersResponse.fromJson(json.decode(fixture('users_response.json')));

    test('should return User from SharedPreferences when there is in the cache',
        () async {
      // arrage
      when(mockSharedPreferences.getString(any))
          .thenReturn(fixture('users_response.json'));

      // act
      final result = await dataSource.getUser();

      // assert
      verify(mockSharedPreferences.getString(CACHED_USER));
      expect(result, equals(tUsersResponse));
    });

    test('should throw a CacheException when there is not a cached value',
        () async {
      // arrange
      when(mockSharedPreferences.getString(any)).thenReturn(null);

      // act
      final call = dataSource.getUser();

      // assert
      expect(() => call, throwsA(TypeMatcher<CacheException>()));
    });
  });

  group('cacheUser', () {
    final userModel = UserModel(
        id: 1,
        email: 'mnoer@outlook.com',
        firstName: 'Muhammad',
        lastName: 'Noer',
        avatar: 'https://reqres.in/img/faces/7-image.jpg');

    final userResponse = UsersResponse(
      page: 2,
      perPage: 6,
      total: 12,
      totalPages: 2,
      data: [userModel],
    );

    test('should call SharedPreferences to cache the data', () async {
      // act
      dataSource.cacheUser(userResponse);
      // assert
      final expectedJsonString = json.encode(userResponse.toJson());
      verify(mockSharedPreferences.setString(CACHED_USER, expectedJsonString));
    });
  });
}
