import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'post_provider.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  bool _isLoaded = false;
  late PostProvider provider;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isLoaded) {
      provider = Provider.of<PostProvider>(context);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        provider.loadPosts();
      });
      _isLoaded = true;
    }
  }

  @override
  Widget build(BuildContext context) {

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