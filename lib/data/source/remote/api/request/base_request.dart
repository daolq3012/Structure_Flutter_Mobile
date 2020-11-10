import 'package:equatable/equatable.dart';

abstract class BaseRequest extends Equatable {
  String getUri();

  Map<String, dynamic> toJson();
}
