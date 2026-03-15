import 'package:flutter/material.dart';

class VideoCallControlsWidget extends StatelessWidget {
  final bool showControls;
  final String patientName;
  final String patientAge;
  final String patientGender;
  final VoidCallback onMute;
  final VoidCallback onSwitchCamera;
  final VoidCallback onToggleCamera;
  final VoidCallback onLeaveChannel;
  final VoidCallback onPrescription;
  final VoidCallback onDocuments;
  final VoidCallback onChat;
  final VoidCallback onBack;
  final bool isMuted;
  final bool isCameraOff;

  const VideoCallControlsWidget({
    super.key,
    required this.showControls,
    required this.patientName,
    required this.patientAge,
    required this.patientGender,
    required this.onMute,
    required this.onSwitchCamera,
    required this.onToggleCamera,
    required this.onLeaveChannel,
    required this.onPrescription,
    required this.onDocuments,
    required this.onChat,
    required this.onBack,
    required this.isMuted,
    required this.isCameraOff,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Positioned(top: 16, left: 16, child: BrandLogoWidget()),

        Positioned(
          bottom: 16,
          left: 16,
          child: UserDetailsWidget(
            patientName: patientName,
            patientAge: patientAge,
            patientGender: patientGender,
          ),
        ),

        AnimatedPositioned(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          top: showControls ? 0 : -150,
          left: 0,
          right: 0,
          child: SafeArea(
            bottom: false,
            child: TopButtonsWidget(
              onBack: onBack,
              onPrescription: onPrescription,
              onDocuments: onDocuments,
              onChat: onChat,
            ),
          ),
        ),

        AnimatedPositioned(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          bottom: showControls ? 0 : -150,
          left: 0,
          right: 0,
          child: SafeArea(
            top: false,
            child: BottomControlsWidget(
              onMute: onMute,
              onSwitchCamera: onSwitchCamera,
              onToggleCamera: onToggleCamera,
              onLeaveChannel: onLeaveChannel,
              isMuted: isMuted,
              isCameraOff: isCameraOff,
            ),
          ),
        ),
      ],
    );
  }
}

class BrandLogoWidget extends StatelessWidget {
  const BrandLogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Text(
        'livewellBD',
        style: TextStyle(
          color: Colors.black,
          fontSize: 16,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}

class UserDetailsWidget extends StatelessWidget {
  final String patientName;
  final String patientAge;
  final String patientGender;

  const UserDetailsWidget({
    super.key,
    required this.patientName,
    required this.patientAge,
    required this.patientGender,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.3),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        '$patientName, $patientAge, $patientGender',
        style: const TextStyle(
          color: Colors.black,
          fontSize: 14,
          fontWeight: FontWeight.w500,
          shadows: [
            Shadow(color: Colors.black26, blurRadius: 4, offset: Offset(0, 2)),
          ],
        ),
      ),
    );
  }
}

class TopButtonsWidget extends StatelessWidget {
  final VoidCallback onBack;
  final VoidCallback onPrescription;
  final VoidCallback onDocuments;
  final VoidCallback onChat;

  const TopButtonsWidget({
    super.key,
    required this.onBack,
    required this.onPrescription,
    required this.onDocuments,
    required this.onChat,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      child: SafeArea(
        bottom: false,
        child: Container(
          decoration: const BoxDecoration(color: Colors.white),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              IconButton(
                onPressed: onBack,
                icon: const Icon(Icons.chevron_left, color: Color(0xFF4A4458)),
                padding: const EdgeInsets.all(8),
              ),
              const SizedBox(width: 16),

              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildTopButton(
                      icon: Icons.medication,
                      label: 'Prescription',
                      onPressed: onPrescription,
                    ),
                    _buildTopButton(
                      icon: Icons.description,
                      label: 'Documents',
                      onPressed: onDocuments,
                    ),
                    _buildTopButton(
                      icon: Icons.chat,
                      label: 'Chat',
                      onPressed: onChat,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
  }) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: null,
            icon: Icon(icon, color: Colors.blue[700]),
            iconSize: 28,
          ),
          Text(
            label,
            style: TextStyle(
              color: Colors.grey[700],
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class BottomControlsWidget extends StatelessWidget {
  final VoidCallback onMute;
  final VoidCallback onSwitchCamera;
  final VoidCallback onToggleCamera;
  final VoidCallback onLeaveChannel;
  final bool isMuted;
  final bool isCameraOff;

  const BottomControlsWidget({
    super.key,
    required this.onMute,
    required this.onSwitchCamera,
    required this.onToggleCamera,
    required this.onLeaveChannel,
    required this.isMuted,
    required this.isCameraOff,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      child: SafeArea(
        top: false,
        child: Container(
          decoration: const BoxDecoration(color: Colors.white),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildControlButton(
                icon: isMuted ? Icons.mic_off : Icons.mic,
                label: isMuted ? 'Unmute' : 'Mute',
                onPressed: onMute,
                backgroundColor: isMuted ? Colors.red : Colors.grey[300],
                iconColor: isMuted ? Colors.white : Colors.black,
              ),
              _buildControlButton(
                icon: isCameraOff ? Icons.videocam_off : Icons.videocam,
                label: isCameraOff ? 'Camera On' : 'Camera Off',
                onPressed: onToggleCamera,
                backgroundColor: isCameraOff ? Colors.red : Colors.grey[300],
                iconColor: isCameraOff ? Colors.white : Colors.black,
              ),
              _buildControlButton(
                icon: Icons.flip_camera_ios,
                label: 'Switch',
                onPressed: onSwitchCamera,
                backgroundColor: Colors.grey[300],
                iconColor: Colors.black,
              ),
              _buildControlButton(
                icon: Icons.call_end,
                label: 'End',
                onPressed: onLeaveChannel,
                backgroundColor: Colors.red,
                iconColor: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildControlButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
    required Color? backgroundColor,
    required Color iconColor,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            color: backgroundColor,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: IconButton(
            onPressed: onPressed,
            icon: Icon(icon, color: iconColor),
            iconSize: 28,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: Colors.grey[700],
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
