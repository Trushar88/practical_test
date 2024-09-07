// ignore_for_file: prefer_typing_uninitialized_variables, file_names

import 'dart:developer';

class User {
  late String? firstName;
  late String? email;
  late String? mobile;
  late int? id;
  late String? imagedata;
  User({this.firstName, this.email, this.mobile, this.id, this.imagedata});

  User.fromJson(Map<String, dynamic> json) {
    try {
      firstName = json['firstName'] ?? "";
      email = json['email'] ?? "";
      mobile = json['mobile'];
      id = json['id'];
      imagedata = json['imagedata'];
    } catch (e) {
      log("Exception - userModel.dart - Customer.fromJson():$e");
    }
  }

  Map<String, dynamic> toJson() => {
        'firstName': firstName,
        'email': email,
        'mobile': mobile,
        'id': id,
        'imagedata': imagedata
      };
}
