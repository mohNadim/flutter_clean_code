// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:clean_code_test/core/usecases/usecase.dart';
import 'package:clean_code_test/features/post/domain/repository/post_repository.dart';

class DeletePost implements UseCase<void, int> {
  PostRepository postRepository;
  DeletePost(
     this.postRepository,
  );
  @override
  Future<UseCaseResult<void>> call(int id) => postRepository.deletePost(id);
}
