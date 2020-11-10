import 'dart:convert';

import 'package:structure_flutter_mobile/data/model/user.dart';
import 'package:structure_flutter_mobile/data/source/remote/service/callback.dart';
import 'package:structure_flutter_mobile/data/source/remote/api/request/search_user_request.dart';
import 'package:structure_flutter_mobile/data/source/remote/api/response/search_user_response.dart';
import 'package:structure_flutter_mobile/data/source/remote/service/dio_client.dart';

abstract class UserRemoteDataSource {
  Future<Callback<List<User>>> searchUsers(SearchUserRequest request);
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final DioClient _dioClient;

  UserRemoteDataSourceImpl(this._dioClient);

  @override
  Future<Callback<List<User>>> searchUsers(SearchUserRequest request) async {
    return _dioClient.get(
      request.getUri(),
      queryParameters: request.toJson(),
      mapper: (json) {
        return SearchUserResponse.fromJson(json)
            .userRemoteEntities
            .map((e) => User.fromRemoteEntity(e))
            .toList();
      },
    );
  }
}
