import 'package:decoupled_flutter_app/core/error.dart';
import 'package:decoupled_flutter_app/domain/post_repository.dart';
import 'package:decoupled_flutter_app/domain/post.dart';
import 'package:decoupled_flutter_app/presentation/post_provider.dart';
import 'package:decoupled_flutter_app/presentation/post_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:provider/provider.dart';

import 'post_provider_test.mocks.dart';
import 'post_screen_test.mocks.dart';

@GenerateMocks([PostProvider])
void main() {
  testWidgets('renders post list on success', (WidgetTester tester) async {
    final provider = PostProvider(repository: MockPostRepository());
    provider.posts = [Post(id: 1, title: 'Mock Title')];

    await tester.pumpWidget(
      MaterialApp(
        home: ChangeNotifierProvider<PostProvider>.value(
          value: provider,
          child: const PostScreen(),
        ),
      ),
    );

    await tester.pump();
    expect(find.text('Mock Title'), findsOneWidget);
  });

  testWidgets('shows CircularProgressIndicator when loading', (WidgetTester tester) async {
    final provider = PostProvider(repository: MockPostRepository());
    provider.isLoading = true;

    await tester.pumpWidget(
      MaterialApp(
        home: ChangeNotifierProvider<PostProvider>.value(
          value: provider,
          child: const PostScreen(),
        ),
      ),
    );

    await tester.pump();
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('shows error message when error is present', (WidgetTester tester) async {
    final provider = PostProvider(repository: MockPostRepository());
    provider.error = Failure('Something went wrong');

    await tester.pumpWidget(
      MaterialApp(
        home: ChangeNotifierProvider<PostProvider>.value(
          value: provider,
          child: const PostScreen(),
        ),
      ),
    );

    await tester.pump();
    expect(find.text('Something went wrong'), findsOneWidget);
  });

  testWidgets('calls loadPosts when FloatingActionButton is tapped', (WidgetTester tester) async {
    final mockProvider = MockPostProvider();

    when(mockProvider.posts).thenReturn([]);
    when(mockProvider.isLoading).thenReturn(false);
    when(mockProvider.error).thenReturn(null);
    when(mockProvider.loadPosts()).thenAnswer((_) async => Future.value());

    await tester.pumpWidget(
      MaterialApp(
        home: ChangeNotifierProvider<PostProvider>.value(
          value: mockProvider,
          child: const PostScreen(),
        ),
      ),
    );

    await tester.tap(find.byType(FloatingActionButton));
    await tester.pump();

    verify(mockProvider.loadPosts()).called(2);
  });
}