import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:sc_qrcode_scanner_app/qrscanneroverlay.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'flutter',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  MobileScannerController cameraController = MobileScannerController(detectionSpeed: DetectionSpeed.noDuplicates, facing: CameraFacing.front, torchEnabled: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QRScanner'),
        actions: [IconButton(onPressed: (){
          cameraController.switchCamera();
        }, icon: const Icon(Icons.camera_rear_outlined))]
      ),
      body: Stack(children:[
        MobileScanner(
          controller: cameraController,
          onDetect: (capture) {
            final List<Barcode> barcodes = capture.barcodes;
            final Uint8List? image = capture.image;
            for (final barcode in barcodes) {
              debugPrint('Barcode found! ${barcode.rawValue}');
            }
          },
        ),
        QRScannerOverlay(overlayColour: Colors.black.withOpacity(0.5))
      ]),
    );
  }
}