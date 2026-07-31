import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:recipe_app_quriv/core/constants/firebase_constants.dart';
import 'package:recipe_app_quriv/core/error/exceptions.dart';
import 'package:recipe_app_quriv/feature/auth/data/model/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> signUpWithEmail({
    required String email,
    required String password,
    required String name,
  });
  Future<UserModel> logInWithEmail({
    required String email,
    required String password,
  });

  Future<bool> isLoggedIn();

  Future<void> logOut();
}

class AuthRemoteDataSourceImplWithFireBase implements AuthRemoteDataSource {
  final FirebaseAuth auth;
  final FirebaseFirestore db;

  AuthRemoteDataSourceImplWithFireBase({required this.auth, required this.db});

  CollectionReference get _usersCollection =>
      db.collection(FirebaseConstants.usersCollection);

  @override
  Future<UserModel> signUpWithEmail({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      final userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final uid = userCredential.user!.uid;
      final user = UserModel(
        email: email,
        name: name,
        imagePath: null,
        uid: uid,
      );
      final userData = user.toMap();
      await _usersCollection.doc(uid).set(userData);

      return user;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'email-already-in-use':
          throw EmailAlreadyInUseException();
        default:
          throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<UserModel> logInWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final uid = userCredential.user!.uid;

      final docSnapshot = await _usersCollection.doc(uid).get();
      if (!docSnapshot.exists) {
        final user = UserModel(
          email: email,
          name: userCredential.user!.displayName!,
          imagePath: userCredential.user!.photoURL,
          uid: uid,
        );
        final userData = user.toMap();
        await _usersCollection.doc(uid).set(userData);
        return user;
      }
      return UserModel.fromMap(docSnapshot.data() as Map<String, dynamic>);
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'user-not-found':
        case 'wrong-password':
        case 'invalid-credential':
          throw InvalidCredentialsException();
        default:
          throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<bool> isLoggedIn() {
    try {
      final user = auth.currentUser;
      return Future.value(user != null);
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<void> logOut() {
    try {
      return auth.signOut();
    } catch (e) {
      throw ServerException();
    }
  }
}
