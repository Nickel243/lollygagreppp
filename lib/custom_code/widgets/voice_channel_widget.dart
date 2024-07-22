// Automatic FlutterFlow imports
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:agora_rtc_engine/rtc_local_view.dart' as RtcLocalView;
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

// user agora_rtc_engine: ^5.3.0
class VoiceChannelWidget extends StatefulWidget {
  const VoiceChannelWidget({
    Key? key,
    this.width,
    this.height,
    required this.channelName,
    required this.appId,
    required this.token,
    this.enableSpeakerPhone = true,
  }) : super(key: key);

  final double? width;
  final double? height;
  final String channelName;
  final String appId;
  final String token;
  final bool enableSpeakerPhone;

  @override
  _VoiceChannelWidgetState createState() => _VoiceChannelWidgetState();
}

class _VoiceChannelWidgetState extends State<VoiceChannelWidget>
    with WidgetsBindingObserver {
  late RtcEngine _engine;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    initAgora();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _engine.leaveChannel();
    _engine.destroy();
    super.dispose();
  }

  Future<void> initAgora() async {
    // Retrieve permissions
    if (!kIsWeb) {
      await [Permission.microphone].request();
    }

    // Create the engine
    _engine = await RtcEngine.create(widget.appId);

    await _engine.enableAudio();

    _engine.setEventHandler(
      RtcEngineEventHandler(
        joinChannelSuccess: (String channel, int uid, int elapsed) {
          print("local user $uid joined");

          _engine.setEnableSpeakerphone(widget.enableSpeakerPhone);
        },
      ),
    );
    print("joining ${widget.channelName}");

    await _engine.joinChannel(widget.token, widget.channelName, null, 0);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: Center(
        child: Text("Voice Channel: ${widget.channelName}"),
      ),
    );
  }
}
