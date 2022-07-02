import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:posts/core/errors/exceptions.dart';
import 'package:posts/features/posts/data/models/post_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class PostsLocalDataSource {
  Future<List<PostModel>> getCashedPosts();
  Future<Unit> cachePosts(List<PostModel> postModel);
}

class PostsLocalDataSourceImpl implements PostsLocalDataSource {
  final SharedPreferences sharedPreferences;

  PostsLocalDataSourceImpl({required this.sharedPreferences});
  @override
  Future<Unit> cachePosts(List<PostModel> postModel) {
    final postModelToJson =
        postModel.map<Map<String, dynamic>>((e) => e.toJson()).toList();
    sharedPreferences.setString('cashed', json.encode(postModelToJson));
    return Future.value(unit);
  }

  @override
  Future<List<PostModel>> getCashedPosts() async {
    final jsonString = sharedPreferences.getString('cashed');
    if (jsonString != null) {
      List decodeJsonData = jsonDecode(jsonString);
      List<PostModel> jsonToPostModel =
          decodeJsonData.map<PostModel>((e) => PostModel.fromJson(e)).toList();
      return Future.value(jsonToPostModel);
    } else {
      throw EmptyCacheException();
    }
  }
}
