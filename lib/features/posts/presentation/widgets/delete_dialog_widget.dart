import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts/config/routes/app_routes.dart';
import 'package:posts/core/utils/constants.dart';
import 'package:posts/core/widgets/custom_loading_widget.dart';
import 'package:posts/features/posts/presentation/cubit/posts_cubit.dart';

class DeleteDialogWidget extends StatelessWidget {
  final String msg;

  final int? postId;

  const DeleteDialogWidget({Key? key, required this.msg, required this.postId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PostsCubit, PostsState>(
      listener: (context, state) {
        if (state is EditPostsSuccessState) {
          Constants.showToast(msg: state.msg, clr: Colors.green);
          Navigator.pushNamedAndRemoveUntil(
              context, Routes.initRoute, (route) => false);
        } else if (state is EditPostsErrorState) {
          Navigator.of(context).pop();
          Constants.showToast(msg: state.msg, clr: Colors.red);
        }
      },
      builder: (context, state) {
        if (state is EditPostsLoadingState) {
          return const AlertDialog(
            title: CustomLoadingWidget(),
          );
        }
        return AlertDialog(
          title: Text(msg),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () =>
                  BlocProvider.of<PostsCubit>(context).deletePost(postId!),
              child: const Text('Yes'),
            ),
          ],
        );
      },
    );
  }
}
