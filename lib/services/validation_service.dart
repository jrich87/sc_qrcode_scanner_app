
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:sc_qrcode_scanner_app/models/validation_request.dart';
import 'package:sc_qrcode_scanner_app/models/validation_response.dart';

class ValidationService {
  static const String url = "test-events.ca";
  static const String path = "validate";
  
  static Future<ValidationResponse> validate(ValidationRequest request) async {
    // return ValidationResponse(status: "success");

    debugPrint('Parameters: ${request.toParams()}');
    var uri = Uri.https(url, path, request.toParams());
    try {
      Response res = await get(uri);
      if (res.statusCode == 200) {
        return ValidationResponse.fromJson(jsonDecode(res.body));
      } else {
        return ValidationResponse(
            status: 'error', exception: 'HTTP status code: ${res.statusCode}');
      }
    } catch (e) {
      return ValidationResponse(status: 'error', exception: e.toString());
    }
  }
}