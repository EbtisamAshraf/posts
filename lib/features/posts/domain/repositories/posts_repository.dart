import 'package:dartz/dartz.dart';
import 'package:posts/core/errors/failure.dart';
import 'package:posts/features/posts/domain/entities/posts.dart';

abstract class PostsRepository {
  Future<Either<Failure, List<Post>>> getAllPosts();
  Future<Either<Failure, Unit>> deletePost(int postId);
  Future<Either<Failure, Unit>> updatePost(Post post);
  Future<Either<Failure, Unit>> addPost(Post post);
}
