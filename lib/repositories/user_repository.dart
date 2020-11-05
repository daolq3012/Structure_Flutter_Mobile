import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:structure_flutter_mobile/core/middleware/dio_client.dart';
import 'package:structure_flutter_mobile/di/injection.dart';

import '../data/model/user.dart';

abstract class UserRepository {
  Future<List<UserGit>> getUser(int page);
}

@Singleton(as: UserRepository)
class UserRepositoryImpl implements UserRepository {

  final DioClient _dioClient;

  UserRepositoryImpl(this._dioClient);

  @override
  Future<List<UserGit>> getUser(int page) async {
    final response = await _dioClient.get('/search/users',
        queryParameters: {'q': 'abc', 'page': page, 'per_page': 10});
    var tagObjsJson = jsonDecode(json.encode(response))['items'] as List;
    List<UserGit> tagObjs =
        tagObjsJson.map((tagJson) => UserGit.fromJson(tagJson)).toList();
    return tagObjs;
  }
}
