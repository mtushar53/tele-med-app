import 'package:flutter/material.dart';

class ReturnToCallBanner extends StatelessWidget {
  const ReturnToCallBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 16),
      color: Colors.red,
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pop();
        },
        child: const Text(
          'Touch to return call',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
