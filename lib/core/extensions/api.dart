class RequestPayload {
  RequestPayload._();

  static RequestPayload shared = RequestPayload._();

  Map<String, dynamic> defaultWithEmailPassword(String email, String password) {
    return {
      RequestPayloadKey.email: email,
      RequestPayloadKey.password: password,
    };
  }
}

class RequestPayloadKey {
  static String email = 'email';
  static String password = 'password';
}
