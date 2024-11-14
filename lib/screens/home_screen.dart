import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qr_code_scanner/screens/qr_scanner_screen.dart';
import 'dart:io';
import 'result_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  // Method to scan QR code from the gallery
  Future<void> _pickImageFromGallery(BuildContext context) async {
    final MobileScannerController _controller = MobileScannerController();
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      // Decode the QR code from the image
      // final result = await MobileScanner.scanImage(File(pickedImage.path));
      final result = await _controller.analyzeImage(pickedImage.path);
      if (result != null) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ResultScreen(
                data:
                    result?.barcodes?.firstOrNull?.rawValue ?? "No data found"),
          ),
        );
      }
    }
  }

  // Method to navigate to the camera scanner screen
  void _scanQRCode(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const QRScannerScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('QR Code Scanner')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => _scanQRCode(context),
              child: const Text('Scan QR Code from Camera'),
            ),
            ElevatedButton(
              onPressed: () => _pickImageFromGallery(context),
              child: const Text('Upload QR Code from Gallery'),
            ),
          ],
        ),
      ),
    );
  }
}
