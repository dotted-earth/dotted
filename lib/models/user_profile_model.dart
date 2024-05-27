import 'dart:convert';

class UserProfileModel {
  String id;
  String? username;
  String? fullName;
  bool isEmailVerified;
  bool hasOnBoarded;
  String? avatarUrl;

  UserProfileModel({
    required this.id,
    required this.isEmailVerified,
    required this.hasOnBoarded,
    this.username,
    this.fullName,
    this.avatarUrl,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'username': username,
      'full_name': fullName,
      'is_email_verified': isEmailVerified,
      'has_on_boarded': hasOnBoarded,
      'avatar_url': avatarUrl
    };
  }

  factory UserProfileModel.fromMap(Map<String, dynamic> map) {
    return UserProfileModel(
        id: map['id'] as String,
        username: map['username'] != null ? map['username'] as String : null,
        fullName: map['full_name'] != null ? map['full_name'] as String : null,
        isEmailVerified: map['is_email_verified'] as bool,
        hasOnBoarded: map['has_on_boarded'] as bool,
        avatarUrl:
            map['avatar_url'] != null ? map['avatar_url'] as String : null);
  }

  String toJson() => json.encode(toMap());

  factory UserProfileModel.fromJson(String source) =>
      UserProfileModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
