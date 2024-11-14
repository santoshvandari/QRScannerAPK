import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';
import 'dart:io';
import 'result_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;

  // Function to scan QR code from camera
  void _scanQRCode(BuildContext context) async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => QRView(
          key: qrKey,
          onQRViewCreated: (controller) {
            controller.scannedDataStream.listen((scanData) {
              controller.pauseCamera();
              Navigator.pop(context); // Go back to home
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ResultScreen(data: scanData.code),
                ),
              );
            });
          },
        ),
      ),
    );
  }

  // Function to pick QR code image from gallery
  void _pickImageFromGallery(BuildContext context) async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      final file = File(pickedImage.path);
      // Here you would implement a method to decode the QR code from the image file
      String? decodedData =
          await decodeQRCodeFromImage(file); // Implement this function
      if (decodedData != null) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ResultScreen(data: decodedData),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('QR Code Scanner')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => _scanQRCode(context),
              child: Text('Scan QR Code from Camera'),
            ),
            ElevatedButton(
              onPressed: () => _pickImageFromGallery(context),
              child: Text('Upload QR Code from Gallery'),
            ),
          ],
        ),
      ),
    );
  }
}
