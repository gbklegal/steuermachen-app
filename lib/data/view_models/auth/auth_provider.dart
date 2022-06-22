import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:steuermachen/constants/strings/http_constants.dart';
import 'package:steuermachen/languages/locale_keys.g.dart';
import 'package:steuermachen/main.dart';
import 'package:steuermachen/services/networks/api_response_states.dart';
import 'package:steuermachen/services/networks/dio_api_services.dart';
import 'package:steuermachen/services/networks/dio_client_network.dart';
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
        // webAuthenticationOptions: WebAuthenticationOptions(
        //    clientId: 'de.steuermachen.app',

        //   redirectUri: Uri.parse(
        //       'https://steuermachen.de/'),
        // ),
        nonce: nonce,
      );
      final oauthCredential = OAuthProvider("apple.com").credential(
        idToken: appleCredential.identityToken,
        rawNonce: rawNonce,
      );
      UserCredential user =
          await FirebaseAuth.instance.signInWithCredential(oauthCredential);
      await checkUserFirstTimeLoggedIn(
          user.user!.email!, user.additionalUserInfo!.isNewUser);
      return CommonResponseWrapper(
          status: true, message: "Signin successfully");
    } catch (e) {
      print(e);
      return CommonResponseWrapper(status: false, message: e.toString());
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
      // await checkUserFirstTimeLoggedIn(googleSignInAccount.email);
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      try {
        final UserCredential userCredential =
            await auth.signInWithCredential(credential);
        if (!userCredential.user!.emailVerified) {
          await sendVerificationEmail();
          return CommonResponseWrapper(
              status: false, message: LocaleKeys.verifyEmail);
        }
        await checkUserFirstTimeLoggedIn(googleSignInAccount.email,
            userCredential.additionalUserInfo!.isNewUser);
        user = userCredential.user;
        return CommonResponseWrapper(
            status: true, message: "Signin successfully");
      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
          return CommonResponseWrapper(status: false, message: e.code);
        } else if (e.code == 'invalid-credential') {
          return CommonResponseWrapper(status: false, message: e.code);
        }
      } catch (e) {
        return CommonResponseWrapper(
            status: false, message: LocaleKeys.somethingWentWrong);
      }
    }
    if (googleSignInAccount == null) {
      return CommonResponseWrapper(status: false, message: "");
    } else {
      return CommonResponseWrapper(
          status: false, message: LocaleKeys.somethingWentWrong);
    }
  }

  Future<CommonResponseWrapper> registerWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential user = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      await sendVerificationEmail();
      return CommonResponseWrapper(
          status: true, message: LocaleKeys.accRegisteredSuccess);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return CommonResponseWrapper(
            status: false, message: LocaleKeys.weakPwd);
      } else if (e.code == 'email-already-in-use') {
        return CommonResponseWrapper(
            status: false, message: LocaleKeys.accAlreadyExists);
      }
      return CommonResponseWrapper(
          status: false, message: LocaleKeys.somethingWentWrong);
    } catch (e) {
      return CommonResponseWrapper(status: false, message: e.toString());
    }
  }

  Future<CommonResponseWrapper> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential _user = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      if (_user.user!.metadata.creationTime ==
          _user.user!.metadata.lastSignInTime) {
        await checkUserFirstTimeLoggedIn(email, true);
      } else {
        await checkUserFirstTimeLoggedIn(email, false);
      }

      if (!_user.user!.emailVerified) {
        await sendVerificationEmail();
        return CommonResponseWrapper(
            status: false, message: LocaleKeys.verifyEmail);
      }
      return CommonResponseWrapper(status: true, message: 'Sigin successfully');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return CommonResponseWrapper(
            status: false, message: LocaleKeys.noUserFound);
      } else if (e.code == 'wrong-password') {
        return CommonResponseWrapper(
            status: false, message: LocaleKeys.wrongPwd);
      }
      return CommonResponseWrapper(
          status: false, message: LocaleKeys.somethingWentWrong);
    }
  }

  Future<CommonResponseWrapper> forgotPassword(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      return CommonResponseWrapper(
          status: true, message: LocaleKeys.checkEmailForPwdResetLink);
    } on FirebaseAuthException catch (e) {
      return CommonResponseWrapper(
          status: false, message: LocaleKeys.somethingWentWrong);
    }
  }

  // sendVerificationEmail() async {
  //   User? user = FirebaseAuth.instance.currentUser;
  //   if (user != null && !user.emailVerified) {
  //     await user.sendEmailVerification();
  //   }
  // }

    sendVerificationEmail() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null && !user.emailVerified) {
      serviceLocatorInstance<DioClientNetwork>().dio.options.baseUrl =
          HTTPConstants.baseUrlApi;
      var response = await serviceLocatorInstance<DioApiServices>().postRequest(
          HTTPConstants.verifyEmail,
          data: {"email": user.email});
      print(response);
    }
  }

  checkUserFirstTimeLoggedIn(String email, bool isNewUser) async {
    // var methods = await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);
    // if (methods.contains('google.com') ||
    //     methods.contains('apple.com') ||
    //     methods.contains('password')) {
    if (!isNewUser) {
      isFirstTimeLoggedIn = false;
    } else {
      isFirstTimeLoggedIn = true;
    }
  }

  List<UserInfo>? checkProviders() {
    List<UserInfo> userInfo = FirebaseAuth.instance.currentUser!.providerData;
    return userInfo;
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

  Future<CommonResponseWrapper> changePassword(
      String oldPassword, String newPassword) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: user!.email!,
        password: oldPassword,
      );
      await user.updatePassword(newPassword);
      return CommonResponseWrapper(
          status: true, message: LocaleKeys.passwordChangedSuccess);
    } catch (e) {
      return CommonResponseWrapper(status: false, message: e.toString());
    }
  }

  Future<ApiResponse> deleteAccount() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      await FirebaseAuth.instance.currentUser?.delete();
      QuerySnapshot<Map<String, dynamic>> userOrder = await firestore
          .collection("user_orders")
          .where('user_info.user_id', isEqualTo: user?.uid)
          .get();
      for (var element in userOrder.docs) {
        await firestore.collection("user_orders").doc(element.id).delete();
      }
      await firestore.collection("user_profile").doc("${user?.uid}").delete();
      await firestore.collection("user_address").doc("${user?.uid}").delete();
      return ApiResponse.completed("");
    } on FirebaseException catch (e) {
      return ApiResponse.error(e.code.toString());
    }
  }

  Future<ApiResponse> reLogin(String password) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: user!.email!,
        password: password,
      );
      return ApiResponse.completed("");
    } on FirebaseException catch (e) {
      if (e.code == 'user-not-found') {
        return ApiResponse.error(LocaleKeys.noUserFound);
      } else if (e.code == 'wrong-password') {
        return ApiResponse.error(LocaleKeys.wrongPwd);
      }
      return ApiResponse.error(LocaleKeys.somethingWentWrong);
    }
  }

  signout() async {
    await FirebaseAuth.instance.signOut();
  }
}
