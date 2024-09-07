import 'package:get/get.dart';
import 'package:practicaltest/routes/bindings/home_binding.dart';
import 'package:practicaltest/routes/bindings/post_detail_binding.dart';
import 'package:practicaltest/routes/app_routes.dart';
import 'package:practicaltest/ui/home/home_screen.dart';
import 'package:practicaltest/ui/postdetail/post_detail_screen.dart';

class AppPages {
  static final pages = [
    GetPage(
        name: Routes.HOME, page: () => HomeScreen(), binding: InitBinding()),
    GetPage(
        name: Routes.POSTDETAIL,
        page: () => PostDetailScreen(),
        binding: PostDetailBinding()),
  ];
}
