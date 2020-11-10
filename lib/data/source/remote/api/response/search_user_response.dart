import 'package:structure_flutter_mobile/data/source/remote/api/entities/user_remote_entity.dart';

class SearchUserResponse {
  final List<UserRemoteEntity> userRemoteEntities;

  SearchUserResponse(this.userRemoteEntities);

  factory SearchUserResponse.fromJson(Map<String, dynamic> json) {
    return SearchUserResponse((json['items'] as List)
        ?.map((e) => e == null
            ? null
            : UserRemoteEntity.fromJson(e as Map<String, dynamic>))
        ?.toList());
  }
}
