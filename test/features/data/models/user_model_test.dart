import 'dart:convert';

import 'package:flutter_tdd_architecture/features/data/models/models.dart';
import 'package:flutter_tdd_architecture/features/domain/entities/entities.dart';

import 'package:flutter_test/flutter_test.dart';

import '../../../fixtures/fixture_reader.dart';

void main() {
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

  test('should be a subclass of user entity', () async {
    // assert
    expect(userModel, isA<UserModel>());
  });

  test('should be a subclass of user response entity', () async {
    // assert
    expect(userResponse, isA<UserResponseEntity>());
  });

  group('from json', () {
    test('should return a valid model', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(fixture('users_response.json'));

      // act
      final result = UsersResponse.fromJson(jsonMap);

      // assert
      expect(result, userResponse); // value of actual and expect must be same
    });
  });
}
