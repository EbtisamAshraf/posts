import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts/core/errors/failure.dart';
import 'package:posts/core/utils/app_strings.dart';
import 'package:posts/features/posts/domain/entities/posts.dart';
import 'package:posts/features/posts/domain/use_cases/add_post.dart';
import 'package:posts/features/posts/domain/use_cases/del_post.dart';
import 'package:posts/features/posts/domain/use_cases/update_post.dart';
part 'posts_state.dart';

class PostsCubit extends Cubit<PostsState> {
  PostsCubit(
      {required this.updatePostUseCase,
      required this.deletePostUseCase,
      required this.addPostUseCase,
      })
      : super(PostsInitial());

  final AddPostUseCase addPostUseCase;
  
  final UpdatePostUseCase updatePostUseCase;
  final DeletePostUseCase deletePostUseCase;

  

  Future<void> addPost(Post post) async {
    emit(EditPostsLoadingState());
    Either<Failure, Unit> response = await addPostUseCase(post);
    emit(response.fold(
      (failure) => EditPostsErrorState(
        msg(failure),
      ),
      (_) => const EditPostsSuccessState(AppStrings.addSuccessMsg),
    ));
  }

  Future<void> updatePost(Post post) async {
    emit(EditPostsLoadingState());
    Either<Failure, Unit> response = await updatePostUseCase(post);
    emit(response.fold(
        (failure) => EditPostsErrorState(
              msg(failure),
            ),
        (_) => const EditPostsSuccessState(AppStrings.updateSuccessMsg)));
  }

  Future<void> deletePost(int postId) async {
    emit(EditPostsLoadingState());
    Either<Failure, Unit> response = await deletePostUseCase(postId);
    emit(response.fold(
        (failure) => EditPostsErrorState(
              msg(failure),
            ),
        (_) => const EditPostsSuccessState(AppStrings.deleteSuccessMsg)));
  }

  String msg(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return AppStrings.serverFailureMsg;
      case OffLineFailure:
        return AppStrings.offLineFailureMsg;
      case EmptyCacheFailure:
        return AppStrings.emptyCacheFailureMsg;

      default:
        return AppStrings.unexpectedFailureMsg;
    }
  }
}
