import 'package:flutter/material.dart';
import '../core/error.dart';
import '../domain/post.dart';
import '../domain/post_repository.dart';

class PostProvider with ChangeNotifier {
  final PostRepository repository;
  List<Post> posts = [];
  Failure? error;
  bool isLoading = false;

  PostProvider({required this.repository});

  Future<void> loadPosts() async {
    isLoading = true;
    notifyListeners();

    try {
      posts = await repository.getPosts();
    } catch (e) {
      error = Failure(e.toString());
      notifyListeners();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}