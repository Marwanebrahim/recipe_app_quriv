import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  final String uid;
  final String email;
  final String name;
  final String? imagePath;
  UserModel({
    required this.uid,
    required this.email,
    required this.name,
    required this.imagePath,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      name: map['name'],
      imagePath: map['imagePath'],
    );
  }
  factory UserModel.fromUserCredential(UserCredential userCredential) {
    return UserModel(
      uid: userCredential.user!.uid,
      email: userCredential.user!.email!,
      name: userCredential.user!.displayName!,
      imagePath: userCredential.user!.photoURL,
    );
  }
  Map<String, dynamic> toMap() {
    return {'uid': uid, 'email': email, 'name': name, 'imagePath': imagePath};
  }
}
