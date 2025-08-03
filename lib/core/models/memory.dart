import 'package:hive/hive.dart';

part 'memory.g.dart';

@HiveType(typeId: 0)
class Memory extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String transcript;

  @HiveField(2)
  final String? imagePath;

  @HiveField(3)
  final List<String> detectedObjects;

  @HiveField(4)
  final String mood;

  @HiveField(5)
  final String category;

  @HiveField(6)
  final DateTime timestamp;

  @HiveField(7)
  final double? confidence;

  @HiveField(8)
  final Map<String, dynamic>? metadata;

  Memory({
    required this.id,
    required this.transcript,
    this.imagePath,
    required this.detectedObjects,
    required this.mood,
    required this.category,
    required this.timestamp,
    this.confidence,
    this.metadata,
  });

  factory Memory.fromJson(Map<String, dynamic> json) {
    return Memory(
      id: json['id'] as String,
      transcript: json['transcript'] as String,
      imagePath: json['imagePath'] as String?,
      detectedObjects: List<String>.from(json['detectedObjects'] ?? []),
      mood: json['mood'] as String,
      category: json['category'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
      confidence: json['confidence'] as double?,
      metadata: json['metadata'] as Map<String, dynamic>?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'transcript': transcript,
      'imagePath': imagePath,
      'detectedObjects': detectedObjects,
      'mood': mood,
      'category': category,
      'timestamp': timestamp.toIso8601String(),
      'confidence': confidence,
      'metadata': metadata,
    };
  }

  Memory copyWith({
    String? id,
    String? transcript,
    String? imagePath,
    List<String>? detectedObjects,
    String? mood,
    String? category,
    DateTime? timestamp,
    double? confidence,
    Map<String, dynamic>? metadata,
  }) {
    return Memory(
      id: id ?? this.id,
      transcript: transcript ?? this.transcript,
      imagePath: imagePath ?? this.imagePath,
      detectedObjects: detectedObjects ?? this.detectedObjects,
      mood: mood ?? this.mood,
      category: category ?? this.category,
      timestamp: timestamp ?? this.timestamp,
      confidence: confidence ?? this.confidence,
      metadata: metadata ?? this.metadata,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Memory && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'Memory(id: $id, transcript: $transcript, timestamp: $timestamp)';
  }
} 