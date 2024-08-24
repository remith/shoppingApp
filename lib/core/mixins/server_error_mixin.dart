import 'dart:convert';

import 'package:http/http.dart' as http;

mixin ServerErrorMixin {
  String handleServerExceptions(http.Response response) {
    final Map<String, dynamic> responseBody = json.decode(response.body);
    return responseBody['message'] ?? 'Failed to load';
  }
}

mixin APIFailureMixin {
  String handleAPIFailure(String message) {
    return message;
  }
}
