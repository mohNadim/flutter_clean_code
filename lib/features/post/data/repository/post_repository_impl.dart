import 'package:clean_code_test/core/error/exceptions.dart';
import 'package:clean_code_test/core/error/failures.dart';
import 'package:clean_code_test/core/network/network_info.dart';
import 'package:clean_code_test/core/usecases/usecase.dart';
import 'package:clean_code_test/features/post/data/datasources/post_local_data_source.dart';
import 'package:clean_code_test/features/post/data/datasources/post_remote_data_source.dart';
import 'package:clean_code_test/features/post/data/model/post_model.dart';
import 'package:clean_code_test/features/post/domain/entity/post_entity.dart';
import 'package:clean_code_test/features/post/domain/repository/post_repository.dart';

class PostRepositoryImpl implements PostRepository {
  final PostLocalDataSource postLocalDataSource;
  final PostRemoteDataSource postRemoteDataSource;
  final NetworkInfo networkInfo;

  PostRepositoryImpl(
      {required this.postLocalDataSource,
      required this.postRemoteDataSource,
      required this.networkInfo});

  @override
  Future<UseCaseResult<Post>> createPost(Post post) async {
    if (await networkInfo.isConnected) {
      try {
        final postModel = PostModel.fromeEntity(post);
        final createdPost = await postRemoteDataSource.createPost(postModel);
        await postLocalDataSource.cachePost(postModel);
        return UseCaseResult.success(createdPost);
      } on ServerException {
        return UseCaseResult.failure(ServerFailure());
      }
    } else {
      return UseCaseResult.failure(NetworkFailure());
    }
  }

  @override
  Future<UseCaseResult<void>> deletePost(int id) async {
    if (await networkInfo.isConnected) {
      try {
        await postRemoteDataSource.deletePost(id);
        await postLocalDataSource.deletePost(id);
        return UseCaseResult.success(null);
      } on ServerException {
        return UseCaseResult.failure(ServerFailure());
      }
    } else {
      return UseCaseResult.failure(NetworkFailure());
    }
  }

  @override
  Future<UseCaseResult<Post>> getPost(int id) async {
    try {
      if (await networkInfo.isConnected) {
        final remotePost = await postRemoteDataSource.getPost(id);
        await postLocalDataSource.cachePost(remotePost);
        return UseCaseResult.success(remotePost);
      } else {
        final localPost = await postLocalDataSource.getPost(id);
        return UseCaseResult.success(localPost);
      }
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<UseCaseResult<List<Post>>> getPosts() async {
    try {
      if (await networkInfo.isConnected) {
        final remotePosts = await postRemoteDataSource.getPosts();
        if (remotePosts.isEmpty) {
          return UseCaseResult.failure(UnexpectedFailure());
        }
        await postLocalDataSource.cachePosts(remotePosts);
        return UseCaseResult.success(remotePosts);
      } else {
        final localPosts = await postLocalDataSource.getPosts();
        if (localPosts.isEmpty) {
          return UseCaseResult.failure(UnexpectedFailure());
        }
        return UseCaseResult.success(localPosts);
      }
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<UseCaseResult<Post>> updatePost(Post post) async{
     if (await networkInfo.isConnected) {
      try {
        final postModel = PostModel.fromeEntity(post);
        final updatedPost = await postRemoteDataSource.updatePost(postModel);
        await postLocalDataSource.cachePost(postModel);
        return UseCaseResult.success(updatedPost);
      } on ServerException {
        return UseCaseResult.failure(ServerFailure());
      }
    } else {
      return UseCaseResult.failure(NetworkFailure());
    }
  }
}
