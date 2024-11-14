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
      body: Stack(
        children: [
          // MobileScanner for QR code scanning
          MobileScanner(
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

          // Focus box overlay
          Center(
            child: Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Colors.white.withOpacity(0.7),
                  width: 2,
                ),
              ),
              child: const Stack(
                children: [
                  // Highlighted corners
                  Positioned(
                    top: 0,
                    left: 0,
                    child:
                        Icon(Icons.crop_square, size: 28, color: Colors.white),
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child:
                        Icon(Icons.crop_square, size: 28, color: Colors.white),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    child:
                        Icon(Icons.crop_square, size: 28, color: Colors.white),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child:
                        Icon(Icons.crop_square, size: 28, color: Colors.white),
                  ),
                ],
              ),
            ),
          ),

          // Instruction text
          const Positioned(
            bottom: 80,
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                'Align QR code within the frame',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
