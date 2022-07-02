part of 'posts_cubit.dart';

abstract class PostsState extends Equatable {
  const PostsState();

  @override
  List<Object> get props => [];
}

class PostsInitial extends PostsState {}



class EditPostsLoadingState extends PostsState {}

class EditPostsSuccessState extends PostsState {
  final String msg;

  const EditPostsSuccessState(this.msg);
  @override
  List<Object> get props => [msg];
}

class EditPostsErrorState extends PostsState {
  final String msg;

  const EditPostsErrorState(this.msg);
  @override
  List<Object> get props => [msg];
}
