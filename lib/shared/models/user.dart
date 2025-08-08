// Temporarily converted to regular class to fix Freezed issues
// import 'package:freezed_annotation/freezed_annotation.dart';

class User {
  final String id;
  final String email;
  final String? displayName;
  final String? photoURL;
  final double collectionValue;
  final int totalCards;
  final DateTime joinDate;
  final String? preferences; // JSON string
  final String? location;
  final DateTime createdAt;
  final DateTime updatedAt;

  const User({
    required this.id,
    required this.email,
    this.displayName,
    this.photoURL,
    this.collectionValue = 0.0,
    this.totalCards = 0,
    required this.joinDate,
    this.preferences,
    this.location,
    required this.createdAt,
    required this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String,
      email: json['email'] as String,
      displayName: json['displayName'] as String?,
      photoURL: json['photoURL'] as String?,
      collectionValue: (json['collectionValue'] as num?)?.toDouble() ?? 0.0,
      totalCards: json['totalCards'] as int? ?? 0,
      joinDate: DateTime.parse(json['joinDate'] as String),
      preferences: json['preferences'] as String?,
      location: json['location'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'displayName': displayName,
      'photoURL': photoURL,
      'collectionValue': collectionValue,
      'totalCards': totalCards,
      'joinDate': joinDate.toIso8601String(),
      'preferences': preferences,
      'location': location,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  User copyWith({
    String? id,
    String? email,
    String? displayName,
    String? photoURL,
    double? collectionValue,
    int? totalCards,
    DateTime? joinDate,
    String? preferences,
    String? location,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      displayName: displayName ?? this.displayName,
      photoURL: photoURL ?? this.photoURL,
      collectionValue: collectionValue ?? this.collectionValue,
      totalCards: totalCards ?? this.totalCards,
      joinDate: joinDate ?? this.joinDate,
      preferences: preferences ?? this.preferences,
      location: location ?? this.location,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is User &&
        other.id == id &&
        other.email == email &&
        other.displayName == displayName &&
        other.photoURL == photoURL &&
        other.collectionValue == collectionValue &&
        other.totalCards == totalCards &&
        other.joinDate == joinDate &&
        other.preferences == preferences &&
        other.location == location &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        email.hashCode ^
        displayName.hashCode ^
        photoURL.hashCode ^
        collectionValue.hashCode ^
        totalCards.hashCode ^
        joinDate.hashCode ^
        preferences.hashCode ^
        location.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }

  @override
  String toString() {
    return 'User(id: $id, email: $email, displayName: $displayName, photoURL: $photoURL, collectionValue: $collectionValue, totalCards: $totalCards, joinDate: $joinDate, preferences: $preferences, location: $location, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}

// Extension para métodos de SQLite y Firestore
extension UserExtensions on User {
  // SQLite helpers
  Map<String, dynamic> toMap() => {
    'id': id,
    'email': email,
    'display_name': displayName,
    'photo_url': photoURL,
    'collection_value': collectionValue,
    'total_cards': totalCards,
    'join_date': joinDate.millisecondsSinceEpoch,
    'preferences': preferences,
    'location': location,
    'created_at': createdAt.millisecondsSinceEpoch,
    'updated_at': updatedAt.millisecondsSinceEpoch,
  };

  static User fromMap(Map<String, dynamic> map) => User(
    id: map['id'] as String,
    email: map['email'] as String,
    displayName: map['display_name'] as String?,
    photoURL: map['photo_url'] as String?,
    collectionValue: (map['collection_value'] as num?)?.toDouble() ?? 0.0,
    totalCards: map['total_cards'] as int? ?? 0,
    joinDate: DateTime.fromMillisecondsSinceEpoch(map['join_date'] as int),
    preferences: map['preferences'] as String?,
    location: map['location'] as String?,
    createdAt: DateTime.fromMillisecondsSinceEpoch(map['created_at'] as int),
    updatedAt: DateTime.fromMillisecondsSinceEpoch(map['updated_at'] as int),
  );

  // Firestore helpers
  Map<String, dynamic> toFirestore() => {
    'id': id,
    'email': email,
    'displayName': displayName,
    'photoURL': photoURL,
    'collectionValue': collectionValue,
    'totalCards': totalCards,
    'joinDate': joinDate,
    'preferences': preferences,
    'location': location,
    'createdAt': createdAt,
    'updatedAt': updatedAt,
  };

  static User fromFirestore(Map<String, dynamic> data) => User(
    id: data['id'] as String,
    email: data['email'] as String,
    displayName: data['displayName'] as String?,
    photoURL: data['photoURL'] as String?,
    collectionValue: (data['collectionValue'] as num?)?.toDouble() ?? 0.0,
    totalCards: data['totalCards'] as int? ?? 0,
    joinDate: (data['joinDate'] as DateTime),
    preferences: data['preferences'] as String?,
    location: data['location'] as String?,
    createdAt: (data['createdAt'] as DateTime),
    updatedAt: (data['updatedAt'] as DateTime),
  );
} 