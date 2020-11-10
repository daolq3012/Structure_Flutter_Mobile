import 'package:structure_flutter_mobile/data/model/user.dart';
import 'package:injectable/injectable.dart';
import 'package:structure_flutter_mobile/data/source/remote/service/callback.dart';
import 'package:structure_flutter_mobile/data/source/remote/api/request/search_user_request.dart';
import 'package:structure_flutter_mobile/data/source/remote/datasource/user_remote_datasource.dart';

abstract class UserRepository {
  Future<Callback<List<User>>> searchUsers(String keyword,
      {int page, int limit});

  Future<List<User>> fetchUserFromLocal();
}

@LazySingleton(as: UserRepository)
class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource _userRemoteDataSource;

  UserRepositoryImpl(this._userRemoteDataSource);

  @override
  Future<Callback<List<User>>> searchUsers(String keyword,
      {int page, int limit}) {
    SearchUserRequest request = SearchUserRequest(keyword,
        page: page == null ? 0 : page, limit: limit == null ? 10 : limit);
    return _userRemoteDataSource.searchUsers(request);
  }

  @override
  Future<List<User>> fetchUserFromLocal() {
    // TODO: implement fetchUserFromLocal
    throw UnimplementedError();
  }
}
