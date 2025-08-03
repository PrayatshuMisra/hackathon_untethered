import 'package:hive/hive.dart';

part 'contact.g.dart';

@HiveType(typeId: 1)
class Contact extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String phoneNumber;

  @HiveField(3)
  final String? avatar;

  @HiveField(4)
  final String? email;

  @HiveField(5)
  final bool isFavorite;

  @HiveField(6)
  final DateTime lastContacted;

  @HiveField(7)
  final Map<String, dynamic>? metadata;

  Contact({
    required this.id,
    required this.name,
    required this.phoneNumber,
    this.avatar,
    this.email,
    this.isFavorite = false,
    required this.lastContacted,
    this.metadata,
  });

  factory Contact.fromJson(Map<String, dynamic> json) {
    return Contact(
      id: json['id'] as String,
      name: json['name'] as String,
      phoneNumber: json['phoneNumber'] as String,
      avatar: json['avatar'] as String?,
      email: json['email'] as String?,
      isFavorite: json['isFavorite'] as bool? ?? false,
      lastContacted: DateTime.parse(json['lastContacted'] as String),
      metadata: json['metadata'] as Map<String, dynamic>?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phoneNumber': phoneNumber,
      'avatar': avatar,
      'email': email,
      'isFavorite': isFavorite,
      'lastContacted': lastContacted.toIso8601String(),
      'metadata': metadata,
    };
  }

  Contact copyWith({
    String? id,
    String? name,
    String? phoneNumber,
    String? avatar,
    String? email,
    bool? isFavorite,
    DateTime? lastContacted,
    Map<String, dynamic>? metadata,
  }) {
    return Contact(
      id: id ?? this.id,
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      avatar: avatar ?? this.avatar,
      email: email ?? this.email,
      isFavorite: isFavorite ?? this.isFavorite,
      lastContacted: lastContacted ?? this.lastContacted,
      metadata: metadata ?? this.metadata,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Contact && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'Contact(id: $id, name: $name, phoneNumber: $phoneNumber)';
  }
} 