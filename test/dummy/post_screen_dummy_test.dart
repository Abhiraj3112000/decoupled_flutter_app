import 'package:decoupled_flutter_app/core/error.dart';
import 'package:decoupled_flutter_app/domain/post.dart';
import 'package:decoupled_flutter_app/presentation/post_provider.dart';
import 'package:decoupled_flutter_app/dummy/post_screen_dummy.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import '../presentation/post_provider_test.mocks.dart';
import './post_screen_dummy_test.mocks.dart';

@GenerateMocks([PostProvider])
void main() {

  testWidgets('when the posts have loaded and no error, then render posts', (WidgetTester tester) async {
    final provider = PostProvider(repository: MockPostRepository());
    provider.posts = [Post(id: 1, title: 'Mock Title')];

    await tester.pumpWidget(
      MaterialApp(
        home: ChangeNotifierProvider<PostProvider>.value(
          value: provider,
          child: const PostScreenDummy(),
        ),
      ),
    );

    await tester.pump();
    expect(find.text('Mock Title'), findsOneWidget);
  });

  testWidgets('when the posts are loading, then show circular progress indicator', (WidgetTester tester) async {
    final provider = PostProvider(repository: MockPostRepository());
    provider.isLoading = true;

    await tester.pumpWidget(
      MaterialApp(
        home: ChangeNotifierProvider<PostProvider>.value(
          value: provider,
          child: const PostScreenDummy(),
        ),
      ),
    );

    await tester.pump();
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('when the posts are loading, then show circular progress indicator', (WidgetTester tester) async {
    final provider = PostProvider(repository: MockPostRepository());
    provider.isLoading = true;

    await tester.pumpWidget(
      MaterialApp(
        home: ChangeNotifierProvider<PostProvider>.value(
          value: provider,
          child: const PostScreenDummy(),
        ),
      ),
    );

    await tester.pump();
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });


  testWidgets('when there is an error, then show a text with error message', (WidgetTester tester) async {
    final provider = PostProvider(repository: MockPostRepository());
    provider.error = Failure('Error occurred while fetching posts');

    await tester.pumpWidget(
      MaterialApp(
        home: ChangeNotifierProvider<PostProvider>.value(
          value: provider,
          child: const PostScreenDummy(),
        ),
      ),
    );

    await tester.pump();

    expect(find.text('Error occurred while fetching posts'), findsOneWidget);
  });

  testWidgets('when the FAB is tapped, then loadPosts is called', (WidgetTester tester) async {
    final mockProvider = MockPostProvider();

    when(mockProvider.posts).thenReturn([]);
    when(mockProvider.isLoading).thenReturn(false);
    when(mockProvider.error).thenReturn(null);
    when(mockProvider.loadPosts()).thenAnswer((_) async => Future.value());

    await tester.pumpWidget(
      MaterialApp(
        home: ChangeNotifierProvider<PostProvider>.value(
          value: mockProvider,
          child: const PostScreenDummy(),
        ),
      ),
    );

    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();

    verify(mockProvider.loadPosts()).called(1);
  });

}