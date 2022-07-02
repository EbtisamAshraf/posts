import 'package:posts/features/posts/domain/entities/posts.dart';

class AddOrUpdatePostModel {
   final Post? post;
  final bool isUpdatePost;

  AddOrUpdatePostModel({ this.post,  this.isUpdatePost = false});
}