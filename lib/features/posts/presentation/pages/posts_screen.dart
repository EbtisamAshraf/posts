import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts/config/routes/app_routes.dart';
import 'package:posts/core/widgets/custom_error_widget.dart';
import 'package:posts/core/widgets/custom_loading_widget.dart';
import 'package:posts/features/posts/data/models/add_update_post_model.dart';
import 'package:posts/features/posts/presentation/cubit/get_posts_cubit/cubit/get_posts_cubit.dart';
import 'package:posts/features/posts/presentation/widgets/posts_list_widget.dart';

class PostsScreen extends StatelessWidget {
  const PostsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<GetPostsCubit>(context).getPosts();

    return Scaffold(
      appBar: AppBar(title: const Text('POSTS')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocBuilder<GetPostsCubit, GetPostsState>(
          builder: (context, state) {
            if (state is GetPostsLoadingState) {
              return const CustomLoadingWidget();
            } else if (state is GetPostsLoadedState) {
              return RefreshIndicator(
                onRefresh: () =>
                    BlocProvider.of<GetPostsCubit>(context).getPosts(),
                child: PostsListWidget(
                  posts: state.post,
                ),
              );
            } else if (state is GetPostsErrorState) {
              return CustomErrorWidget(
                msg: state.msg,
              );
            } else {
              return const CustomLoadingWidget();
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.pushNamed(
                context,
                Routes.addOrUpdatePostRoute,
                arguments: AddOrUpdatePostModel(
                  isUpdatePost: false,
                ),
              ),
          tooltip: 'add post',
          child: const Icon(Icons.add)),
    );
  }
}
