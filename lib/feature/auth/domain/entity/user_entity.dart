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
}
