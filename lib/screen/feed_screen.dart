
import 'package:flutter/material.dart';
import 'package:socialapp/cubit/post/post_cubit.dart';
import '../cubit/post/post_state.dart';
import '../widget/postcard.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// Feed Screen - Displays all posts with real-time updates
class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Social Feed'),
        elevation: 2,
      ),
      body: BlocBuilder <PostCubit,PostState>(
        builder: (context, state) {
          // Loading state
          if (state is PostLoading) {
            return const Center(child: CircularProgressIndicator());
          }else if (state is PostSuccess){
            return ListView.builder(
              itemCount: state.posts.length,
              padding: const EdgeInsets.all(8),
              itemBuilder: (context, index) {
                final post = state.posts[index];

                return PostCard(
                  postId: post.id,
                  authorName: post.authorName ,
                  content:post.content ,
                  timestamp: post.timestamp,
                );
              },
            );
          }else if (state is PostFailure){
            return Center(
                  child: Text('Error: ${state.message}'),
                );
          }
          return const SizedBox();
        },

      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddPostDialog(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  // Dialog to add a new post
  void _showAddPostDialog(BuildContext context) {
    final contentController = TextEditingController();
    final nameController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Create Post'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Your Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: contentController,
              decoration: const InputDecoration(
                labelText: 'Post Content',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (contentController.text.isNotEmpty &&
                  nameController.text.isNotEmpty) {
                context.read<PostCubit>().addPosts(
                    nameController.text,
                    contentController.text);
                Navigator.pop(context);
              }
            },
            child: const Text('Post'),
          ),
        ],
      ),
    );
  }


}
