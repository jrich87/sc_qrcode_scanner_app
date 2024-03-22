
import 'package:sc_qrcode_scanner_app/models/validation_request.dart';

class QRCode{
  late final String email;
  late final String event;

  QRCode(final rawValue){
    email = "jon@test.com";
    event = "TEST";
  }

  ValidationRequest toValidationRequest() {
    return ValidationRequest(email, event);
  }
}