import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../widget/postcard.dart';

// Feed Screen - Displays all posts with real-time updates
class FeedScreen extends StatelessWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Social Feed'),
        elevation: 2,
      ),
      body: StreamBuilder<QuerySnapshot>(
        // Real-time stream listening to posts collection
        stream: FirebaseFirestore.instance
            .collection('posts')
            .orderBy('timestamp', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          // Loading state
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // Error state
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }

          // Empty state
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text(
                'No posts yet. Be the first to post!',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            );
          }

          // Display posts
          final posts = snapshot.data!.docs;

          return ListView.builder(
            itemCount: posts.length,
            padding: const EdgeInsets.all(8),
            itemBuilder: (context, index) {
              final post = posts[index];
              final postData = post.data() as Map<String, dynamic>;

              return PostCard(
                postId: post.id,
                authorName: postData['authorName'] ?? 'Anonymous',
                content: postData['content'] ?? '',
                timestamp: postData['timestamp'] as Timestamp?,
              );
            },
          );
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
                _addPost(nameController.text, contentController.text);
                Navigator.pop(context);
              }
            },
            child: const Text('Post'),
          ),
        ],
      ),
    );
  }

  // Add a new post to Firestore
  Future<void> _addPost(String authorName, String content) async {
    await FirebaseFirestore.instance.collection('posts').add({
      'authorName': authorName,
      'content': content,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }
}
