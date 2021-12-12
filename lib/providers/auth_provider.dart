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

  String? validateEmptyField(String? value) {
    return InputValidationUtil.validateFieldEmpty(value);
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
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    return await FirebaseAuth.instance.signInWithCredential(credential);
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
          status: false, message: 'something went wrong');
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
          status: false, message: 'Something went wrong');
    }
  }

  sendVerificationEmail() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null && !user.emailVerified) {
      await user.sendEmailVerification();
    }
  }

  bool checkUserInPreference()  {
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
