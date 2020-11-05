import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'parser/user.g.dart';

@JsonSerializable()
class UserGit extends Equatable {
  @JsonKey(name: "id")
  final int id;
  @JsonKey(name: "login")
  final String name;
  @JsonKey(name: "avatar_url")
  final String avatar;

  UserGit({this.id, this.name, this.avatar});

  factory UserGit.fromJson(Map<String, dynamic> json) =>
      _$UserGitFromJson(json);

  Map<String, dynamic> toJson() => _$UserGitToJson(this);

  @override
  String toString() => 'UserGit { id: $id }';
}
