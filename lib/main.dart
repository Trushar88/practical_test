// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:practical_test/Theme/app_theme.dart';
import 'package:practical_test/app/config/app_strings.dart';
import 'package:practical_test/ui/home/home_provider.dart';
import 'package:practical_test/ui/home/home_screen.dart';
import 'package:practical_test/app/config/app_colors.dart';
import 'package:practical_test/app/extensions/color.dart';
import 'package:provider/provider.dart';

void main() async {
  await initServices();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: HexColor("414041"), // navigation bar color
    statusBarColor: APPCOLOR.PRIMARYCOLOR, // status bar color
  ));
  runApp(
    MyApp(),
  );
}

initServices() async {
  WidgetsFlutterBinding.ensureInitialized();
}

class MyApp extends StatelessWidget {
  dynamic analytics;
  dynamic observer;
  MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: Themes.light,
        darkTheme: Themes.dark,
        title: APPSTRING.APP_NAME,
        home: const HomeScreen(),
      ),
    );
  }
}
