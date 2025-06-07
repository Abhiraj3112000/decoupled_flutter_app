import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'data/post_api.dart';
import 'data/post_repository_impl.dart';
import 'presentation/post_provider.dart';

List<SingleChildWidget> providers = [
  ChangeNotifierProvider(
    create: (_) => PostProvider(
      repository: PostRepositoryImpl(PostApi()),
    ),
  ),
];