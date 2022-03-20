import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:steuermachen/constants/strings/error_messages_constants.dart';
import 'package:steuermachen/main.dart';
import 'package:steuermachen/wrappers/common_response_wrapper.dart';
import 'package:steuermachen/wrappers/user_wrapper.dart';

class ProfileProvider extends ChangeNotifier {
  UserWrapper? userData;
  bool _busyStateProfile = true;
  UserWrapper? _selectedAddress;
  bool get getBusyStateProfile => _busyStateProfile;
  set setBusyStateProfile(bool _isBusy) {
    _busyStateProfile = _isBusy;
    notifyListeners();
  }

  UserWrapper? get getSelectedAddress => _selectedAddress;

  set setSelectedAddress(UserWrapper? selectedAddress) {
    _selectedAddress = selectedAddress;
  }

  final TextEditingController genderController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController streetController = TextEditingController();
  final TextEditingController houseNumberController = TextEditingController();
  final TextEditingController postCodeController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController =
      TextEditingController(text: FirebaseAuth.instance.currentUser!.email);
  final TextEditingController countryController = TextEditingController();
  final GlobalKey<FormState> userFormKey = GlobalKey<FormState>();

  setGender(String value) {
    genderController.text = value;
    notifyListeners();
  }

  setUserDataToController(UserWrapper user) {
    genderController.text = user.gender!;
    firstNameController.text = user.firstName!;
    lastNameController.text = user.lastName!;
    streetController.text = user.street!;
    houseNumberController.text = user.houseNumber!;
    postCodeController.text = user.plz!;
    locationController.text = user.location!;
    phoneController.text = user.phone!;
    emailController.text = user.email!;
    countryController.text = user.land!;
  }

  dispoeControllers() {
    genderController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    streetController.dispose();
    houseNumberController.dispose();
    postCodeController.dispose();
    locationController.dispose();
    phoneController.dispose();
    emailController.dispose();
    countryController.dispose();
  }

  Future<CommonResponseWrapper> submitUserProfile() async {
    var userWrapper = UserWrapper(
      gender: genderController.text,
      firstName: firstNameController.text,
      lastName: lastNameController.text,
      street: streetController.text,
      houseNumber: houseNumberController.text,
      plz: postCodeController.text,
      location: locationController.text,
      phone: phoneController.text,
      email: emailController.text,
      land: countryController.text,
    );
    try {
      User? user = FirebaseAuth.instance.currentUser;
      await firestore
          .collection("user_profile")
          .doc("${user?.uid}")
          .set(userWrapper.toJson());
      await getUserProfile();
      return CommonResponseWrapper(
          status: true, message: "Profile updated successfully");
    } catch (e) {
      return CommonResponseWrapper(
          status: false, message: ErrorMessagesConstants.somethingWentWrong);
    }
  }

  Future<CommonResponseWrapper?> getUserProfile() async {
    if (userData == null) {
      try {
        setBusyStateProfile = true;
        User? user = FirebaseAuth.instance.currentUser;
        DocumentSnapshot snapshot = await firestore
            .collection("user_profile")
            .doc("${user?.uid}")
            .get();
        if (snapshot.data() != null) {
          Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
          userData = UserWrapper.fromJson(data);
          setBusyStateProfile = false;
          setUserDataToController(userData!);
          return CommonResponseWrapper(
              status: true, message: "", data: userData);
        } else {
          setBusyStateProfile = false;
          return CommonResponseWrapper(
            status: true,
            message: "",
          );
        }
      } catch (e) {
        setBusyStateProfile = false;
        return CommonResponseWrapper(
            status: false, message: ErrorMessagesConstants.somethingWentWrong);
      }
    }
    return null;
  }

  UserWrapper getUserFromControllers() {
    return UserWrapper(
      gender: genderController.text,
      firstName: firstNameController.text,
      lastName: lastNameController.text,
      street: streetController.text,
      houseNumber: houseNumberController.text,
      plz: postCodeController.text,
      location: locationController.text,
      phone: phoneController.text,
      email: emailController.text,
      land: countryController.text,
    );
  }

  Future<CommonResponseWrapper> addUserAddresss() async {
    var address = UserWrapper(
      firstName: firstNameController.text,
      lastName: lastNameController.text,
      street: streetController.text,
      houseNumber: houseNumberController.text,
      plz: postCodeController.text,
      location: locationController.text,
      email: emailController.text,
      land: countryController.text,
      phone: phoneController.text,
    );
    try {
      User? user = FirebaseAuth.instance.currentUser;
      await firestore
          .collection("user_address")
          .doc("${user?.uid}")
          .collection("addresses")
          .add(address.toJson());
      return CommonResponseWrapper(
          status: true, message: "Profile updated successfully");
    } catch (e) {
      return CommonResponseWrapper(
          status: false, message: ErrorMessagesConstants.somethingWentWrong);
    }
  }

  Future<CommonResponseWrapper?> getUserAddresses() async {
    try {
      setBusyStateProfile = true;
      User? user = FirebaseAuth.instance.currentUser;
      QuerySnapshot snapshot = await firestore
          .collection("user_address")
          .doc("${user?.uid}")
          .collection("addresses")
          .get();
      if (snapshot.docs.isNotEmpty) {
        List<UserWrapper> addresses = snapshot.docs
            .map(
              (e) => UserWrapper.fromJson(e.data() as Map<String, dynamic>),
            )
            .toList();
        setBusyStateProfile = false;
        return CommonResponseWrapper(
            status: true, message: "", data: addresses);
      } else {
        setBusyStateProfile = false;
        return CommonResponseWrapper(
          status: true,
          message: "",
        );
      }
    } catch (e) {
      setBusyStateProfile = false;
      return CommonResponseWrapper(
          status: false, message: ErrorMessagesConstants.somethingWentWrong);
    }
  }
}
