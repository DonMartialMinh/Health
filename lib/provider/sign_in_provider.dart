import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:health/models/User.dart';

class SignInProvider extends ChangeNotifier {
  final googleSignIn = GoogleSignIn();
  final facebookLogin = FacebookLogin();
  late bool _isSigningIn;
  String _signInMethod = "";

  SignInProvider() {
    _isSigningIn = false;
  }

  bool get isSigningIn => _isSigningIn;

  set isSigningIn (bool isSigningIn) {
    _isSigningIn = isSigningIn;
    notifyListeners();
  }

  Future loginWithFaceBook() async {
    _signInMethod = "facebook";
    isSigningIn = true;
    final FacebookLoginResult result = await facebookLogin.logIn(['email']);
    print (result.status);
    switch (result.status) {
      case FacebookLoginStatus.cancelledByUser:
        break;
      case FacebookLoginStatus.error:
        print('Something went wrong with the login process.\n'
            'Here\'s the error Facebook gave us: ${result.errorMessage}');
        break;
      case FacebookLoginStatus.loggedIn:
        try {
          print("on");
          await handleLogin(result);
        } catch (e) {
          print("error: $e");
        }
        break;
    }
  }

  Future handleLogin(FacebookLoginResult result) async {
    final FacebookAccessToken accessToken = result.accessToken;
    AuthCredential credential =
    FacebookAuthProvider.credential(accessToken.token);
    await FirebaseAuth.instance.signInWithCredential(credential);
    isSigningIn = false;

    createUserOnFireStore();
  }

  Future loginWithGoogle() async {
    _signInMethod = "google";
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

      createUserOnFireStore();
    }
  }

  void createUserOnFireStore() {
    final firebaseUser = FirebaseAuth.instance.currentUser;
    DocumentReference documentReference = FirebaseFirestore.instance.collection('User').doc(firebaseUser!.uid);
    documentReference.get()
        .then((value) => {
      if (value.exists) {
      }
      else  {
        documentReference.set(currentUser(
            phoneNumber: "0000000000",
            name: firebaseUser.displayName!,
            image: firebaseUser.photoURL!,
            desireWeight: 0.0,
            height: 170,
            dateOfBirth: DateTime.now()
        ).toMap(),
        )
            .then((value) => print("user Added"))
            .catchError((error) => print("Failed to add user: $error"))
      }
    }
    );
  }

  void logout() async {
    if (_signInMethod == "google")
      await googleSignIn.disconnect();
    else
      await facebookLogin.logOut();
    FirebaseAuth.instance.signOut();
  }
}