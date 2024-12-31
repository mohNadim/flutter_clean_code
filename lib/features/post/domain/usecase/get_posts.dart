// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:clean_code_test/core/usecases/usecase.dart';
import 'package:clean_code_test/features/post/domain/entity/post_entity.dart';
import 'package:clean_code_test/features/post/domain/repository/post_repository.dart';

class GetPosts implements UseCase<List<Post>, NoParams> {
  final PostRepository postRepository;
  GetPosts(
     this.postRepository,
  );

  @override
  Future<UseCaseResult<List<Post>>> call(NoParams params) =>
      postRepository.getPosts();
}
