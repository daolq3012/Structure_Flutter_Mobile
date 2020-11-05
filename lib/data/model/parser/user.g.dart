// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserGit _$UserGitFromJson(Map<String, dynamic> json) {
  return UserGit(
    id: json['id'] as int,
    name: json['login'] as String,
    avatar: json['avatar_url'] as String,
  );
}

Map<String, dynamic> _$UserGitToJson(UserGit instance) => <String, dynamic>{
      'id': instance.id,
      'login': instance.name,
      'avatar_url': instance.avatar,
    };
