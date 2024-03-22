
class ValidationResponse {
  final String status;
  final String? exception;

  ValidationResponse({required this.status, this.exception});

  factory ValidationResponse.fromJson(Map<String, dynamic> json) {
    return ValidationResponse(
      status: json['status'] ?? '',
      exception: json['exception'],
    );
  }
}