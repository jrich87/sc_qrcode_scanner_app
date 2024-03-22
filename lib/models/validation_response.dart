
class ValidationResponse {
  final String status;

  ValidationResponse({required this.status});

  factory ValidationResponse.fromJson(Map<String, dynamic> json) {
    return ValidationResponse(
      status: json['status'] ?? ''
    );
  }
}