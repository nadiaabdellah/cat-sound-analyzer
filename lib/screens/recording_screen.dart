import 'dart:async';
import 'package:flutter/material.dart';
import 'package:record/record.dart';
import 'package:path_provider/path_provider.dart';
import 'package:cat_sound_analyzer/core/translations.dart';
import 'package:cat_sound_analyzer/screens/analyzing_screen.dart';

enum RecordingState {
  ready,
  recording,
  stop,
}

class Recording extends StatefulWidget {
  const Recording({super.key});

  @override
  State<Recording> createState() => _RecordingState();
}

class _RecordingState extends State<Recording> {
  RecordingState recordingState = RecordingState.ready;

  Timer? recordingTimer;
  int recordingSEC = 0;
  final AudioRecorder audioRecorder = AudioRecorder();

  String? audioPath;
  String? recordingError;

  Future<void> startRecording() async {
    try {
      final hasPermission = await audioRecorder.hasPermission();

      if (!hasPermission) {
        setState(() {
          recordingError = 'Microphone permission is required';
        });
        return;
      }

      final directory = await getApplicationDocumentsDirectory();

      final path =
          '${directory.path}/cat_${DateTime.now().millisecondsSinceEpoch}.m4a';

      await audioRecorder.start(
        const RecordConfig(encoder: AudioEncoder.aacLc),
        path: path,
      );

      if (!mounted) return;

      setState(() {
        recordingState = RecordingState.recording;
        audioPath = path;
        recordingError = null;
      });

      startTime();
    } catch (e) {
      if (!mounted) return;

      setState(() {
        recordingError = 'Could not start recording: $e';
      });
    }
  }

  Future<void> stopRecording() async {
    try {
      final path = await audioRecorder.stop();

      stopTimer();

      if (!mounted) return;

      setState(() {
        recordingState = RecordingState.stop;
        audioPath = path;
        recordingError = null;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        recordingError = 'Could not stop recording: $e';
      });
    }
  }

  void startTime() {
    recordingTimer?.cancel();
    recordingSEC = 0;
    recordingTimer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        if (!mounted) return;
        setState(() {
          recordingSEC++;
        });
      },
    );
  }

  void stopTimer() {
    recordingTimer?.cancel();
    recordingTimer = null;
  }

  String formatTime() {
    final minutes = recordingSEC ~/ 60;
    final seconds = recordingSEC % 60;
    return "${minutes.toString().padLeft(2, '0')} : ${seconds.toString().padLeft(2, '0')}";
  }

  @override
  void dispose() {
    recordingTimer?.cancel();
    audioRecorder.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(t(context, "Recording", "التسجيل")),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (recordingError != null)
              Text(
                recordingError!,
                style: const TextStyle(color: Colors.red),
              ),
            const Text(
              "🎙",
              style: TextStyle(fontSize: 50),
            ),
            const SizedBox(height: 20),
            Text(
              recordingState == RecordingState.ready
                  ? t(context, "Ready to record", "جاهز للتسجيل")
                  : recordingState == RecordingState.recording
                      ? t(context, "Recording...", "جارٍ التسجيل")
                      : t(context, "Recording finished", "تم التسجيل"),
              style: const TextStyle(fontSize: 28),
            ),
            const SizedBox(height: 15),
            Text(
              formatTime(),
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                if (recordingState == RecordingState.ready) {
                  await startRecording();
                } else if (recordingState == RecordingState.recording) {
                  await stopRecording();
                }
              },
              child: Text(
                recordingState == RecordingState.recording
                    ? t(context, "Stop Recording", "إيقاف التسجيل")
                    : recordingState == RecordingState.stop
                        ? t(context, "Start recording again", "بدء التسجيل مرة أخرى")
                        : t(context, "Start recording", "بدء التسجيل"),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: recordingState == RecordingState.stop && audioPath != null
                  ? () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Analyzing(),
                        ),
                      );
                    }
                  : null,
              child: Text(t(context, "Analyze recording", "تحليل التسجيل")),
            ),
          ],
        ),
      ),
    );
  }
}