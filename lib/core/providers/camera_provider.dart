import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class CameraProvider extends ChangeNotifier {
  CameraController? _controller;
  List<CameraDescription> _cameras = [];
  bool _isInitialized = false;
  bool _isRecording = false;
  bool _isObjectDetectionEnabled = true;
  List<String> _detectedObjects = [];
  double _calories = 0.0;
  String _detectedText = '';

  CameraController? get controller => _controller;
  List<CameraDescription> get cameras => _cameras;
  bool get isInitialized => _isInitialized;
  bool get isRecording => _isRecording;
  bool get isObjectDetectionEnabled => _isObjectDetectionEnabled;
  List<String> get detectedObjects => _detectedObjects;
  double get calories => _calories;
  String get detectedText => _detectedText;

  Future<void> initializeCamera() async {
    try {
      _cameras = await availableCameras();
      if (_cameras.isNotEmpty) {
        _controller = CameraController(
          _cameras[0],
          ResolutionPreset.high,
          enableAudio: true,
        );
        await _controller!.initialize();
        _isInitialized = true;
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Error initializing camera: $e');
    }
  }

  Future<void> switchCamera() async {
    if (_cameras.length < 2) return;
    
    final currentIndex = _cameras.indexOf(_controller!.description);
    final newIndex = (currentIndex + 1) % _cameras.length;
    
    await _controller!.dispose();
    _controller = CameraController(
      _cameras[newIndex],
      ResolutionPreset.high,
      enableAudio: true,
    );
    await _controller!.initialize();
    notifyListeners();
  }

  Future<void> toggleRecording() async {
    if (!_isInitialized) return;

    if (_isRecording) {
      await stopRecording();
    } else {
      await startRecording();
    }
  }

  Future<void> startRecording() async {
    if (!_isInitialized) return;

    try {
      await _controller!.startVideoRecording();
      _isRecording = true;
      notifyListeners();
    } catch (e) {
      debugPrint('Error starting recording: $e');
    }
  }

  Future<void> stopRecording() async {
    if (!_isInitialized || !_isRecording) return;

    try {
      final file = await _controller!.stopVideoRecording();
      _isRecording = false;
      notifyListeners();
      debugPrint('Video saved to: ${file.path}');
    } catch (e) {
      debugPrint('Error stopping recording: $e');
    }
  }

  Future<void> takePicture() async {
    if (!_isInitialized) return;

    try {
      final file = await _controller!.takePicture();
      await _analyzeImage(file.path);
      debugPrint('Picture saved to: ${file.path}');
    } catch (e) {
      debugPrint('Error taking picture: $e');
    }
  }

  Future<void> _analyzeImage(String imagePath) async {
    // Simulate object detection
    await Future.delayed(const Duration(seconds: 1));
    
    _detectedObjects = [
      'person',
      'chair',
      'table',
      'laptop',
      'coffee cup',
    ];
    
    _calories = 150.0; // Simulated calorie detection
    _detectedText = 'Sample text detected in image';
    
    notifyListeners();
  }

  void toggleObjectDetection() {
    _isObjectDetectionEnabled = !_isObjectDetectionEnabled;
    if (!_isObjectDetectionEnabled) {
      _detectedObjects.clear();
      _calories = 0.0;
      _detectedText = '';
    }
    notifyListeners();
  }

  void clearDetections() {
    _detectedObjects.clear();
    _calories = 0.0;
    _detectedText = '';
    notifyListeners();
  }

  Future<void> pickImageFromGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    
    if (pickedFile != null) {
      await _analyzeImage(pickedFile.path);
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }
} 