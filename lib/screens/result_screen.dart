import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ResultScreen extends StatelessWidget {
  final String data;

  const ResultScreen({required this.data});

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
      appBar: AppBar(title: Text('QR Data')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                data,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => _copyToClipboard(context),
                child: Text('Copy to Clipboard'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
