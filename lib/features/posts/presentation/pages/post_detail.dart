import 'package:flutter/material.dart';
import 'package:posts/config/routes/app_routes.dart';
import 'package:posts/core/utils/constants.dart';
import 'package:posts/features/posts/data/models/add_update_post_model.dart';
import 'package:posts/features/posts/domain/entities/posts.dart';

class PostDetail extends StatelessWidget {
  const PostDetail({Key? key, required this.post}) : super(key: key);
  final Post post;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Post Detail'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                post.title,
                style: Theme.of(context).textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),
              const Divider(
                height: 40,
              ),
              Text(
                post.body,
                style: Theme.of(context).textTheme.titleMedium,
                textAlign: TextAlign.start,
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                      onPressed: () => Navigator.pushNamed(
                          context, Routes.addOrUpdatePostRoute,
                          arguments: AddOrUpdatePostModel(
                              isUpdatePost: true, post: post)),
                      icon: const Icon(Icons.edit),
                      label: const Text('Edit')),
                  ElevatedButton.icon(
                      onPressed: () {
                        Constants.showDeleteDialog(context: context, msg: 'Are you Sure?',postId: post.id);
                      },
                      style: ElevatedButton.styleFrom(primary: Colors.red),
                      icon: const Icon(Icons.delete_rounded),
                      label: const Text('delete')),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
