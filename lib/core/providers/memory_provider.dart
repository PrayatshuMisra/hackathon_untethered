import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';
import '../models/memory.dart';

class MemoryProvider extends ChangeNotifier {
  final Box<Memory> _memoryBox = Hive.box<Memory>('memories');
  final List<Memory> _memories = [];
  bool _isRecording = false;
  String _currentTranscript = '';
  DateTime? _recordingStartTime;

  List<Memory> get memories => _memories;
  bool get isRecording => _isRecording;
  String get currentTranscript => _currentTranscript;
  DateTime? get recordingStartTime => _recordingStartTime;

  MemoryProvider() {
    _loadMemories();
  }

  Future<void> _loadMemories() async {
    _memories.clear();
    _memories.addAll(_memoryBox.values.toList());
    _memories.sort((a, b) => b.timestamp.compareTo(a.timestamp));
    notifyListeners();
  }

  Future<void> addMemory({
    required String transcript,
    String? imagePath,
    List<String>? detectedObjects,
    String? mood,
    String? category,
  }) async {
    final memory = Memory(
      id: const Uuid().v4(),
      transcript: transcript,
      imagePath: imagePath,
      detectedObjects: detectedObjects ?? [],
      mood: mood ?? 'neutral',
      category: category ?? 'general',
      timestamp: DateTime.now(),
    );

    await _memoryBox.put(memory.id, memory);
    _memories.insert(0, memory);
    notifyListeners();
  }

  Future<void> deleteMemory(String id) async {
    await _memoryBox.delete(id);
    _memories.removeWhere((memory) => memory.id == id);
    notifyListeners();
  }

  Future<void> deleteMemoriesFromToday() async {
    final today = DateTime.now();
    final todayMemories = _memories.where((memory) {
      return memory.timestamp.year == today.year &&
             memory.timestamp.month == today.month &&
             memory.timestamp.day == today.day;
    }).toList();

    for (final memory in todayMemories) {
      await _memoryBox.delete(memory.id);
      _memories.remove(memory);
    }
    notifyListeners();
  }

  Future<void> deleteLastMinutes(int minutes) async {
    final cutoffTime = DateTime.now().subtract(Duration(minutes: minutes));
    final recentMemories = _memories.where((memory) {
      return memory.timestamp.isAfter(cutoffTime);
    }).toList();

    for (final memory in recentMemories) {
      await _memoryBox.delete(memory.id);
      _memories.remove(memory);
    }
    notifyListeners();
  }

  void startRecording() {
    _isRecording = true;
    _recordingStartTime = DateTime.now();
    _currentTranscript = '';
    notifyListeners();
  }

  void stopRecording() {
    _isRecording = false;
    _recordingStartTime = null;
    notifyListeners();
  }

  void updateTranscript(String transcript) {
    _currentTranscript = transcript;
    notifyListeners();
  }

  List<Memory> getMemoriesByCategory(String category) {
    if (category == 'All') return _memories;
    return _memories.where((memory) => memory.category == category).toList();
  }

  List<Memory> searchMemories(String query) {
    return _memories.where((memory) {
      return memory.transcript.toLowerCase().contains(query.toLowerCase()) ||
             memory.detectedObjects.any((obj) => 
                 obj.toLowerCase().contains(query.toLowerCase()));
    }).toList();
  }

  String getDaySummary() {
    final today = DateTime.now();
    final todayMemories = _memories.where((memory) {
      return memory.timestamp.year == today.year &&
             memory.timestamp.month == today.month &&
             memory.timestamp.day == today.day;
    }).toList();

    if (todayMemories.isEmpty) {
      return 'No memories recorded today.';
    }

    final transcript = todayMemories.map((m) => m.transcript).join(' ');
    // In a real app, this would use an offline AI model for summarization
    return 'Today you had ${todayMemories.length} interactions. Key moments: ${transcript.substring(0, transcript.length > 100 ? 100 : transcript.length)}...';
  }

  String getCurrentMood() {
    final today = DateTime.now();
    final todayMemories = _memories.where((memory) {
      return memory.timestamp.year == today.year &&
             memory.timestamp.month == today.month &&
             memory.timestamp.day == today.day;
    }).toList();

    if (todayMemories.isEmpty) return '😊 Positive Day';

    // Simple mood calculation based on keywords
    final positiveKeywords = ['happy', 'good', 'great', 'excellent', 'wonderful'];
    final negativeKeywords = ['sad', 'bad', 'terrible', 'awful', 'disappointed'];
    
    int positiveCount = 0;
    int negativeCount = 0;

    for (final memory in todayMemories) {
      final text = memory.transcript.toLowerCase();
      for (final keyword in positiveKeywords) {
        if (text.contains(keyword)) positiveCount++;
      }
      for (final keyword in negativeKeywords) {
        if (text.contains(keyword)) negativeCount++;
      }
    }

    if (positiveCount > negativeCount) return '😊 Positive Day';
    if (negativeCount > positiveCount) return '😔 Challenging Day';
    return '😐 Neutral Day';
  }
} 