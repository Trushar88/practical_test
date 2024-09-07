import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:practicaltest/model/post.dart';
import 'package:practicaltest/app/global.dart' as global;
import 'package:shared_preferences/shared_preferences.dart';

enum _Key {
  thememode,
  currentLang,
  posts,
}

class LocalStorageService extends GetxService {
  Future<LocalStorageService> init() async {
    global.sharedPreferences = await SharedPreferences.getInstance();
    return this;
  }

  setThemeMode(bool data) {
    try {
      global.sharedPreferences?.setBool(_Key.thememode.toString(), data);
    } catch (err) {
      errorLog("setThemeMode", err.toString());
    }
  }

  setCurrentLanguage(String data) {
    try {
      global.sharedPreferences?.setString(_Key.currentLang.toString(), data);
    } catch (err) {
      errorLog("setCurrentLanguage", err.toString());
    }
  }

  Future<void> savePostsToLocal(List<Post> posts) async {
    global.sharedPreferences!.remove(_Key.posts.toString());
    final List<Map<String, dynamic>> postsJson =
        posts.map((post) => post.toJson()).toList();

    global.sharedPreferences
        ?.setString(_Key.posts.toString(), json.encode(postsJson));
  }

  Future<List<Post>> getPostFromLocal() async {
    String? postsString =
        global.sharedPreferences!.getString(_Key.posts.toString());

    if (postsString == null) {
      return [];
    }
    final List<dynamic> postsJson = json.decode(postsString);
    return postsJson.map((json) => Post.fromJson(json)).toList();
  }

  String? get getCurrentLanguage {
    try {
      String? currentLang =
          global.sharedPreferences?.getString(_Key.thememode.toString());
      if (currentLang == null) {
        return null;
      }

      return currentLang;
    } catch (err) {
      errorLog("getThemeMode", err.toString());
    }
    return null;
  }

  bool? get geThemeMode {
    try {
      bool? currentTheme =
          global.sharedPreferences?.getBool(_Key.thememode.toString());
      if (currentTheme == null) {
        return null;
      }

      return currentTheme;
    } catch (err) {
      errorLog("getThemeMode", err.toString());
    }
    return null;
  }

  errorLog(String fun, String err) {
    log("Local Storage $fun  error :- $err");
  }
}
