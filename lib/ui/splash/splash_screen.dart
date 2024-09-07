import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:practicaltest/ui/home/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: const Center(
        child: FlutterLogo(
            //  size: 100,
            ),
      ),
    );
  }

  @override
  void initState() {
    initSplash();
    super.initState();
  }

  void initSplash() {
    Future.delayed(const Duration(seconds: 3)).then((c) {
      Get.off(() => HomeScreen());
    });
  }
}
