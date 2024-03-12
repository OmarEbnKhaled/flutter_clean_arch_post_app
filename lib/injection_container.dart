import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/network/network_info.dart';
import 'features/posts/data/data_sources/post_local_data_source.dart';
import 'features/posts/data/data_sources/post_remote_data_source.dart';
import 'features/posts/data/repositories/posts_repository_impl.dart';
import 'features/posts/domain/repositories/posts_repository.dart';
import 'features/posts/domain/use_cases/add_post.dart';
import 'features/posts/domain/use_cases/delete_post.dart';
import 'features/posts/domain/use_cases/get_all_posts.dart';
import 'features/posts/domain/use_cases/update_post.dart';
import 'features/posts/presentation/bloc/add_delete_updete_post/add_delete_update_post_bloc.dart';
import 'features/posts/presentation/bloc/posts/posts_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // ! Feature

  // Bloc
  sl.registerFactory(() => PostsBloc(getAllPosts: sl()));
  sl.registerFactory(
    () => AddDeleteUpdatePostBloc(
      addPost: sl(),
      deletePost: sl(),
      updatePost: sl(),
    ),
  );

  // Usecases
  sl.registerLazySingleton(() => GetAllPostsUescase(repository: sl()));
  sl.registerLazySingleton(() => AddPostUsecase(repository: sl()));
  sl.registerLazySingleton(() => UpdatePostUsecase(repository: sl()));
  sl.registerLazySingleton(() => DeletePostUsecase(repository: sl()));

  // Repository
  sl.registerLazySingleton<PostsRepository>(
    () => PostsRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  // Data Sources
  sl.registerLazySingleton<PostRemoteDataSource>(
      () => PostRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<PostLocalDataSource>(
      () => PostLocalDataSourceImpl(sharedPreferences: sl()));

  // ! Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  // ! External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
