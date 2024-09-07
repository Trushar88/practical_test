// ignore_for_file: file_names, unused_element

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:practicaltest/base/base_controller.dart';
import 'package:practicaltest/model/post.dart';
import 'package:practicaltest/ui/postdetail/post_detail_repository.dart';

class PostDetailController extends BaseController {
  //Scaffold key
  var scaffoldKey = GlobalKey<ScaffoldState>();

  Post? posts;
  int id = Get.arguments;
  PostDetailController get to => Get.find<PostDetailController>();

  @override
  void onInit() async {
    await getSinglePosts();

    super.onInit();
  }

  Future getSinglePosts() async {
    try {
      Post? response = await PostDetailRepo().getSinglePosts(id);
      if (response != null) {
        posts = response;
        update();
      } else {}
    } catch (err) {
      errorLog("Home", "GetCountry", err.toString());
    }
  }
}
