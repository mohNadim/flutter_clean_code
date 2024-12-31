import 'package:clean_code_test/core/usecases/usecase.dart';
import 'package:clean_code_test/features/post/domain/entity/post_entity.dart';
import 'package:clean_code_test/features/post/domain/usecase/create_post.dart';
import 'package:clean_code_test/features/post/domain/usecase/delete_post.dart';
import 'package:clean_code_test/features/post/domain/usecase/get_post.dart';
import 'package:clean_code_test/features/post/domain/usecase/get_posts.dart';
import 'package:clean_code_test/features/post/domain/usecase/update_post.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final CreatePost createPost;
  final GetPost getPost;
  final GetPosts getPosts;
  final UpdatePost updatePost;
  final DeletePost deletePost;
  PostBloc(
   {
    required this.createPost,
    required this.getPost,
    required this.getPosts,
    required this.updatePost,
    required this.deletePost,
   }
  ) : super(PostInitial()) {
    on<GetPostEvent>(_onGetPostEvent);
    on<GetPostsEvent>(_onGetPostsEvent);
    on<CreatePostEvent>(_onCreatePostEvent);
    on<UpdatePostEvent>(_onUpdatePostsEvent);
    on<DeletePostEvent>(_onDeletePostEvent);
  }

  Future<void> _onGetPostEvent(
    GetPostEvent event,
    Emitter<PostState> emit,
  ) async {
    emit(PostsLoading());
    final result = await getPost(event.id);
    if (result.isSuccess) {
      emit(PostLoaded(post: result.data!));
    } else {
      emit(PostsError(message: result.error!.message));
    }
  }

  Future<void> _onGetPostsEvent(
    GetPostsEvent event,
    Emitter<PostState> emit,
  ) async {
    emit(PostsLoading());
    final result = await getPosts(const NoParams());
    if (result.isSuccess) {
      emit(PostsLoaded(posts: result.data!));
    } else {
      emit(PostsError(message: result.error!.message));
    }
  }

  _onCreatePostEvent(
    CreatePostEvent event,
    Emitter<PostState> emit,
  ) async {
    emit(PostsLoading());
    final result = await createPost(event.post);
    if (result.isSuccess) {
      emit(PostCreated(post: result.data!));
    } else {
      emit(PostsError(message: result.error!.message));
    }
  }

  _onUpdatePostsEvent(
    UpdatePostEvent event,
    Emitter<PostState> emit,
  ) async {
    emit(PostsLoading());
    final result = await updatePost(event.post);
    if (result.isSuccess) {
      emit(PostUpdated(post: result.data!));
    } else {
      emit(PostsError(message: result.error!.message));
    }
  }

  _onDeletePostEvent(
    DeletePostEvent event,
    Emitter<PostState> emit,
  ) async {
    emit(PostsLoading());
    final result = await deletePost(event.id);
    if (result.isSuccess) {
      emit(PostDeleted());
    } else {
      emit(PostsError(message: result.error!.message));
    }
  }
}
