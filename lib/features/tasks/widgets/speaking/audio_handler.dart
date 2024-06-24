import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../utils/show_snack_bar.dart';
import '../../models/speaking/speaking_item.dart';

class AudioHandler extends StatefulWidget {
  const AudioHandler({
    super.key,
    required this.item,
    required this.onRecordComplete,
  });

  final SpeakingItem item;
  final Function(String?) onRecordComplete;

  @override
  AudioHandlerState createState() => AudioHandlerState();
}

class AudioHandlerState extends State<AudioHandler> {
  final FlutterSoundRecorder _recorder = FlutterSoundRecorder();
  final FlutterSoundPlayer _player = FlutterSoundPlayer();
  bool _isRecording = false;
  bool _isPlaying = false;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    await _recorder.openRecorder();
    await _player.openPlayer();
  }

  @override
  void dispose() {
    _recorder.closeRecorder();
    _player.closePlayer();
    _timer?.cancel();
    super.dispose();
  }

  Future<String> _getAppSpecificFilePath(String fileName) async {
    final directory = await getApplicationDocumentsDirectory();
    return '${directory.path}/$fileName';
  }

  void _stopRecording() async {
    await _recorder.stopRecorder();
    setState(() {
      _isRecording = false;
    });
    widget.onRecordComplete(widget.item.recordedFilePath);
  }

  void _startRecording() async {
    try {
      if (await Permission.microphone.request().isGranted) {
        widget.item.recordedFilePath =
            await _getAppSpecificFilePath('audio_${widget.item.phrase}.wav');
        await _recorder.startRecorder(
          toFile: widget.item.recordedFilePath,
          codec: Codec.pcm16WAV,
        );
        setState(() {
          _isRecording = true;
        });

        _timer = Timer(const Duration(seconds: 10), _stopRecording);
      } else {
        if (mounted) {
          showSnackBar(
            context,
            'Microphone permission is not granted. Please enable it in settings.',
          );
        }
      }
    } catch (e) {
      if (mounted) {
        showSnackBar(context, 'Error during recording: ${e.toString()}');
      }
    }
  }

  void _recordPronunciation() {
    if (_isRecording) {
      _stopRecording();
      _timer?.cancel();
    } else {
      _startRecording();
    }
  }

  void _playRecording() async {
    try {
      if (_isPlaying) {
        await _player.stopPlayer();
        setState(() {
          _isPlaying = false;
        });
      } else if (widget.item.recordedFilePath != null) {
        await _player.startPlayer(
          fromURI: widget.item.recordedFilePath!,
          codec: Codec.pcm16WAV,
          whenFinished: () {
            setState(() {
              _isPlaying = false;
            });
          },
        );
        setState(() {
          _isPlaying = true;
        });
      } else {
        if (mounted) {
          showSnackBar(context, 'No recording found to play.');
        }
      }
    } catch (e) {
      if (mounted) {
        showSnackBar(context, 'Error during playback: ${e.toString()}');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton.filled(
          icon: Icon(_isRecording ? Icons.stop : Icons.mic, size: 64),
          onPressed: _recordPronunciation,
          style: IconButton.styleFrom(
            backgroundColor: const Color(0xFFEF6D57),
          ),
        ),
        if (widget.item.recordedFilePath != null && !_isRecording) ...[
          const SizedBox(width: 16),
          IconButton.filled(
            icon: Icon(_isPlaying ? Icons.stop : Icons.play_arrow, size: 64),
            onPressed: _playRecording,
            style: IconButton.styleFrom(
              backgroundColor: const Color(0xFF61B68C),
            ),
          ),
        ],
      ],
    );
  }
}
