import '../domain/post.dart';
import '../domain/post_repository.dart';
import 'post_api.dart';

class PostRepositoryImpl implements PostRepository {
  final PostApi api;
  PostRepositoryImpl(this.api);

  @override
  Future<List<Post>> getPosts() => api.fetchPosts();
}