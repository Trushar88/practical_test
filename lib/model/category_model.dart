// ignore_for_file: prefer_typing_uninitialized_variables, file_names

import 'dart:developer';

class CategoryModel {
  late int? id;
  late String? title;
  late String? slug;
  late String? content;
  late String? hidImage;
  late String? icon;
  late String? hidIcon;
  late int? status;
  late String? entDt;
  late String? imagedata;
  CategoryModel(
      {this.id,
      this.title,
      this.slug,
      this.content,
      this.hidImage,
      this.icon,
      this.hidIcon,
      this.status,
      this.entDt,
      this.imagedata});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    try {
      id = json['Id'] ?? 0;
      title = json['Title'] ?? "";
      slug = json['Slug'] ?? "";
      content = json['Content'] ?? "";
      hidImage = json['Hid_Image'] ?? "";
      icon = json['Icon'] ?? "";
      hidIcon = json['Hid_Icon'] ?? "";
      status = json['Status'] ?? "";
      entDt = json['EntDt'] ?? "";
      imagedata = json['Image'] ?? "";
    } catch (e) {
      log("Exception - CategoryModel.dart - CategoryModel.fromJson():$e");
    }
  }
}
