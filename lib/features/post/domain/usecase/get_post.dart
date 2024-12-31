// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:clean_code_test/core/usecases/usecase.dart';
import 'package:clean_code_test/features/post/domain/entity/post_entity.dart';
import 'package:clean_code_test/features/post/domain/repository/post_repository.dart';

class GetPost implements UseCase<Post, int> {
  PostRepository postRepository;
  GetPost(
     this.postRepository,
  );

  @override
  Future<UseCaseResult<Post>> call(int id) => postRepository.getPost(id);
}
