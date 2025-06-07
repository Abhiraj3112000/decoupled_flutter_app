// test/post_provider_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:decoupled_flutter_app/domain/post.dart';
import 'package:decoupled_flutter_app/presentation/post_provider.dart';
import 'package:decoupled_flutter_app/domain/post_repository.dart';

import 'post_provider_test.mocks.dart';

@GenerateMocks([PostRepository])
void main() {
  late PostProvider provider;
  late MockPostRepository mockRepo;

  setUp(() {
    mockRepo = MockPostRepository();
    provider = PostProvider(repository: mockRepo);
  });

  test('should load posts successfully', () async {
    final dummyPosts = [Post(id: 1, title: 'Hello')];
    when(mockRepo.getPosts()).thenAnswer((_) async => dummyPosts);

    await provider.loadPosts();

    expect(provider.posts.length, 1);
    expect(provider.posts.first.title, 'Hello');
    verify(mockRepo.getPosts()).called(1);
  });

  test('should handle error', () async {
    when(mockRepo.getPosts()).thenThrow(Exception('Failed'));

    await provider.loadPosts();

    expect(provider.error, isNotNull);
    expect(provider.error!.message, contains('Failed'));
  });
}