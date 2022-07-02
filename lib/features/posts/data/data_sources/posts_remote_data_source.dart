import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:posts/core/api/end_points.dart';
import 'package:posts/core/errors/exceptions.dart';
import 'package:posts/features/posts/data/models/post_model.dart';
import 'package:http/http.dart' as http;

abstract class PostsRemoteDataSource {
  Future<List<PostModel>> getAllPosts();
  Future<Unit> deletePost(int postId);
  Future<Unit> updatePost(PostModel postModel);
  Future<Unit> addPost(PostModel postModel);
}

class PostsRemoteDataSourceImpl implements PostsRemoteDataSource {
  final http.Client client;

  PostsRemoteDataSourceImpl({required this.client});

  @override
  Future<Unit> addPost(PostModel postModel) async {
    final body = {'title': postModel.title, 'body': postModel.body};
    final response = await client.post(Uri.parse(EndPoints.posts), body: body);
    if (response.statusCode == 201) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> deletePost(int postId) async {
    final response = await 
        client.delete(Uri.parse(EndPoints.posts + postId.toString()));

    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<PostModel>> getAllPosts() async {
    final response = await client.get(
      Uri.parse(EndPoints.posts),
    );
    if (response.statusCode == 200) {
      final decodeJson = json.decode(response.body);
      final List<PostModel> postModel =
          decodeJson.map<PostModel>((e) => PostModel.fromJson(e)).toList();
      return postModel;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> updatePost(PostModel postModel) async {
    final postId = postModel.id.toString();
    final body = {
      'title': postModel.title,
      'body': postModel.body
    };
    final response =
        await client.patch(Uri.parse(EndPoints.posts + postId), body: body);
    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }
}
