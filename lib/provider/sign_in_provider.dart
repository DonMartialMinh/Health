import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:health/models/User.dart';

class GoogleSignInProvider extends ChangeNotifier {
  final googleSignIn = GoogleSignIn();
  late bool _isSigningIn;

  GoogleSignInProvider() {
    _isSigningIn = false;
  }

  bool get isSigningIn => _isSigningIn;

  set isSigningIn (bool isSigningIn) {
    _isSigningIn = isSigningIn;
    notifyListeners();
  }

  Future login() async {
    isSigningIn = true;
    final user = await googleSignIn.signIn();
    if (user == null) {
      isSigningIn = false;
      return;
    } else {
      final googleAuth = await user.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken
      );
      await FirebaseAuth.instance.signInWithCredential(credential);
      isSigningIn = false;

      // Create User on db
      final firebaseUser = FirebaseAuth.instance.currentUser;
      DocumentReference documentReference = FirebaseFirestore.instance.collection('User').doc(firebaseUser!.uid);
      documentReference.get()
      .then((value) => {
        if (value.exists) {
        }
        else {
          //currentUser _currentUser = new currentUser(name: firebaseUser.displayName!, image: firebaseUser.photoURL!);
          documentReference.set(currentUser(name: firebaseUser.displayName!, image: firebaseUser.photoURL!).toMap())
          .then((value) => print("user Added"))
          .catchError((error) => print("Failed to add user: $error"))
        }
      }
      );
    }
  }

  void logout() async {
    await googleSignIn.disconnect();
    FirebaseAuth.instance.signOut();
  }

}