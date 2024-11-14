import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'result_screen.dart';

class QRScannerScreen extends StatefulWidget {
  const QRScannerScreen({super.key});

  @override
  _QRScannerScreenState createState() => _QRScannerScreenState();
}

class _QRScannerScreenState extends State<QRScannerScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  bool isScanned = false; // Track if a code has been scanned

  @override
  void initState() {
    super.initState();
    // Initialize animation controller for the scanning line
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onDetect(BarcodeCapture barcodeCapture) {
    // Check if barcode is detected and avoid multiple scans
    if (!isScanned && barcodeCapture.barcodes.isNotEmpty) {
      setState(() {
        isScanned = true;
      });
      final String code = barcodeCapture.barcodes.first.rawValue!;
      // Navigate to result screen with scanned data
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ResultScreen(data: code),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // MobileScanner to capture QR codes
          MobileScanner(
            onDetect: _onDetect,
          ),

          // Overlay with focused scanning box and animation
          Center(
            child: Stack(
              children: [
                // Semi-transparent overlay with transparent square
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: Colors.black.withOpacity(0.6),
                ),
                // Transparent square in the center for the scanning focus
                Center(
                  child: Container(
                    width: 250,
                    height: 250,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.8),
                        width: 2,
                      ),
                    ),
                    child: Stack(
                      children: [
                        // Scanning line animation inside the focus box
                        AnimatedBuilder(
                          animation: _animationController,
                          builder: (context, child) {
                            return Positioned(
                              top: _animationController.value * 250,
                              left: 0,
                              right: 0,
                              child: Container(
                                height: 2,
                                color: Colors.red.withOpacity(0.8),
                              ),
                            );
                          },
                        ),
                        // Highlighted corners to emphasize the scan area
                        Positioned(
                          top: 0,
                          left: 0,
                          child: Icon(Icons.crop_square,
                              size: 28, color: Colors.white.withOpacity(0.8)),
                        ),
                        Positioned(
                          top: 0,
                          right: 0,
                          child: Icon(Icons.crop_square,
                              size: 28, color: Colors.white.withOpacity(0.8)),
                        ),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          child: Icon(Icons.crop_square,
                              size: 28, color: Colors.white.withOpacity(0.8)),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Icon(Icons.crop_square,
                              size: 28, color: Colors.white.withOpacity(0.8)),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Instruction text positioned below the scanning area
          const Positioned(
            bottom: 100,
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
