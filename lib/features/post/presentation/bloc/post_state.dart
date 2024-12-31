// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'post_bloc.dart';


sealed class PostState {}

final class PostInitial extends PostState {}

class PostsLoading extends PostState {}

class PostsLoaded extends PostState {
  List<Post> posts;
  PostsLoaded({
    required this.posts,
  });
}

class PostLoaded extends PostState {
  Post post;
  PostLoaded({
    required this.post,
  });
}

class PostUpdated extends PostState {
  Post post;
  PostUpdated({
    required this.post,
  });
}

class PostCreated extends PostState {
  Post post;
  PostCreated({
    required this.post,
  });
}

class PostDeleted extends PostState {}

class PostsError extends PostState {
  final String message;

  PostsError({required this.message});
}
