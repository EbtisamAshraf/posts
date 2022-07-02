import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts/config/routes/app_routes.dart';
import 'package:posts/core/utils/constants.dart';
import 'package:posts/core/widgets/custom_loading_widget.dart';
import 'package:posts/features/posts/domain/entities/posts.dart';
import 'package:posts/features/posts/presentation/cubit/posts_cubit.dart';
import 'package:posts/features/posts/presentation/widgets/form_widget.dart';

class AddOrUpdatePostScreen extends StatelessWidget {
  const AddOrUpdatePostScreen({Key? key, this.post, this.isUpdatePost = false})
      : super(key: key);
  final Post? post;
  final bool isUpdatePost;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(isUpdatePost ? 'Edit post' : 'Add post')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(35.0),
          child: BlocConsumer<PostsCubit, PostsState>(
            listener: (context, state) {
              if (state is EditPostsSuccessState) {
                Constants.showToast(msg: state.msg, clr: Colors.green);
                Navigator.pushNamedAndRemoveUntil(
                    context, Routes.initRoute, (route) => false);
              } else if (state is EditPostsErrorState) {
                Constants.showToast(msg: state.msg, clr: Colors.red);
              }
            },
            builder: (context, state) {
              if (state is EditPostsLoadingState) {
                return const CustomLoadingWidget();
              }
              return CustomFormWidget(
                  isUpdatePost: isUpdatePost, post: isUpdatePost ? post : null);
            },
          ),
        ),
      ),
    );
  }
}
