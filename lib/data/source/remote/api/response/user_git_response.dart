import 'package:json_annotation/json_annotation.dart';
import 'package:structure_flutter_mobile/data/model/user.dart';

part 'parser/user_git_response.g.dart';

@JsonSerializable()
class UserGitResponse {
  @JsonKey(name: "items")
  final List<UserGit> userGits;

  UserGitResponse(this.userGits);

  factory UserGitResponse.fromJson(Map<String, dynamic> json) =>
      _$UserGitResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UserGitResponseToJson(this);
}
