import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'home_screen.dart'; // Import HomeScreen to navigate back

class ResultScreen extends StatelessWidget {
  final String data;

  const ResultScreen({super.key, required this.data});

  void _copyToClipboard(BuildContext context) {
    Clipboard.setData(ClipboardData(text: data));
    Fluttertoast.showToast(
      msg: "QR Data Copied!",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
    );
  }

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
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Display the QR code data
              Text(
                data,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 30),

              // Copy to Clipboard button
              ElevatedButton.icon(
                onPressed: () => _copyToClipboard(context),
                icon: const Icon(
                  Icons.copy,
                  size: 24,
                ),
                label: const Text('Copy to Clipboard'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  foregroundColor: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  elevation: 8,
                ),
              ),
              const SizedBox(height: 20),

              // Optionally add a button to navigate back or clear
              ElevatedButton.icon(
                onPressed: () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          const HomeScreen()), // Navigate to HomeScreen
                ),
                icon: const Icon(
                  Icons.home,
                  size: 24,
                ),
                label: const Text('Go to Home'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  foregroundColor: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  elevation: 8,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
