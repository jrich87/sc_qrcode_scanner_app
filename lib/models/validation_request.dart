
class ValidationRequest {
  final String email;
  final String event;

  ValidationRequest(this.email, this.event);

  Map<String, String> toParams() {
    return {
      'email': email,
      'event': event
    };
  }
}