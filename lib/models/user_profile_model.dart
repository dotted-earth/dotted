// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserProfileModel {
  String id;
  String? username;
  String? fullName;
  bool isEmailVerified;
  bool hasOnBoarded;

  UserProfileModel({
    required this.id,
    this.username,
    this.fullName,
    required this.isEmailVerified,
    required this.hasOnBoarded,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'username': username,
      'fullName': fullName,
      'isEmailVerified': isEmailVerified,
      'hasOnBoarded': hasOnBoarded,
    };
  }

  factory UserProfileModel.fromMap(Map<String, dynamic> map) {
    return UserProfileModel(
      id: map['id'] as String,
      username: map['username'] != null ? map['username'] as String : null,
      fullName: map['full_name'] != null ? map['full_name'] as String : null,
      isEmailVerified: map['is_email_verified'] as bool,
      hasOnBoarded: map['has_onboarded'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserProfileModel.fromJson(String source) =>
      UserProfileModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
