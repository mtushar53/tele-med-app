import 'package:flutter/material.dart';

/// Widget that displays patient information before the video call starts
class PatientInfoWidget extends StatelessWidget {
  final String patientName;
  final String patientAge;
  final String patientGender;
  final VoidCallback onStartCall;

  const PatientInfoWidget({
    super.key,
    required this.patientName,
    required this.patientAge,
    required this.patientGender,
    required this.onStartCall,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.grey[800],
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.person, size: 60, color: Colors.grey[400]),
              ),
              const SizedBox(height: 32),

              Text(
                patientName,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _InfoChip(text: 'Age: $patientAge'),
                  const SizedBox(width: 16),
                  _InfoChip(text: 'Gender: $patientGender'),
                ],
              ),
              const SizedBox(height: 48),

              ElevatedButton.icon(
                onPressed: onStartCall,
                icon: const Icon(Icons.videocam, color: Colors.white),
                label: const Text(
                  'Video Screen',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[700],
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 16,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Small info chip widget
class _InfoChip extends StatelessWidget {
  final String text;

  const _InfoChip({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey[800],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: const TextStyle(color: Colors.white, fontSize: 14),
      ),
    );
  }
}
