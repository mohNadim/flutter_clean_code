import 'package:clean_code_test/core/usecases/usecase.dart';
import 'package:clean_code_test/features/post/domain/entity/post_entity.dart';

abstract class PostRepository {
  Future<UseCaseResult<Post>> createPost(Post post);
  Future<UseCaseResult<List<Post>>> getPosts();
  Future<UseCaseResult<Post>> getPost(int id);
  Future<UseCaseResult<Post>> updatePost(Post post);
  Future<UseCaseResult<void>> deletePost(int id);
}