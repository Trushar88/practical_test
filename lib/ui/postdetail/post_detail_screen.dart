import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:practicaltest/base/base_widget.dart';
import 'package:practicaltest/ui/postdetail/post_detail_controller.dart';
import 'package:practicaltest/app/config/app_strings.dart';

class PostDetailScreen extends BaseWidget {
  PostDetailScreen({Key? super.key, super.a, super.o})
      : super(r: "PostDetailScreen");
  final _controller = PostDetailController().to;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(APPSTRING.POSTDETAIL),
      ),
      body: GetBuilder<PostDetailController>(builder: (c) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: _controller.posts != null
              ? Text(_controller.posts!.body)
              : const Text(""),
        );
      }),
    );
  }
}
