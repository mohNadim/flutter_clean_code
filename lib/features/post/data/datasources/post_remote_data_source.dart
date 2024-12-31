// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:clean_code_test/core/error/exceptions.dart';
import 'package:dio/dio.dart';

import 'package:clean_code_test/features/post/data/model/post_model.dart';

abstract class PostRemoteDataSource {
  Future<List<PostModel>> getPosts();
  Future<PostModel> getPost(int id);
  Future<PostModel> updatePost(PostModel post);
  Future<PostModel> createPost(PostModel post);
  Future<void> deletePost(int id);
}

class PostRemoteDataSourceImpl implements PostRemoteDataSource {
  String baseUrl = "https://jsonplaceholder.typicode.com/posts";
  Dio dio;
  PostRemoteDataSourceImpl({
    required this.dio,
  });

  @override
  Future<PostModel> createPost(PostModel post) async {
    try {
      final Response response = await dio.post(baseUrl, data: post.toMap());
      if (response.statusCode == 201) {
        return PostModel.fromMap(response.data);
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<void> deletePost(int id) async {
    try {
      final Response response = await dio.delete("$baseUrl/$id");
      if (response.statusCode != 204) {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<PostModel> getPost(int id) async {
    try {
      final Response response = await dio.get("$baseUrl/$id");
      if (response.statusCode == 200) {
        return PostModel.fromMap(response.data);
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<List<PostModel>> getPosts() async {
    try {
      final Response response = await dio.get(baseUrl);
      if (response.statusCode == 200) {
        return (response.data as List)
            .map((element) => PostModel.fromMap(element))
            .toList();
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<PostModel> updatePost(PostModel post) async {
    try {
      final Response response =
          await dio.put("$baseUrl/${post.id}", data: post.toMap());
      if (response.statusCode == 200) {
        return PostModel.fromMap(response.data);
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }
}
