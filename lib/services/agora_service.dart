import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:permission_handler/permission_handler.dart';
import '../config/agora_config.dart';

class AgoraService {
  RtcEngine? _engine;
  bool _isInitialized = false;

  // State callbacks
  final Function(bool isJoined)? onJoinChannelSuccess;
  final Function(int remoteUid)? onUserJoined;
  final Function(int remoteUid, UserOfflineReasonType reason)? onUserOffline;
  final Function()? onLeaveChannel;
  final Function(String error)? onError;

  // State tracking
  bool isJoined = false;
  bool isMuted = false;
  bool isCameraOff = false;
  bool localUserJoined = false;
  int? remoteUid;
  final List<int> remoteUids = [];

  AgoraService({
    this.onJoinChannelSuccess,
    this.onUserJoined,
    this.onUserOffline,
    this.onLeaveChannel,
    this.onError,
  });

  /// Initialize the Agora RTC Engine
  Future<void> initialize(String appId) async {
    if (_isInitialized) return;

    try {
      // Request permissions
      await _requestPermissions();

      // Create and initialize the RtcEngine
      _engine = createAgoraRtcEngine();
      await _engine!.initialize(
        RtcEngineContext(
          appId: appId,
          channelProfile: ChannelProfileType.channelProfileCommunication,
        ),
      );

      // Set event handlers
      _engine!.registerEventHandler(
        RtcEngineEventHandler(
          onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
            isJoined = true;
            localUserJoined = true;
            onJoinChannelSuccess?.call(true);
          },
          onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
            this.remoteUid = remoteUid;
            remoteUids.add(remoteUid);
            onUserJoined?.call(remoteUid);
          },
          onUserOffline:
              (
                RtcConnection connection,
                int remoteUid,
                UserOfflineReasonType reason,
              ) {
                remoteUids.remove(remoteUid);
                if (remoteUids.isEmpty) {
                  this.remoteUid = null;
                }
                onUserOffline?.call(remoteUid, reason);
              },
          onLeaveChannel: (RtcConnection connection, RtcStats stats) {
            isJoined = false;
            localUserJoined = false;
            remoteUids.clear();
            remoteUid = null;
            onLeaveChannel?.call();
          },
          onError: (ErrorCodeType err, String msg) {
            String errorDetails = 'Agora Error: $msg (Code: $err)';

            // Add helpful information for common errors
            if (err == ErrorCodeType.errInvalidToken) {
              errorDetails +=
                  '\n\nYour Agora project requires token authentication. '
                  'Please enable "App Certificate" in Agora Console or '
                  'provide a valid token.';
            }

            onError?.call(errorDetails);
          },
        ),
      );

      // Enable video
      await _engine!.enableVideo();

      // Set channel profile
      await _engine!.setClientRole(role: ClientRoleType.clientRoleBroadcaster);

      _isInitialized = true;
    } catch (e) {
      onError?.call('Failed to initialize: ${e.toString()}');
      rethrow;
    }
  }

  /// Join a channel
  Future<void> joinChannel({
    required String channelName,
    String? token,
    int uid = 0,
  }) async {
    if (_engine == null || !_isInitialized) {
      throw Exception('Agora engine not initialized');
    }

    await _engine!.joinChannel(
      token: token ?? AgoraConfig.token,
      channelId: channelName,
      uid: uid,
      options: const ChannelMediaOptions(
        channelProfile: ChannelProfileType.channelProfileCommunication,
        clientRoleType: ClientRoleType.clientRoleBroadcaster,
      ),
    );
  }

  /// Leave the current channel
  Future<void> leaveChannel() async {
    if (_engine == null) return;

    await _engine!.leaveChannel();
  }

  /// Toggle microphone mute state
  Future<void> toggleMute() async {
    if (_engine == null) return;

    await _engine!.muteLocalAudioStream(!isMuted);
    isMuted = !isMuted;
  }

  /// Toggle camera mute state
  Future<void> toggleCamera() async {
    if (_engine == null) return;

    await _engine!.muteLocalVideoStream(!isCameraOff);
    isCameraOff = !isCameraOff;
  }

  /// Switch between front and back camera
  Future<void> switchCamera() async {
    if (_engine == null) return;

    await _engine!.switchCamera();
  }

  /// Release the Agora engine and cleanup resources
  Future<void> dispose() async {
    if (_engine == null) return;

    await _engine!.release();
    _engine = null;
    _isInitialized = false;
  }

  /// Get the RtcEngine instance
  RtcEngine? get engine => _engine;

  /// Check if the engine is initialized
  bool get isEngineInitialized => _isInitialized;

  /// Request camera and microphone permissions
  Future<void> _requestPermissions() async {
    final statuses = await [Permission.camera, Permission.microphone].request();

    if (statuses[Permission.camera]!.isDenied ||
        statuses[Permission.microphone]!.isDenied) {
      throw Exception('Camera or microphone permission denied');
    }
  }
}
