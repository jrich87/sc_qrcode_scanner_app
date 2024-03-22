
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sc_qrcode_scanner_app/models/qr_code.dart';
import 'package:sc_qrcode_scanner_app/services/validation_service.dart';
import 'package:sc_qrcode_scanner_app/models/validation_response.dart';
import 'package:sc_qrcode_scanner_app/styling/common_styles.dart';
import 'package:sc_qrcode_scanner_app/widgets/custom_app_bar_widget.dart';
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
    futureResponse = ValidationService.validate(widget.qrCode.toValidationRequest())
      .timeout(const Duration(seconds: 5), onTimeout: () {
        throw TimeoutException('Request timed out');
      });
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
        appBar: CustomAppBarWidget(),
        body: Container(
          color: Colors.grey,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text('Searching...', style: CommonStyles.validationText),
                Container(
                  height: 100,
                  width: 100,
                  padding: const EdgeInsets.all(20.0),
                  child: const CircularProgressIndicator(strokeWidth: 10, color: CommonColors.validationIcon),
                ),
                const Text('Please wait', style: CommonStyles.validationText),
              ],
            )
          ),
        )
    );
  }

  Widget buildSuccess(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWidget(),
      body: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Container(
          color: Colors.green,
          child: const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.check, size: 100, color: CommonColors.validationIcon),
                Text('Valid Code', style: CommonStyles.validationText),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildFailure(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWidget(),
      body: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Container(
          color: Colors.red,
          child: const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.close, size: 100, color: CommonColors.validationIcon),
                Text('Invalid Code', style: CommonStyles.validationText),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildError(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWidget(),
      body: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Container(
          color: Colors.grey,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Icon(Icons.error, size: 100, color: CommonColors.validationIcon),
                const Text('Communication Error', style: CommonStyles.validationText),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                      backgroundColor: Colors.grey,
                      foregroundColor: Colors.white,
                      side: const BorderSide(color: Colors.white, width: 2),
                    ),
                    child: const Text('Retry', style: CommonStyles.validationRetryText),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}