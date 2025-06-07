import '../core/error.dart';
import '../domain/post.dart';

abstract class PostRepository {
  Future<List<Post>> getPosts();
}