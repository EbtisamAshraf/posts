import 'package:flutter/material.dart';
import 'package:posts/core/utils/app_strings.dart';
import 'package:posts/features/posts/data/models/add_update_post_model.dart';
import 'package:posts/features/posts/domain/entities/posts.dart';
import 'package:posts/features/posts/presentation/pages/add_update_post_screen.dart';
import 'package:posts/features/posts/presentation/pages/post_detail.dart';
import 'package:posts/features/posts/presentation/pages/posts_screen.dart';

class Routes {
  static const String initRoute = '/';
  static const String addOrUpdatePostRoute = '/addOrUpdate';
  static const String postDetailRoute = '/postDetail';
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.initRoute:
        return MaterialPageRoute(builder: (_) => const PostsScreen());
      case Routes.addOrUpdatePostRoute:
        AddOrUpdatePostModel addOrUpdatePostArguments =
            settings.arguments as AddOrUpdatePostModel;
        return MaterialPageRoute(
            builder: (_) => AddOrUpdatePostScreen(
                  post: addOrUpdatePostArguments.post,
                  isUpdatePost: addOrUpdatePostArguments.isUpdatePost,
                ));

      case Routes.postDetailRoute:
        Post post = settings.arguments as Post;
        return MaterialPageRoute(
            builder: (_) => PostDetail(
                  post: post,
                ));

      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
        builder: (_) => Scaffold(
              appBar: AppBar(
                title: const Text(AppStrings.noRouteFound),
              ),
              body: const Center(child: Text(AppStrings.noRouteFound)),
            ));
  }
}
