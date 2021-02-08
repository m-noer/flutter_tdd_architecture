import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_tdd_architecture/core/error/exception.dart';
import 'package:flutter_tdd_architecture/features/data/datasources/remote_data_source/user_remote_data_source.dart';
import 'package:flutter_tdd_architecture/features/data/models/user/users_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockDioAdapter extends Mock implements HttpClientAdapter {}

void main() {
  final Dio tdio = Dio();
  UserRemoteDataSourceImpl dataSource;
  MockDioAdapter mockDioAdapter;

  setUp(() {
    mockDioAdapter = MockDioAdapter();
    tdio.httpClientAdapter = mockDioAdapter;
    dataSource = UserRemoteDataSourceImpl(dio: tdio);
  });

  void setUpMockHttpClientSuccess200() {
    final responsepayload = fixture('users_response.json');
    final httpResponse = ResponseBody.fromString(
      responsepayload,
      200,
      headers: {
        Headers.contentTypeHeader: [Headers.jsonContentType],
      },
    );

    when(mockDioAdapter.fetch(any, any, any))
      ..thenAnswer((_) async => httpResponse);
  }

  void setUpMockHttpClientFailure404() {
    final httpResponse = ResponseBody.fromString(
      'Something went wrong',
      404,
      headers: {
        Headers.contentTypeHeader: [Headers.jsonContentType],
      },
    );

    when(mockDioAdapter.fetch(any, any, any))
      ..thenAnswer((_) async => httpResponse);
  }

  group('Get method', () {
    final tUserResponse =
        UsersResponse.fromJson(json.decode(fixture('users_response.json')));

    test('should return UsersResponse when the response is 200', () async {
      // arrange
      setUpMockHttpClientSuccess200();
      // act
      final response = await dataSource.getUser();
      // assert
      expect(response, equals(tUserResponse));
    });

    // test(
    //     'should throw a ServerException when the response code is  404 or other',
    //     () async {
    //   // arrange
    //   // setUpMockHttpClientFailure404();
    //   final httpResponse = ResponseBody.fromString(
    //     'Something went wrong',
    //     404,
    //     headers: {
    //       Headers.contentTypeHeader: [Headers.jsonContentType],
    //     },
    //   );

    //   when(mockDioAdapter.fetch(any, any, any))
    //     ..thenAnswer((_) async => httpResponse);
    //   // act
    //   final call = await dataSource.getUser();
    //   // assert
    //   // ignore: deprecated_member_use
    //   expect(() => call, throwsA(DioError()));
    // });
  });
}
