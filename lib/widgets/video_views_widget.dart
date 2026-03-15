import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';

class VideoViewsWidget extends StatelessWidget {
  final RtcEngine engine;
  final List<int> remoteUids;
  final bool localUserJoined;
  final bool isCameraOff;
  final String channelName;

  const VideoViewsWidget({
    super.key,
    required this.engine,
    required this.remoteUids,
    required this.localUserJoined,
    required this.isCameraOff,
    required this.channelName,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        remoteUids.isNotEmpty
            ? AgoraVideoView(
                controller: VideoViewController.remote(
                  rtcEngine: engine,
                  canvas: VideoCanvas(uid: remoteUids.first),
                  connection: RtcConnection(channelId: channelName),
                ),
              )
            : const _WaitingViewWidget(),

        if (localUserJoined)
          Positioned(
            bottom: 16,
            right: 16,
            child: Container(
              width: 120,
              height: 160,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: isCameraOff
                    ? Container(
                        color: Colors.grey[800],
                        child: const Center(
                          child: Icon(
                            Icons.videocam_off,
                            color: Colors.white,
                            size: 32,
                          ),
                        ),
                      )
                    : AgoraVideoView(
                        controller: VideoViewController(
                          rtcEngine: engine,
                          canvas: const VideoCanvas(uid: 0),
                        ),
                      ),
              ),
            ),
          ),
      ],
    );
  }
}

class _WaitingViewWidget extends StatelessWidget {
  const _WaitingViewWidget();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[200],
      child: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text(
              'Waiting for remote user...',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
