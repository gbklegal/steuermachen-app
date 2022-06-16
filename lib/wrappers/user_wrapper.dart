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

// class UserWrapper {
//   UserWrapper({
//     this.createdAt,
//     this.updatedAt,
//     this.lastName,
//     this.firstName,
//     this.phone,
//     this.userId,
//     this.gender,
//     this.email,
//     this.userAddresses,
//   });
//    String? createdAt;
//    String? updatedAt;
//    String? lastName;
//    String? firstName;
//    String? phone;
//    String? userId;
//    String? gender;
//    String? email;
//    List<UserAddresses>? userAddresses;
  
//   UserWrapper.fromJson(Map<String, dynamic> json){
//     createdAt = json['createdAt'];
//     updatedAt = json['updatedAt'];
//     lastName = json['lastName'];
//     firstName = json['firstName'];
//     phone = json['phone'];
//     userId = json['user_id'];
//     gender = json['gender'];
//     email = json['email'];
//     userAddresses = List.from(json['userAddresses']).map((e)=>UserAddresses.fromJson(e)).toList();
//   }

//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['createdAt'] = createdAt;
//     _data['updatedAt'] = updatedAt;
//     _data['lastName'] = lastName;
//     _data['firstName'] = firstName;
//     _data['phone'] = phone;
//     _data['user_id'] = userId;
//     _data['gender'] = gender;
//     _data['email'] = email;
//     _data['userAddresses'] = userAddresses?.map((e)=>e.toJson()).toList();
//     return _data;
//   }
// }

// class UserAddresses {
//   UserAddresses({
//     required this.plz,
//     required this.houseNumber,
//     required this.street,
//     required this.location,
//     required this.country,
//     required this.isDefault,
//   });
//   late final String plz;
//   late final String houseNumber;
//   late final String street;
//   late final String location;
//   late final String country;
//   late final bool isDefault;
  
//   UserAddresses.fromJson(Map<String, dynamic> json){
//     plz = json['plz'];
//     houseNumber = json['houseNumber'];
//     street = json['street'];
//     location = json['location'];
//     country = json['country'];
//     isDefault = json['default'];
//   }

//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['plz'] = plz;
//     _data['houseNumber'] = houseNumber;
//     _data['street'] = street;
//     _data['location'] = location;
//     _data['country'] = country;
//     _data['default'] = isDefault;
//     return _data;
//   }
// }