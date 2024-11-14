import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'result_screen.dart';

class QRScannerScreen extends StatefulWidget {
  const QRScannerScreen({super.key});

  @override
  _QRScannerScreenState createState() => _QRScannerScreenState();
}

class _QRScannerScreenState extends State<QRScannerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('QR Code Scanner')),
      body: MobileScanner(
        onDetect: (barcodeCapture) {
          if (barcodeCapture.barcodes.isNotEmpty) {
            final String code = barcodeCapture.barcodes.first.rawValue!;
            Navigator.pop(context); // Go back to home
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ResultScreen(data: code),
              ),
            );
          }
        },
      ),
    );
  }
}
