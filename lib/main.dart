import 'package:flutter/material.dart';
import 'package:sc_qrcode_scanner_app/widgets/scanner_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'QRScanner',
      home: ScannerWidget(),
    );
  }
}

