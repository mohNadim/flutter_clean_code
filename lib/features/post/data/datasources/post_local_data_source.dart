import 'package:clean_code_test/core/error/exceptions.dart';
import 'package:clean_code_test/features/post/data/model/post_model.dart';
import 'package:hive/hive.dart';

abstract class PostLocalDataSource {
  Future<void> cachePost(PostModel post);
  Future<void> cachePosts(List<PostModel> posts);
  Future<void> deletePost(int id);
  Future<List<PostModel>> getPosts();
  Future<PostModel> getPost(int id);
}

class PostLocalDataSourceImpl implements PostLocalDataSource {
  final Box<PostModel> postsBox;
  // ignore: constant_identifier_names
  static const String POST_BOX_NAME = 'posts_box';

  PostLocalDataSourceImpl({required this.postsBox});

  static Future<PostLocalDataSourceImpl> init() async {
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(PostModelAdapter());
    }
    final box = await Hive.openBox<PostModel>(POST_BOX_NAME);
    return PostLocalDataSourceImpl(postsBox: box);
  }

  @override
  Future<void> cachePosts(List<PostModel> posts) async {
    try {
      await postsBox.clear();
      for (var post in posts) {
        await postsBox.put(post.id, post);
      }
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<void> cachePost(PostModel post) async {
    try {
      await postsBox.put(post.id, post);
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<void> deletePost(int id) async {
    try {
      await postsBox.delete(id);
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<PostModel> getPost(int id) async {
    try {
      final post = postsBox.values.firstWhere(
        (post) => post.id == id,
        orElse: () => throw CacheException(),
      );
      return post;
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<List<PostModel>> getPosts() async {
    try {
      final posts = postsBox.values.toList();
      if (posts.isEmpty) {
        throw CacheException();
      }
      return posts;
    } catch (e) {
      throw CacheException();
    }
  }
}
