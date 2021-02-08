import 'package:json_annotation/json_annotation.dart';

import 'user_model.dart';
import '../../../domain/entities/user/user_response_entity.dart';
import 'package:meta/meta.dart';

part 'users_response.g.dart';

@JsonSerializable()
class UsersResponse extends UserResponseEntity {
  final List<UserModel> data;
  final int page;
  @JsonKey(name: 'per_page')
  final int perPage;
  final int total;
  @JsonKey(name: 'total_pages')
  final int totalPages;

  UsersResponse({
    this.data,
    @required this.page,
    @required this.perPage,
    @required this.total,
    @required this.totalPages,
  }) : super(
          data: data,
          page: page,
          perPage: perPage,
          total: total,
          totalPages: totalPages,
        );

  factory UsersResponse.fromJson(Map<String, dynamic> json) =>
      _$UsersResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UsersResponseToJson(this);
}
