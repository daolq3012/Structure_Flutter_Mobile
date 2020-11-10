import 'package:equatable/equatable.dart';
import 'package:structure_flutter_mobile/data/source/remote/api/entities/user_remote_entity.dart';

class User extends Equatable {
  int id;
  String name;
  String avatar;

  User({this.id, this.name, this.avatar});

  @override
  List<Object> get props => [id, name, avatar];

  factory User.fromRemoteEntity(UserRemoteEntity entity) {
    return User(id: entity.id, name: entity.name, avatar: entity.avatar);
  }
}
