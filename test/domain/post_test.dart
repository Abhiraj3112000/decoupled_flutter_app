import 'package:decoupled_flutter_app/domain/post.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Post model tests', () {
    test('should create a Post instance with constructor', () {
      final post = Post(id: 1, title: 'Hello');

      expect(post.id, 1);
      expect(post.title, 'Hello');
    });

    test('should create a Post instance from JSON', () {
      final json = {'id': 2, 'title': 'World'};
      final post = Post.fromJson(json);

      expect(post.id, 2);
      expect(post.title, 'World');
    });

    test('should throw if JSON is missing keys (optional)', () {
      final json = {'id': 3}; // 'title' missing

      expect(() => Post.fromJson(json), throwsA(isA<TypeError>()));
    });
  });
}