import 'package:posts/core/errors/exceptions.dart';
import 'package:posts/core/network/network_info.dart';
import 'package:posts/features/posts/data/data_sources/posts_local_data_source.dart';
import 'package:posts/features/posts/data/data_sources/posts_remote_data_source.dart';
import 'package:posts/features/posts/data/models/post_model.dart';
import 'package:posts/features/posts/domain/entities/posts.dart';
import 'package:posts/core/errors/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:posts/features/posts/domain/repositories/posts_repository.dart';

typedef NewType = Future<Unit> Function();

class PostsRepositoryImpl implements PostsRepository {
  final PostsLocalDataSource postsLocalDataSource;
  final PostsRemoteDataSource postsRemoteDataSource;
  final NetworkInfo networkInfo;

  PostsRepositoryImpl(
      {required this.networkInfo,
      required this.postsLocalDataSource,
      required this.postsRemoteDataSource});

  @override
  Future<Either<Failure, List<Post>>> getAllPosts() async {
    if (await networkInfo.isConnected) {
      try {
        final remotePosts = await postsRemoteDataSource.getAllPosts();
        postsLocalDataSource.cachePosts(remotePosts);
        return Right(remotePosts);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localPosts = await postsLocalDataSource.getCashedPosts();
        return Right(localPosts);
      } on EmptyCacheException {
        return Left(EmptyCacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Unit>> addPost(Post post) async {
    final PostModel postModel = PostModel(title: post.title, body: post.body);

    return await getMethod((() => postsRemoteDataSource.addPost(postModel)));
  }

  @override
  Future<Either<Failure, Unit>> deletePost(int postId) async {
    return await getMethod((() => postsRemoteDataSource.deletePost(postId)));
  }

  @override
  Future<Either<Failure, Unit>> updatePost(Post post) async {
    final PostModel postModel =
        PostModel(id: post.id, title: post.title, body: post.body);

    return await getMethod((() => postsRemoteDataSource.updatePost(postModel)));
  }

  Future<Either<Failure, Unit>> getMethod(NewType method) async {
    if (await networkInfo.isConnected) {
      try {
        await method();
        return const Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OffLineFailure());
    }
  }
}
