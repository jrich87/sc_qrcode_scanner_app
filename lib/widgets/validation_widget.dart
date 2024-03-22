
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
  late Future<ValidationResponse> futureResponse;

  @override
  void initState() {
    super.initState();
    futureResponse = ValidationService.validate(widget.qrCode.toValidationRequest());
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      title: const Text('QR Code Scanner'),
      actions: [
        IconButton(
          onPressed: () {
            Navigator.pop(
              context,
              MaterialPageRoute(builder: (context) => const ScannerWidget()),
            );
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ValidationResponse>(
      future: futureResponse,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return buildLoading(context);
        } else if (snapshot.hasError) {
          return buildError(context);
        } else {
          switch (snapshot.data?.status) {
            case 'success':
              return buildSuccess(context);
            case 'failure':
              return buildFailure(context);
            default:
              return buildError(context);
          }
        }
      },
    );
  }

  Widget buildLoading(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar(context),
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
      appBar: buildAppBar(context),
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
      appBar: buildAppBar(context),
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
      appBar: buildAppBar(context),
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
}