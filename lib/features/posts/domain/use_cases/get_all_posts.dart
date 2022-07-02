import 'package:dartz/dartz.dart';
import 'package:posts/core/errors/failure.dart';
import 'package:posts/features/posts/domain/entities/posts.dart';
import 'package:posts/features/posts/domain/repositories/posts_repository.dart';

class GetAllPostsUseCase {
  final PostsRepository repository;

  GetAllPostsUseCase(this.repository);

  Future<Either<Failure, List<Post>>> call() async {
    return await repository.getAllPosts();
  }
} 
