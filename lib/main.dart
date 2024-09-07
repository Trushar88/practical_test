// ignore_for_file: must_be_immutable, prefer_const_constructors

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:practicaltest/base/base_controller.dart';
import 'package:practicaltest/routes/bindings/home_binding.dart';
import 'package:practicaltest/routes/app_pages.dart';
import 'package:practicaltest/theme/app_theme.dart';
import 'package:practicaltest/theme/theme_service.dart';
import 'package:practicaltest/ui/splash/splash_screen.dart';
import 'package:practicaltest/app/service/local_storage.dart';
import 'package:practicaltest/app/service/network_service.dart';
import 'package:practicaltest/app/global.dart' as global;

void main() async {
  await initServices();
  runApp(
    MyApp(),
  );
}

initServices() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  Get.put(NetworkController());
  Get.put(BaseController());
  HttpOverrides.global = MyHttpOverrides();
  await Get.putAsync(() => LocalStorageService().init());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GlobalLoaderOverlay(
      overlayColor: Colors.white38,
      useDefaultLoading: false,
      overlayWholeScreen: true,
      disableBackButton: true,
      closeOnBackButton: false,
      overlayWidgetBuilder: (_) {
        return const PopScope(
          canPop: false,
          child: Center(child: CircularProgressIndicator()),
        );
      },
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: Themes.light,
        themeMode: ThemeService().theme,
        darkTheme: Themes.dark,
        scaffoldMessengerKey: global.snackbarKey,
        getPages: AppPages.pages,
        initialBinding: InitBinding(),
        title: 'Practical Test Timer',
        home: const SplashScreen(),
      ),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
