import 'package:flutter/material.dart';
import 'package:posts/config/routes/app_routes.dart';
import 'package:posts/core/utils/app_colors.dart';
import 'package:posts/features/posts/domain/entities/posts.dart';

class PostsListWidget extends StatelessWidget {
  const PostsListWidget({required this.posts, Key? key}) : super(key: key);
  final List<Post> posts;
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) => ListTile(
          onTap: ()=> Navigator.pushNamed(context, Routes.postDetailRoute ,arguments: posts[index]),
              contentPadding: const EdgeInsets.all(16.0),
              title: Text(posts[index].title),
              subtitle: Text(posts[index].body),
              leading: Text(posts[index].id.toString()),
            ),
        separatorBuilder: (context, index) =>
            Divider(height: 5, color: AppColors.hintColor.withOpacity(0.5)),
        itemCount: posts.length);
  }
}
