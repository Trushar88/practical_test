// ignore_for_file: file_names

import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:practicaltest/base/base_repository.dart';
import 'package:practicaltest/base/generic_convert.dart';
import 'package:practicaltest/model/post.dart';
import 'package:practicaltest/app/config/api_const.dart';

class PostDetailRepo extends BaseRepository {
  Future<Post?> getSinglePosts(int id) async {
    try {
      Response response = await super.getDio().get(
            "${APICONST.post}/$id",
            options: Options(
              headers: await getApiHeaders(false),
            ),
          );
      if (response.statusCode == 200) {
        return Generics(response.data)
            .getAsObject<Post>((p0) => Post.fromJson(p0));
      } else {
        return null;
      }
    } catch (e) {
      log("Exception - getSinglePosts(): $e");
      return null;
    }
  }
}
