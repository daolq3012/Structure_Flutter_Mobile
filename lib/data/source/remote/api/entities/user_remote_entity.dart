import 'package:equatable/equatable.dart';

class UserRemoteEntity extends Equatable {
  final int id;
  final String name;
  final String avatar;

  UserRemoteEntity({this.id, this.name, this.avatar});

  @override
  List<Object> get props => [id, name, avatar];

  factory UserRemoteEntity.fromJson(Map<String, dynamic> json) {
    return UserRemoteEntity(
        id: json['id'] as int,
        name: json['login'] as String,
        avatar: json['avatar_url'] as String);
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{'id': id, 'login': name, 'avatar_url': avatar};
  }
}
