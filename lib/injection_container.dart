import 'package:clean_code_test/core/network/network_info.dart';
import 'package:clean_code_test/features/post/data/datasources/post_local_data_source.dart';
import 'package:clean_code_test/features/post/data/datasources/post_remote_data_source.dart';
import 'package:clean_code_test/features/post/data/model/post_model.dart';
import 'package:clean_code_test/features/post/data/repository/post_repository_impl.dart';
import 'package:clean_code_test/features/post/domain/repository/post_repository.dart';
import 'package:clean_code_test/features/post/domain/usecase/create_post.dart';
import 'package:clean_code_test/features/post/domain/usecase/delete_post.dart';
import 'package:clean_code_test/features/post/domain/usecase/get_post.dart';
import 'package:clean_code_test/features/post/domain/usecase/get_posts.dart';
import 'package:clean_code_test/features/post/domain/usecase/update_post.dart';
import 'package:clean_code_test/features/post/presentation/bloc/post_bloc.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

final sl = GetIt.instance;

Future<void> init() async {
  await Hive.initFlutter();
  //* Data sources
  final postLocalDataSource = await PostLocalDataSourceImpl.init();
  sl.registerLazySingleton<PostLocalDataSource>(
    () => PostLocalDataSourceImpl(postsBox: sl()),
  );

  sl.registerLazySingleton<PostRemoteDataSource>(
    () => PostRemoteDataSourceImpl(dio: sl()),
  );

  //* External

  // Box<PostModel> sharedPreferences = postLocalDataSource.postsBox;
  sl.registerLazySingleton<Box<PostModel>>(() => Hive.box<PostModel>('posts_box'));
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => InternetConnectionChecker());

  //* repository
  sl.registerLazySingleton<PostRepository>(
    () => PostRepositoryImpl(
      postLocalDataSource: sl(),
      postRemoteDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  //* Use cases
  sl.registerLazySingleton(() => GetPost(sl()));
  sl.registerLazySingleton(() => GetPosts(sl()));
  sl.registerLazySingleton(() => CreatePost(sl()));
  sl.registerLazySingleton(() => UpdatePost(sl()));
  sl.registerLazySingleton(() => DeletePost(sl()));

  //* Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  sl.registerFactory(
    () => PostBloc(
      createPost: sl(),
      deletePost: sl(),
      getPost: sl(),
      getPosts: sl(),
      updatePost: sl(),
    ),
  );
}
