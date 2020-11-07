class ErrorResponse {
  final int code;
  final String message;
  final Attribute attributes;

  ErrorResponse({
    this.code,
    this.message,
    this.attributes,
  });

  factory ErrorResponse.fromJson(Map<String, dynamic> json) {
    return ErrorResponse(
        code: json['code'] as int,
        message: json['message'] as String,
        attributes: (json['customAttributes'] as Map<String, dynamic>) == null
            ? null
            : Attribute.fromJson(json['customAttributes']));
  }
}

class Attribute {
  final int statusCode;

  Attribute({this.statusCode});

  factory Attribute.fromJson(Map<String, dynamic> json) {
    return Attribute(statusCode: json['status'] as int);
  }
}
