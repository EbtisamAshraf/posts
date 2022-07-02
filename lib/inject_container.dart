import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:posts/core/network/network_info.dart';
import 'package:posts/features/posts/data/data_sources/posts_local_data_source.dart';
import 'package:posts/features/posts/data/data_sources/posts_remote_data_source.dart';
import 'package:posts/features/posts/data/repositories/posts_repository_impl.dart';
import 'package:posts/features/posts/domain/repositories/posts_repository.dart';
import 'package:posts/features/posts/domain/use_cases/add_post.dart';
import 'package:posts/features/posts/domain/use_cases/del_post.dart';
import 'package:posts/features/posts/domain/use_cases/get_all_posts.dart';
import 'package:posts/features/posts/domain/use_cases/update_post.dart';
import 'package:posts/features/posts/presentation/cubit/get_posts_cubit/cubit/get_posts_cubit.dart';
import 'package:posts/features/posts/presentation/cubit/posts_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

final sl = GetIt.instance;

Future<void> init() async {
  ///feature
  //bloc
  sl.registerFactory(() => PostsCubit(
      addPostUseCase: sl(), deletePostUseCase: sl(), updatePostUseCase: sl()));

  sl.registerFactory(
    () => GetPostsCubit(
      getAllPostsUseCase: sl(),
    ),
  );

  // repo
  sl.registerLazySingleton<PostsRepository>(() => PostsRepositoryImpl(
      networkInfo: sl(),
      postsLocalDataSource: sl(),
      postsRemoteDataSource: sl()));
  // date source
  sl.registerLazySingleton<PostsLocalDataSource>(
      () => PostsLocalDataSourceImpl(sharedPreferences: sl()));
  sl.registerLazySingleton<PostsRemoteDataSource>(
      () => PostsRemoteDataSourceImpl(client: sl()));

// use cases
  sl.registerLazySingleton(() => AddPostUseCase(sl()));
  sl.registerLazySingleton(() => UpdatePostUseCase(sl()));
  sl.registerLazySingleton(() => GetAllPostsUseCase(sl()));
  sl.registerLazySingleton(() => DeletePostUseCase(sl()));

  /// core

  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  /// external

  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
