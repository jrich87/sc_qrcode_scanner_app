
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:sc_qrcode_scanner_app/models/qr_code.dart';
import 'package:sc_qrcode_scanner_app/styling/common_styles.dart';
import 'package:sc_qrcode_scanner_app/widgets/scanner_overlay_widget.dart';
import 'package:sc_qrcode_scanner_app/widgets/validation_widget.dart';

import 'custom_app_bar_widget.dart';

class ScannerWidget extends StatefulWidget {
  const ScannerWidget({Key? key}) : super(key: key);

  @override
  State<ScannerWidget> createState() => _ScannerWidgetState();
}

class _ScannerWidgetState extends State<ScannerWidget> {
  late MobileScannerController cameraController;
  bool isScanning = true;

  @override
  void initState() {
    super.initState();
    cameraController = MobileScannerController(
      detectionSpeed: DetectionSpeed.noDuplicates,
      facing: CameraFacing.front,
      torchEnabled: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWidget(
        showSwitchCameraIcon: true,
        onSwitchCamera: (){
          cameraController.switchCamera();
        }
      ),
      body: Stack(children:[
        MobileScanner(
          controller: cameraController,
          onDetect: (capture) {
            if (!isScanning) {
              return;
            }
            final List<Barcode> barcodes = capture.barcodes;

            if (barcodes.isNotEmpty) {
              final barcode = barcodes.first;
              debugPrint('Barcode found: ${barcode.rawValue}');
              isScanning = false;
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => ValidationWidget(qrCode: QRCode(barcode.rawValue))),
              ).then((_) {
                if (mounted) {
                  isScanning = true;
                }
              });
            }
          },
        ),
        QRScannerOverlayWidget(overlayColour: Colors.black.withOpacity(0.5))
      ]),
    );
  }
}