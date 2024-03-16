import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/loading_widget.dart';
import '../bloc/posts/posts_bloc.dart';
import '../widgets/posts_page/message_display_widget.dart';
import '../widgets/posts_page/post_list_widget.dart';
import 'post_add_update_page.dart';

class PostsPage extends StatelessWidget {
  const PostsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _buildFloatingBtn(context),
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  Widget _buildFloatingBtn(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const PostAddUpdatePage(isUpdatePost: false),
          ),
        );
      },
      child: const Icon(Icons.add),
    );
  }

  AppBar _buildAppBar() => AppBar(title: const Text('Posts'));

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: BlocBuilder<PostsBloc, PostsState>(
        builder: (context, state) {
          if (state is LoadingPostsState) {
            return const LoadingWidget();
          } else if (state is LoadedPostsState) {
            return RefreshIndicator(
              onRefresh: () => _onRefresh(context),
              child: PostListWidget(posts: state.posts),
            );
          } else if (state is ErrorPostsState) {
            return MessageDisplayWidget(message: state.message);
          }
          return const LoadingWidget();
        },
      ),
    );
  }

  Future<void> _onRefresh(BuildContext context) async {
    BlocProvider.of<PostsBloc>(context).add(RefreshPostsEvent());
  }
}
