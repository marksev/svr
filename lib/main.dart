import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  CameraController? _controller;
  bool _isRecording = false;

  Future<void> _toggleRecording() async {
    if (_controller == null) {
      final cameras = await availableCameras();
      _controller = CameraController(cameras.first, ResolutionPreset.medium);
      await _controller!.initialize();
    }
    if (_isRecording) {
      await _controller!.stopVideoRecording();
    } else {
      await _controller!.startVideoRecording();
    }
    setState(() {
      _isRecording = !_isRecording;
    });
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Video Recorder',
      home: Scaffold(
        body: Center(
          child: ElevatedButton(
            onPressed: _toggleRecording,
            child: Text(_isRecording ? 'Stop Recording' : 'Start Recording'),
          ),
        ),
      ),
    );
  }
}
