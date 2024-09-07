// ignore_for_file: prefer_typing_uninitialized_variables, file_names

import 'dart:developer';

class SliderModel {
  late int? id;
  late String? title;
  late String? imagedata;
  SliderModel({this.id, this.title, this.imagedata});

  SliderModel.fromJson(Map<String, dynamic> json) {
    try {
      id = json['Id'] ?? "";
      title = json['Title'] ?? "";
      imagedata = json['Image'];
    } catch (e) {
      log("Exception - SliderModel.dart - SliderModel.fromJson():$e");
    }
  }
}
