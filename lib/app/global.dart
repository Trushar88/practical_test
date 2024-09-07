import 'package:flutter/material.dart';
import 'package:practicaltest/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String appName = "practicaltest"; //AppName
const String appVerison = "0.0.1"; // AppVersion

String? currentLang; //Current Active Language

User currentUser = User(); // Current Login User

SharedPreferences? sharedPreferences;
final GlobalKey<ScaffoldMessengerState> snackbarKey =
    GlobalKey<ScaffoldMessengerState>();
