import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:practicaltest/base/base_controller.dart';
import 'package:practicaltest/model/post.dart';
import 'package:practicaltest/ui/home/home_repository.dart';
import 'package:practicaltest/app/service/local_storage.dart';

class HomeController extends BaseController with WidgetsBindingObserver {
  final Map<int, Timer?> _timers = {};
  final Map<int, int> _pausedTimes = {};

  var scaffoldKey = GlobalKey<ScaffoldState>();
  List<Post> posts = [];
  ScrollController scrollController = ScrollController();
  HomeController get to => Get.find<HomeController>();

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addObserver(this);
    getPosts();
  }

  @override
  void onClose() {
    WidgetsBinding.instance.removeObserver(this);
    for (var timer in _timers.values) {
      timer?.cancel();
    }
    super.onClose();
  }

  void start(int index) {
    _timers[index]?.cancel();

    _timers[index] = Timer.periodic(const Duration(seconds: 1), (timer) {
      posts[index].timer++;
      update();
    });
  }

  void pause(int index) {
    _timers[index]?.cancel();
    _pausedTimes[index] = posts[index].timer;
    _timers.remove(index);
  }

  void resume(int index) {
    if (_timers.containsKey(index)) return;

    _timers[index] = Timer.periodic(const Duration(seconds: 1), (timer) {
      posts[index].timer++;
      update();
    });
  }

  int getRandomTimer() {
    final random = Random();
    return [10, 20, 25][random.nextInt(3)];
  }

  Future<void> getPosts() async {
    try {
      showLoader(Get.context!);

      List<Post> localPosts = await LocalStorageService().getPostFromLocal();
      if (localPosts.isNotEmpty) {
        posts = localPosts;
        update();
      }

      List<Post> response = await HomeRepo().getPosts();
      if (response.isNotEmpty) {
        posts = response;
        for (var post in posts) {
          post.timer = getRandomTimer();
        }
        await LocalStorageService().savePostsToLocal(posts);
        update();
      }

      hideLoader(Get.context!);
    } catch (err) {
      hideLoader(Get.context!);
      errorLog("Home", "GetPosts", err.toString());
    }
  }

  void itemClick(int index) {
    posts[index].isActive = true;
    pause(index);
    update();
  }

  void handleVisibility(int index, bool visible) {
    if (visible) {
      if (posts[index].isActive) {
        resume(index);
      }
    } else {
      pause(index);
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      _timers.forEach((index, timer) {
        pause(index);
      });
    } else if (state == AppLifecycleState.resumed) {
      _timers.forEach((index, timer) {
        resume(index);
      });
    }
  }
}
