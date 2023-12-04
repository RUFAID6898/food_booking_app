import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  var verifyId = '';
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<void> signInWithGoogle() async {
    try {
      GoogleSignInAccount? signInAccount = await _googleSignIn.signIn();
      if (signInAccount != null) {
        GoogleSignInAuthentication signInAuthentication =
            await signInAccount.authentication;
        AuthCredential credential = GoogleAuthProvider.credential(
            accessToken: signInAuthentication.accessToken,
            idToken: signInAuthentication.idToken);
        await _auth.signInWithCredential(credential);
      }
    } catch (e) {
      print('Error signin in with google$e');
    }
  }

  Future<void> signOut() async {
    try {
      await _googleSignIn.signOut();
      await _auth.signOut();
    } catch (e) {
      print('error signing out:$e');
    }
  }

  Future sentOtp({
    required String phone,
    required Function errorStep,
    required Function nextStep,
  }) async {
    await _auth
        .verifyPhoneNumber(
      timeout: Duration(seconds: 30),
      phoneNumber: "+91$phone",
      verificationCompleted: (phoneAuthCredential) {
        return;
      },
      verificationFailed: (error) {
        return;
      },
      codeSent: (verificationId, forceResendingToken) {
        verifyId = verificationId;
        nextStep();
      },
      codeAutoRetrievalTimeout: (verificationId) async {
        return;
      },
    )
        .onError((error, stackTrace) {
      errorStep();
    });
  }

  Future loginWithOtp({required String otp}) async {
    final cred =
        PhoneAuthProvider.credential(verificationId: verifyId, smsCode: otp);

    try {
      final User = await _auth.signInWithCredential(cred);
      if (User.user != null) {
        return "Success";
      } else {
        return 'error in otp login';
      }
    } on FirebaseAuthException catch (e) {
      return e.message.toString();
    } catch (e) {
      return e.toString();
    }
  }

  Future logoutUser() async {
    await _auth.signOut();
  }

  Future<bool> isloggedIn() async {
    var user = _auth.currentUser;
    return user != null;
  }
}
