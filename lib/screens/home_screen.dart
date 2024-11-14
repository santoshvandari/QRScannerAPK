import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qr_code_scanner/screens/qr_scanner_screen.dart';
import 'result_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // Method to scan QR code from the gallery
  Future<void> _pickImageFromGallery(BuildContext context) async {
    final MobileScannerController controller = MobileScannerController();
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      // Decode the QR code from the image
      final result = await controller.analyzeImage(pickedImage.path);
      if (result != null) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ResultScreen(
                data: result.barcodes.first.rawValue ?? "No data found"),
          ),
        );
      }
    }
  }

  // Method to navigate to the camera scanner screen

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QR Code Scanner'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      const HomeScreen()), // Navigate to HomeScreen
            );
          },
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width - 50, // Dynamic width
                height: MediaQuery.of(context).size.width -
                    50, // Dynamic height, making it a square
                child: const QRScannerScreen(),
              ),

              const SizedBox(height: 40),

              // Gallery Upload Button
              ElevatedButton(
                onPressed: () => _pickImageFromGallery(context),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.blueAccent,
                  padding: const EdgeInsets.all(20),
                  shape: const CircleBorder(),
                  elevation: 10,
                ),
                child: const Icon(
                  Icons.image,
                  size: 50,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
