import 'package:get/get.dart';
import 'package:practicaltest/ui/postdetail/post_detail_controller.dart';

class PostDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PostDetailController>(() => PostDetailController());
  }
}
