// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:clean_code_test/core/usecases/usecase.dart';
import 'package:clean_code_test/features/post/domain/entity/post_entity.dart';
import 'package:clean_code_test/features/post/domain/repository/post_repository.dart';

class UpdatePost implements UseCase<Post, Post> {
  PostRepository postRepository;
  UpdatePost(
     this.postRepository,
  );
  @override
  Future<UseCaseResult<Post>> call(Post post) =>
      postRepository.updatePost(post);
}
