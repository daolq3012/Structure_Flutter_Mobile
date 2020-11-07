import 'package:structure_flutter_mobile/data/source/remote/api/error/base_exception.dart';

class Callback<T> {
  final T data;
  final BaseException error;

  Callback({this.data, this.error});

  factory Callback.success(T data) {
    return Callback(data: data);
  }

  factory Callback.failure(BaseException e) {
    return Callback(error: e);
  }

  when({Function(T data) onSuccess, Function(BaseException e) onFailure}) {
    if (data != null) {
      return onSuccess(data);
    } else {
      return onFailure(error);
    }
  }
}
