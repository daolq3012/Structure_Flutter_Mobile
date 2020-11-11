import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:structure_flutter_mobile/data/model/user.dart';

abstract class SearchUserState extends Equatable {}

class SearchUserLoaded extends SearchUserState {
  final List<User> users;
  final bool hasReachMax;

  SearchUserLoaded({
    @required this.users,
    @required this.hasReachMax,
  });

  SearchUserLoaded copyWith({List<User> users, hasReachMax}) {
    return SearchUserLoaded(
        users: users ?? this.users,
        hasReachMax: hasReachMax ?? this.hasReachMax);
  }

  @override
  List<Object> get props => [users];

  @override
  String toString() => "SearchUserLoaded";
}

class SearchUserInitialized extends SearchUserState {
  @override
  List<Object> get props => [];

  @override
  String toString() => "SearchUserInitialized";
}

class SearchUserError extends SearchUserState {
  @override
  List<Object> get props => [];

  @override
  String toString() => "SearchUserError";
}
