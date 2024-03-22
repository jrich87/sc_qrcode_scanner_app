
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:sc_qrcode_scanner_app/models/validation_request.dart';
import 'package:sc_qrcode_scanner_app/models/validation_response.dart';

class ValidationService {
  static const String url = "test-events.ca";
  static const String path = "validate";
  
  static Future<ValidationResponse> validate(ValidationRequest request) async {
    return ValidationResponse(status: 'failure');
    final uri = Uri.https(url, path, request.toParams());
    Response res = await get(uri);

    debugPrint('HTTP Status Code: ${res.statusCode}');
    if (res.statusCode == 200) {
      return ValidationResponse.fromJson(jsonDecode(res.body));
    } else {
      throw Exception('HTTP Status Code: ${res.statusCode}');
    }
  }
}