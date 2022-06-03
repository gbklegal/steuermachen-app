import 'package:firebase_auth/firebase_auth.dart';

class UserWrapper {
  String? firstName,
      lastName,
      street,
      houseNumber,
      plz,
      location,
      phone,
      email,
      gender,
      land,
      userId;

  UserWrapper(
      {this.firstName,
      this.lastName,
      this.street,
      this.email,
      this.phone,
      this.land,
      this.houseNumber,
      this.plz,
      this.location,
      this.gender,
      this.userId});
  factory UserWrapper.fromJson(Map<String, dynamic> json) => UserWrapper(
        firstName: json["firstName"],
        lastName: json["lastName"],
        street: json["street"],
        houseNumber: json["houseNumber"],
        plz: json["plz"],
        location: json["location"],
        phone: json["phone"],
        email: json["email"],
        land: json["country"],
        gender: json["gender"],
        userId: json["user_id"],
      );
  Map<String, dynamic> toJson() => {
        "firstName": firstName,
        "lastName": lastName,
        "street": street,
        "houseNumber": houseNumber,
        "plz": plz,
        "location": location,
        "phone": phone,
        "email": email,
        "country": land,
        "gender": gender,
        "user_id": FirebaseAuth.instance.currentUser?.uid,
        "createdAt": DateTime.now(),
      };
}
