import 'package:flutter/material.dart';
import 'package:socialapp/cubit/comment/comment_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/comment/comment_state.dart';
import '../cubit/post/post_cubit.dart';
import '../cubit/post/post_state.dart';

class PostDetailsScreen extends StatefulWidget {
  final String postId;
  const PostDetailsScreen({super.key, required this.postId});

  @override
  State<PostDetailsScreen> createState() => _PostDetailsScreenState();
}

class _PostDetailsScreenState extends State<PostDetailsScreen> {
  final TextEditingController _commentController = TextEditingController();


  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title: const Text('Post Details'),
            ),
            body: Column(
              children: [
                // Post content section

                BlocBuilder <PostCubit, PostState>
                  (builder: (context, state) {
                    if (state is PostLoading) {
                      return const Center(child: CircularProgressIndicator());
                      } else if (state is PostSuccess) {
                      final post = context.read<PostCubit>().getPostById(widget.postId);
                      if (post == null) {
                        return const Center(child: Text("Post not found"));
                      }
                          return Column(
                            children: [
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: Colors.grey[100],
                                  border: Border(
                                    bottom: BorderSide(color: Colors.grey[300]!),
                                  )
                                ),
                               child: Column(
                               crossAxisAlignment: CrossAxisAlignment.start,
                               children: [
                                 Text(
                                    post.authorName ,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      ),
                                 ),
                                  const SizedBox(height: 8),
                                  Text(
                                    post.content,
                                    style: const TextStyle(fontSize: 16),
                                  ),
                               ],
                              ),
                              )


                            ],
                          );

                    }else {
                      return Center(child: Text("No Posts yet. Be the first!"));
                    }
                    }),
                // Comments section header
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      const Icon(Icons.comment, size: 20),
                      const SizedBox(width: 8),
                      const Text(
                        'Comments',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: BlocBuilder<CommentCubit, CommentState>(
                    builder: (context, state) {
                      if (state is CommentLoading) {
                        return Center(child: CircularProgressIndicator());
                      } else if (state is CommentSuccess) {
                        return ListView.builder(
                          itemCount: state.comments.length,
                          itemBuilder: (context, index) {
                            final comment = state.comments[index];
                            return ListTile(
                              title: Text(comment!.text),
                              subtitle: Text(comment.authorName),
                            );
                          },
                        );
                      } else {
                        return Center(
                            child: Text("No comments yet. Be the first!"));
                      }
                    },
                  ),
                ),
                // Comment input section
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        blurRadius: 4,
                        offset: const Offset(0, -2),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _commentController,
                              decoration: const InputDecoration(
                                hintText: 'Write a comment...',
                                border: OutlineInputBorder(),
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 12,
                                ),
                              ),
                              maxLines: null,
                            ),
                          ),
                          const SizedBox(width: 8),
                          IconButton(
                            icon: Icon(Icons.send),
                            onPressed: () {
                              if (_commentController.text.isNotEmpty) {
                                context.read<CommentCubit>().addComment(
                                    widget.postId,
                                    _commentController.text
                                );
                                _commentController.clear();
                              }
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            )
        )
    );
  }
}
