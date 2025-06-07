import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../presentation/post_provider.dart';

class PostScreenDummy extends StatelessWidget {
  const PostScreenDummy({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PostProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Decoupled Flutter App')),
      body: provider.isLoading
          ? Center(child: CircularProgressIndicator())
          : provider.error != null
          ? Center(child: Text(provider.error!.message))
          : ListView.builder(
        itemCount: provider.posts.length,
        itemBuilder: (context, index) {
          final post = provider.posts[index];
          return ListTile(title: Text(post.title));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => provider.loadPosts(),
        child: Icon(Icons.refresh),
      ),
    );
  }
}