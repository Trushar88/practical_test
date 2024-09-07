import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:practicaltest/base/base_widget.dart';
import 'package:practicaltest/routes/app_routes.dart';
import 'package:practicaltest/ui/home/home_controller.dart';
import 'package:practicaltest/app/config/app_strings.dart';
import 'package:visibility_detector/visibility_detector.dart';

class HomeScreen extends BaseWidget {
  HomeScreen({Key? super.key, super.a, super.o}) : super(r: "HomeScreen");
  final HomeController _controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(APPSTRING.POST),
      ),
      body: GetBuilder<HomeController>(builder: (controller) {
        return ListView.builder(
          controller: _controller.scrollController,
          itemCount: _controller.posts.length,
          itemBuilder: (context, index) {
            final post = _controller.posts[index];
            return VisibilityDetector(
              key: Key('post-$index'),
              onVisibilityChanged: (visibilityInfo) {
                final visiblePercentage = visibilityInfo.visibleFraction * 100;
                if (visiblePercentage > 0) {
                  _controller.handleVisibility(index, true);
                } else {
                  _controller.handleVisibility(index, false);
                }
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(8.0),
                  tileColor: post.isActive ? Colors.white : Colors.yellow[100],
                  title: Text(post.title),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('${post.timer} s'),
                      IconButton(
                        icon: const Icon(Icons.timer),
                        onPressed: () {
                          _controller.start(index);
                        },
                      ),
                    ],
                  ),
                  onTap: () {
                    _controller.itemClick(index);
                    _controller.pause(index);
                    Get.toNamed(Routes.POSTDETAIL, arguments: post.id)!
                        .then((_) {
                      _controller.resume(index);
                    });
                  },
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
