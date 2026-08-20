class UserEntity {
  final String uid;
  final String email;
  final String name;
  final String? imagePath;

  const UserEntity({
    required this.uid,
    required this.email,
    required this.name,
    required this.imagePath,
  });

  UserEntity copyWith({
    String? uid,
    String? email,
    String? name,
    String? imagePath,
  }) {
    return UserEntity(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      name: name ?? this.name,
      imagePath: imagePath ?? this.imagePath,
    );
  }
}
