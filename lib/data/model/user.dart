import 'package:equatable/equatable.dart';

class User extends Equatable {
  int id;
  String name;
  String avatar;

  User(
    this.id,
    this.name,
    this.avatar,
  );

  @override
  List<Object> get props => [id, name, avatar];
}
