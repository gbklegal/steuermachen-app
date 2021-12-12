import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:steuermachen/utils/input_validation_util.dart';
import 'package:steuermachen/wrappers/common_response_wrapper.dart';

class AuthProvider extends ChangeNotifier {
  late GoogleSignIn _googleSignIn;

  String? validatePassword(String? value) {
    return InputValidationUtil.validatePassword(value);
  }

  String? validateEmail(String? value) {
    return InputValidationUtil.validateEmail(value);
  }

  initializeGoogleSignIn() {
    _googleSignIn = GoogleSignIn(
      scopes: [
        'email',
        'https://www.googleapis.com/auth/contacts.readonly',
      ],
    );
  }

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<CommonResponseWrapper> registerWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      return CommonResponseWrapper(
          status: true, message: "Account registered successfully");
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
          status: false, message: 'something went wrong');
    } catch (e) {
      return CommonResponseWrapper(status: false, message: e.toString());
    }
  }
}
