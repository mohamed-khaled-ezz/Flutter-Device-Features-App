import 'dart:io';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';

/// Screen for recording voice audio using `record` package and playing back using `audioplayers`.
class AudioRecorderScreen extends StatefulWidget {
  const AudioRecorderScreen({super.key});

  @override
  State<AudioRecorderScreen> createState() => _AudioRecorderScreenState();
}

class _AudioRecorderScreenState extends State<AudioRecorderScreen> {
  late final AudioRecorder _audioRecorder;
  late final AudioPlayer _audioPlayer;

  bool _isRecording = false;
  bool _isPlaying = false;
  String? _recordedFilePath;

  @override
  void initState() {
    super.initState();
    _audioRecorder = AudioRecorder();
    _audioPlayer = AudioPlayer();

    // Listen to player state changes to update play/pause status in UI
    _audioPlayer.onPlayerStateChanged.listen((state) {
      if (mounted) {
        setState(() {
          _isPlaying = state == PlayerState.playing;
        });
      }
    });
  }

  @override
  void dispose() {
    _audioRecorder.dispose();
    _audioPlayer.dispose();
    super.dispose();
  }

  /// Toggles voice audio recording on/off using the record package.
  Future<void> _toggleRecording() async {
    try {
      if (_isRecording) {
        // Stop recording
        final String? path = await _audioRecorder.stop();
        setState(() {
          _isRecording = false;
          _recordedFilePath = path;
        });
        if (mounted && path != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Recording saved successfully!')),
          );
        }
      } else {
        // Check for microphone recording permission
        if (await _audioRecorder.hasPermission()) {
          final Directory tempDir = await getTemporaryDirectory();
          final String path =
              '${tempDir.path}/recorded_voice_${DateTime.now().millisecondsSinceEpoch}.m4a';

          // Start audio recording
          await _audioRecorder.start(
            const RecordConfig(encoder: AudioEncoder.aacLc),
            path: path,
          );

          setState(() {
            _isRecording = true;
          });
        } else {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  'Microphone permission is required to record audio.',
                ),
              ),
            );
          }
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error recording audio: $e')));
      }
    }
  }

  /// Plays back recorded audio or pauses playback using the audioplayers package.
  Future<void> _playRecordedAudio() async {
    if (_recordedFilePath == null) return;

    try {
      if (_isPlaying) {
        await _audioPlayer.pause();
      } else {
        await _audioPlayer.stop();
        await _audioPlayer.play(DeviceFileSource(_recordedFilePath!));
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error playing audio: $e')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Audio Recorder')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Recording status icon and text
              Icon(
                _isRecording ? Icons.mic : Icons.mic_none,
                size: 80,
                color: _isRecording
                    ? Colors.red
                    : Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(height: 16),
              Text(
                _isRecording
                    ? 'Recording voice...'
                    : _recordedFilePath != null
                    ? 'Voice recording ready'
                    : 'Tap button to start recording',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 32),

              // Button 1: Record Audio button
              SizedBox(
                width: 220,
                height: 50,
                child: ElevatedButton.icon(
                  onPressed: _toggleRecording,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _isRecording ? Colors.red : null,
                    foregroundColor: _isRecording ? Colors.white : null,
                  ),
                  icon: Icon(
                    _isRecording ? Icons.stop : Icons.fiber_manual_record,
                  ),
                  label: Text(_isRecording ? 'Stop Recording' : 'Record Audio'),
                ),
              ),
              const SizedBox(height: 20),

              // Button 2: Play Audio button - appears once a recording exists
              if (_recordedFilePath != null)
                SizedBox(
                  width: 220,
                  height: 50,
                  child: ElevatedButton.icon(
                    onPressed: _isPlaying
                        ? _playRecordedAudio
                        : _playRecordedAudio,
                    icon: Icon(_isPlaying ? Icons.pause : Icons.play_arrow),
                    label: Text(_isPlaying ? 'Pause Audio' : 'Play Audio'),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
