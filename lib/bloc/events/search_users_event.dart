import 'package:equatable/equatable.dart';

abstract class SearchUserEvent extends Equatable {}

class FetchUsersEvent extends SearchUserEvent {
  @override
  List<Object> get props => [];

  @override
  String toString() => "FetchEvent";
}
