// ignore_for_file: file_names

import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:practicaltest/base/base_repository.dart';
import 'package:practicaltest/base/generic_convert.dart';
import 'package:practicaltest/model/post.dart';
import 'package:practicaltest/model/response_model.dart';
import 'package:practicaltest/app/config/api_const.dart';
import 'package:practicaltest/app/service/local_storage.dart';

class HomeRepo extends BaseRepository {
  Future<List<Post>> getPosts() async {
    try {
      Response response = await super.getDio().get(
            APICONST.post,
            options: Options(
              headers: await getApiHeaders(false),
            ),
          );
      dynamic recordList;
      if (response.statusCode == 200) {
        recordList =
            Generics(response.data).getAsList<Post>((p0) => Post.fromJson(p0));
        LocalStorageService().savePostsToLocal(recordList);
        return recordList;
      } else {
        return [];
      }
    } catch (e) {
      log("Exception - getPosts(): $e");
      return [];
    }
  }

  Future<APIResult?> getSinglePosts(int id) async {
    try {
      Response response = await super.getDio().get(
            "${APICONST.post}/$id",
            options: Options(
              headers: await getApiHeaders(false),
            ),
          );
      dynamic recordList;
      if (response.statusCode == 200) {
        recordList = Generics(response.data)
            .getAsObject<Post>((p0) => Post.fromJson(p0));
      } else {
        recordList = response;
      }
      return getAPIResult(response, recordList);
    } catch (e) {
      log("Exception - getSinglePosts(): $e");
      return null;
    }
  }
}
