import 'package:flutter/material.dart';
import 'dart:async';
import 'prescription_screen.dart';
import 'documents_screen.dart';
import 'chat_screen.dart';
import '../config/agora_config.dart';
import '../services/agora_service.dart';
import '../widgets/patient_info_widget.dart';
import '../widgets/video_views_widget.dart';
import '../widgets/video_call_controls_widget.dart';
import '../widgets/error_view_widget.dart';

class VideoCallScreen extends StatefulWidget {
  final String channelName;
  final String doctorName;
  final String agoraAppId;
  final String patientName;
  final String patientAge;
  final String patientGender;

  const VideoCallScreen({
    super.key,
    required this.channelName,
    this.doctorName = 'Dr. Smith',
    required this.agoraAppId,
    this.patientName = 'John Doe',
    this.patientAge = '35',
    this.patientGender = 'Male',
  });

  @override
  State<VideoCallScreen> createState() => _VideoCallScreenState();
}

class _VideoCallScreenState extends State<VideoCallScreen> {
  late AgoraService _agoraService;
  String? _errorMessage;

  // UI State
  bool _showControls = true;
  Timer? _autoHideTimer;

  @override
  void initState() {
    super.initState();
    _initializeAgora();
  }

  @override
  void dispose() {
    _autoHideTimer?.cancel();
    _agoraService.dispose();
    super.dispose();
  }

  Future<void> _initializeAgora() async {
    _agoraService = AgoraService(
      onJoinChannelSuccess: (isJoined) {
        setState(() {
          _errorMessage = null;
        });
        // Start auto-hide timer when user joins
        _startAutoHideTimer();
      },
      onUserJoined: (remoteUid) {
        setState(() {
          _errorMessage = null;
        });
      },
      onUserOffline: (remoteUid, reason) {
        setState(() {});
      },
      onLeaveChannel: () {
        setState(() {
          _showControls = false;
        });
        _autoHideTimer?.cancel();
      },
      onError: (error) {
        setState(() {
          _errorMessage = error;
        });
      },
    );

    try {
      await _agoraService.initialize(widget.agoraAppId);
      await _agoraService.joinChannel(channelName: widget.channelName);
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to initialize: ${e.toString()}';
      });
    }
  }

  void _startAutoHideTimer() {
    // Cancel any existing timer
    _autoHideTimer?.cancel();

    // Start new timer for 5 seconds
    _autoHideTimer = Timer(const Duration(seconds: 5), () {
      if (mounted) {
        setState(() {
          _showControls = false;
        });
      }
    });
  }

  Future<void> _toggleMute() async {
    await _agoraService.toggleMute();
    setState(() {});
  }

  Future<void> _toggleCamera() async {
    await _agoraService.toggleCamera();
    setState(() {});
  }

  Future<void> _switchCamera() async {
    await _agoraService.switchCamera();
  }

  Future<void> _leaveChannel() async {
    await _agoraService.leaveChannel();
    await _agoraService.dispose();
    _autoHideTimer?.cancel();
    if (mounted) {
      Navigator.of(context).pop();
    }
  }

  void _showControlsUI() {
    setState(() {
      _showControls = true;
    });
    _startAutoHideTimer();
  }

  void _hideControlsUI() {
    setState(() {
      _showControls = false;
    });
    _autoHideTimer?.cancel();
  }

  void _navigateToScreen(Widget screen) {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (context) => screen)).then((_) {
      // Show controls when returning to video call
      if (mounted) {
        _showControlsUI();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: _errorMessage != null
            ? ErrorViewWidget(errorMessage: _errorMessage!)
            : _agoraService.isJoined
            ? GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  if (_showControls) {
                    _hideControlsUI();
                  } else {
                    _showControlsUI();
                  }
                },
                child: Stack(
                  children: [
                    // Video Views (Base Layer)
                    VideoViewsWidget(
                      engine: _agoraService.engine!,
                      remoteUids: _agoraService.remoteUids,
                      localUserJoined: _agoraService.localUserJoined,
                      isCameraOff: _agoraService.isCameraOff,
                      channelName: widget.channelName,
                    ),

                    // Controls and Overlays
                    VideoCallControlsWidget(
                      showControls: _showControls,
                      patientName: widget.patientName,
                      patientAge: widget.patientAge,
                      patientGender: widget.patientGender,
                      onMute: _toggleMute,
                      onSwitchCamera: _switchCamera,
                      onToggleCamera: _toggleCamera,
                      onLeaveChannel: _leaveChannel,
                      onPrescription: () =>
                          _navigateToScreen(const PrescriptionScreen()),
                      onDocuments: () =>
                          _navigateToScreen(const DocumentsScreen()),
                      onChat: () => _navigateToScreen(const ChatScreen()),
                      onBack: _leaveChannel,
                      isMuted: _agoraService.isMuted,
                      isCameraOff: _agoraService.isCameraOff,
                    ),
                  ],
                ),
              )
            : PatientInfoWidget(
                patientName: widget.patientName,
                patientAge: widget.patientAge,
                patientGender: widget.patientGender,
                onStartCall: _showControlsUI,
              ),
      ),
    );
  }
}
