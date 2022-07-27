import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:note_app_flutter/app/types/app_enum.dart';
import 'package:note_app_flutter/core/exceptions/exceptions.dart';
import 'package:note_app_flutter/data/models/models.dart';

class AuthenticationRepository {
  AuthenticationRepository();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  Stream<AuthenticationStatus> status() {
    return _firebaseAuth.authStateChanges().map((user) => user != null
        ? AuthenticationStatus.authenticated
        : AuthenticationStatus.unauthenticated);
  }

  UserModel currentUser() {
    final user = _firebaseAuth.currentUser;
    return UserModel(
        id: user!.uid,
        displayName: user.displayName,
        email: user.email!,
        photoUrl: user.photoURL);
  }

  FirebaseAuth get firebaseAuth => _firebaseAuth;

  Future<void> updateName(String name) async {
    try {
      await _firebaseAuth.currentUser!.updateDisplayName(name);
    } catch (error) {
      rethrow;
    }
  }

  Future<void> changeEmail(String newEmail) async {
    try {
      await _firebaseAuth.currentUser!.updateEmail(newEmail);
    } catch (error) {
      rethrow;
    }
  }

  Future<void> changePassword(String newPassword) async {
    try {
      await _firebaseAuth.currentUser!.updatePassword(newPassword);
    } catch (error) {
      log(error.toString());
    }
  }

  Future<void> signInWithEmail(
      {required String email, required String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw SignInWithEmailFailure.fromCode(e.code);
    } catch (error) {
      throw const SignInWithEmailFailure();
    }
  }

  Future<void> signWithGoogle() async {
    try {
      final googleUser = await _googleSignIn.signIn();
      if (googleUser != null) {
        final googleAuth = await googleUser.authentication;
        final credential = GoogleAuthProvider.credential(
            accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
        await _firebaseAuth.signInWithCredential(credential);
      }
    } on FirebaseAuthException catch (e) {
      throw SignInWithGoogleFailure.fromCode(e.code);
    } catch (error) {
      throw const SignInWithGoogleFailure();
    }
  }

  Future<void> signUpWithEmail(
      {required String email, required String password}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw SignUpWithEmailFailure.fromCode(e.code);
    } catch (error) {
      throw const SignUpWithEmailFailure();
    }
  }

  Future<void> signOut() async {
    try {
      await _googleSignIn.signOut();
      await _firebaseAuth.signOut();
    } catch (err) {
      rethrow;
    }
  }
}
