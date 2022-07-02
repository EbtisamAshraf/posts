part of 'get_posts_cubit.dart';

abstract class GetPostsState extends Equatable {
  const GetPostsState();

  @override
  List<Object> get props => [];
}

class GetPostsInitial extends GetPostsState {}

class GetPostsLoadingState extends GetPostsState {}

class GetPostsLoadedState extends GetPostsState {
  final List<Post> post;

  const GetPostsLoadedState(this.post);
  @override
  List<Object> get props => [post];
}

class GetPostsErrorState extends GetPostsState {
  final String msg;

  const GetPostsErrorState(this.msg);
  @override
  List<Object> get props => [msg];
}