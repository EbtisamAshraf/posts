import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts/config/routes/app_routes.dart';
import 'package:posts/config/themes/app_theme.dart';
import 'package:posts/features/posts/presentation/cubit/get_posts_cubit/cubit/get_posts_cubit.dart';
import 'package:posts/features/posts/presentation/cubit/posts_cubit.dart';
import 'package:posts/features/posts/presentation/pages/posts_screen.dart';
import 'package:posts/inject_container.dart' as di;

class PostsApp extends StatelessWidget {
  const PostsApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => di.sl<PostsCubit>(),
        ),
        BlocProvider(
          create: (context) => di.sl<GetPostsCubit>()..getPosts(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Posts',
        theme: appTheme(),
        home: const PostsScreen(),
        onGenerateRoute: RouteGenerator.getRoute,
      ),
    );
  }
}
