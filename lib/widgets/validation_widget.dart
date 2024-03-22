
import 'package:flutter/material.dart';
import 'package:sc_qrcode_scanner_app/models/qr_code.dart';
import 'package:sc_qrcode_scanner_app/services/validation_service.dart';
import 'package:sc_qrcode_scanner_app/models/validation_response.dart';
import 'package:sc_qrcode_scanner_app/widgets/scanner_widget.dart';

class ValidationWidget extends StatefulWidget {
  final QRCode qrCode;
  const ValidationWidget({super.key, required this.qrCode});

  @override
  State<ValidationWidget> createState() => _ValidationWidgetState();
}

class _ValidationWidgetState extends State<ValidationWidget> {
  ValidationResponse? response;

  @override
  void initState() {
    super.initState();
    validateQRCode();
  }

  void validateQRCode() {
    ValidationService.validate(widget.qrCode.toValidationRequest()).then((res) {
      setState(() {
        response = res;
      });
    });
  }

  Widget buildLoading(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text('QR Code Scanner'),
            actions: [IconButton(onPressed: (){
              Navigator.pop(
                context,
                MaterialPageRoute(builder: (context) => const ScannerWidget()),
              );
            }, icon: const Icon(Icons.arrow_back))]
        ),
        body: Container(
          color: Colors.grey,
          child: const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Searching...'),
                CircularProgressIndicator(),
                Text('Please wait'),
              ],
            )
          ),
        )
    );
  }

  Widget buildSuccess(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QR Code Scanner'),
        actions: [IconButton(onPressed: (){
          Navigator.pop(
            context,
            MaterialPageRoute(builder: (context) => const ScannerWidget()),
          );
        }, icon: const Icon(Icons.arrow_back))]
      ),
      body: Container(
        color: Colors.green,
        child: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.check, size: 50),
              Text('Valid Code'),
            ],
          ),
        ),
      )
    );
  }

  Widget buildFailure(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QR Code Scanner'),
        actions: [IconButton(onPressed: (){
          Navigator.pop(
            context,
            MaterialPageRoute(builder: (context) => const ScannerWidget()),
          );
        }, icon: const Icon(Icons.arrow_back))]
      ),
      body: Container(
        color: Colors.red,
        child: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.close, size: 50),
              Text('Invalid Code'),
            ],
          ),
        ),
      )
    );
  }

  Widget buildError(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QR Code Scanner'),
        actions: [IconButton(onPressed: (){
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const ScannerWidget()),
          );
        }, icon: const Icon(Icons.arrow_back))]
      ),
      body: Container(
        color: Colors.grey,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text('Communication Error'),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(
                    context,
                    MaterialPageRoute(builder: (context) => const ScannerWidget()),
                  );
                },
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    if (response == null) {
      return buildLoading(context);
    } else if (response?.status == 'success') {
      return buildSuccess(context);
    } else if (response?.status == 'failure') {
      return buildFailure(context);
    } else {
      return buildError(context);
    }
  }
}