import 'package:dartz/dartz.dart';
import 'package:posts/core/errors/failure.dart';
import 'package:posts/features/posts/domain/repositories/posts_repository.dart';

class DeletePostUseCase {
  final PostsRepository repository;

  DeletePostUseCase(this.repository);

  Future<Either<Failure, Unit>> call(int postId) async{
    return await repository.deletePost(postId);
  }
}
