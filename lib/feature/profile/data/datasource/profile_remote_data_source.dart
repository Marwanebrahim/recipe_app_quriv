import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:recipe_app_quriv/core/constants/firebase_constants.dart';
import 'package:recipe_app_quriv/core/error/exceptions.dart';
import 'package:recipe_app_quriv/feature/auth/data/model/user_model.dart';

abstract class ProfileRemoteDataSource {
  Future<UserModel> getUserProfile();
  Future<UserModel> updateUserProfile({required UserModel user});
}

class ProfileRemoteDataSourceImplWithFirebase
    implements ProfileRemoteDataSource {
  final FirebaseFirestore db;
  final FirebaseAuth firebaseAuth;
  ProfileRemoteDataSourceImplWithFirebase({
    required this.db,
    required this.firebaseAuth,
  });

  CollectionReference get _usersCollection =>
      db.collection(FirebaseConstants.usersCollection);
  String get uid => firebaseAuth.currentUser!.uid;
  @override
  Future<UserModel> getUserProfile() async {
    try {
      final doc = await _usersCollection.doc(uid).get();
      if (!doc.exists) throw ServerException();
      return UserModel.fromMap(doc.data() as Map<String, dynamic>);
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<UserModel> updateUserProfile({required UserModel user}) async {
    try {
      await _usersCollection.doc(uid).update({
        'name': user.name,
        'imagePath': user.imagePath,
      });
      final doc = await _usersCollection.doc(uid).get();
      return UserModel.fromMap(doc.data() as Map<String, dynamic>);
    } catch (e) {
      throw ServerException();
    }
  }
}
