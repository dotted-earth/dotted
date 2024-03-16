class UserProfile {
  String id;
  String? updatedAt;
  String? username;
  String? fullName;
  String? avatarUrl;
  String? website;
  bool isEmailVerified;
  bool hasOnboarded;

  UserProfile({
    required this.id,
    required this.isEmailVerified,
    required this.hasOnboarded,
  });
}
