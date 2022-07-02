import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts/core/errors/failure.dart';
import 'package:posts/core/utils/app_strings.dart';
import 'package:posts/features/posts/domain/entities/posts.dart';
import 'package:posts/features/posts/domain/use_cases/get_all_posts.dart';

part 'get_posts_state.dart';

class GetPostsCubit extends Cubit<GetPostsState> {
  GetPostsCubit({required this.getAllPostsUseCase}) : super(GetPostsInitial());


  final GetAllPostsUseCase getAllPostsUseCase;

  Future<void> getPosts() async {
    emit(GetPostsLoadingState());
    Either<Failure, List<Post>> response = await getAllPostsUseCase();
    emit(response.fold(
      (failure) => GetPostsErrorState(
        msg(failure),
      ),
      (posts) => GetPostsLoadedState(posts),
    ));
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
