// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:hive/hive.dart';
import 'package:clean_code_test/features/post/domain/entity/post_entity.dart';
part 'post_model.g.dart';

@HiveType(typeId: 0)
class PostModel extends Post {
  @override
  @HiveField(0)
  int? id;
  @override
  @HiveField(1)
  String title;
  @override
  @HiveField(2)
  String body;

  PostModel({this.id, required this.title, required this.body})
      : super(id: id, body: body, title: title);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'body': body,
    };
  }

  factory PostModel.fromMap(Map<String, dynamic> map) {
    return PostModel(
      id: map['id'] != null ? map['id'] as int : null,
      title: map['title'] as String,
      body: map['body'] as String,
    );
  }

  factory PostModel.fromeEntity(Post post) {
    return PostModel(id: post.id, title: post.title, body: post.body);
  }

  String toJson() => json.encode(toMap());

  factory PostModel.fromJson(String source) =>
      PostModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
