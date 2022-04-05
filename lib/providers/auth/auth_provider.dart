import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:steuermachen/constants/strings/error_messages_constants.dart';
import 'package:steuermachen/wrappers/common_response_wrapper.dart';

class AuthProvider extends ChangeNotifier {
  // ignore: unused_field
  late GoogleSignIn _googleSignIn;
  bool signInWithAppleIsAvailable = false;
  bool isFirstTimeLoggedIn = false;
  initializeGoogleSignIn() {
    _googleSignIn = GoogleSignIn(
      scopes: [
        'email',
        'https://www.googleapis.com/auth/contacts.readonly',
      ],
    );
  }

  checkSignInWithAppleAvailable() async {
    bool status = await SignInWithApple.isAvailable();
    signInWithAppleIsAvailable = status;
    notifyListeners();
  }

  String sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  Future<CommonResponseWrapper> signInWithApple() async {
    try {
      final rawNonce = generateNonce();
      final nonce = sha256ofString(rawNonce);
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        nonce: nonce,
      );
      final oauthCredential = OAuthProvider("apple.com").credential(
        idToken: appleCredential.identityToken,
        rawNonce: rawNonce,
      );
      await checkUserFirstTimeLoggedIn(appleCredential.email!);
      await FirebaseAuth.instance.signInWithCredential(oauthCredential);
      return CommonResponseWrapper(
          status: true, message: "Signin successfully");
    } catch (e) {
      return CommonResponseWrapper(
          status: false, message: ErrorMessagesConstants.somethingWentWrong);
    }
  }

  Future<CommonResponseWrapper> signInWithGoogle() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    // ignore: unused_local_variable
    User? user;

    final GoogleSignIn googleSignIn = GoogleSignIn();

    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();
    if (googleSignInAccount != null) {
      await checkUserFirstTimeLoggedIn(googleSignInAccount.email);
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      try {
        final UserCredential userCredential =
            await auth.signInWithCredential(credential);

        user = userCredential.user;
        return CommonResponseWrapper(
            status: true, message: "Signin successfully");
      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
          return CommonResponseWrapper(status: true, message: e.code);
        } else if (e.code == 'invalid-credential') {
          return CommonResponseWrapper(status: true, message: e.code);
        }
      } catch (e) {
        return CommonResponseWrapper(
            status: true, message: ErrorMessagesConstants.somethingWentWrong);
      }
    }
    if (googleSignInAccount == null) {
      return CommonResponseWrapper(status: false, message: "");
    } else {
      return CommonResponseWrapper(
          status: false, message: ErrorMessagesConstants.somethingWentWrong);
    }
  }

  Future<CommonResponseWrapper> registerWithEmailAndPassword(
      String email, String password) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      await sendVerificationEmail();
      return CommonResponseWrapper(
          status: true,
          message:
              "Account registered successfully\nCheck your mail for the verification link");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return CommonResponseWrapper(
            status: false, message: 'The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        return CommonResponseWrapper(
            status: false,
            message: 'The account already exists for that email.');
      }
      return CommonResponseWrapper(
          status: false, message: ErrorMessagesConstants.somethingWentWrong);
    } catch (e) {
      return CommonResponseWrapper(status: false, message: e.toString());
    }
  }

  Future<CommonResponseWrapper> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential _user = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      if (!_user.user!.emailVerified) {
        await sendVerificationEmail();
        return CommonResponseWrapper(
            status: false, message: 'Please verify your email');
      }
      return CommonResponseWrapper(status: true, message: 'Sigin successfully');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        return CommonResponseWrapper(
            status: false, message: 'No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        return CommonResponseWrapper(
            status: false, message: 'Wrong password provided for that user.');
      }
      return CommonResponseWrapper(
          status: false, message: ErrorMessagesConstants.somethingWentWrong);
    }
  }

  Future<CommonResponseWrapper> forgotPassword(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      return CommonResponseWrapper(
          status: true,
          message: 'Check your email for the reset password link');
    } on FirebaseAuthException catch (e) {
      return CommonResponseWrapper(
          status: false, message: ErrorMessagesConstants.somethingWentWrong);
    }
  }

  sendVerificationEmail() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null && !user.emailVerified) {
      await user.sendEmailVerification();
    }
  }

  checkUserFirstTimeLoggedIn(String email) async {
    var methods = await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);
    if (methods.contains('google.com') || methods.contains('apple.com')) {
      isFirstTimeLoggedIn = false;
    } else {
      isFirstTimeLoggedIn = true;
    }
  }

  bool checkUserInPreference() {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return false;
    } else if (!user.emailVerified) {
      return false;
    } else {
      return true;
    }
  }

  signout() async {
    await FirebaseAuth.instance.signOut();
  }
}
