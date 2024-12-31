// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'post_bloc.dart';


sealed class PostEvent {}

class GetPostEvent extends PostEvent {
  int id;
  GetPostEvent({
    required this.id,
  });
}

class GetPostsEvent extends PostEvent {}

class CreatePostEvent  extends PostEvent {
  final Post post;

  CreatePostEvent ({required this.post});
}

class UpdatePostEvent  extends PostEvent {
  final Post post;

  UpdatePostEvent ({required this.post});
}

class DeletePostEvent  extends PostEvent {
  int id;
  DeletePostEvent ({
    required this.id,
  });
}
