 import 'package:flutter/material.dart';
import 'package:socialapp/cubit/comment/comment_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:socialapp/models/comments_model.dart';

import '../cubit/comment/comment_state.dart';
import '../cubit/post/post_cubit.dart';
import '../cubit/post/post_state.dart';

// // Post Detail Screen - Displays comments with real-time updates
// class PostDetailScreen extends StatefulWidget {
//   final String postId;
//
//   const PostDetailScreen({Key? key, required this.postId}) : super(key: key);
//
//   @override
//   State<PostDetailScreen> createState() => _PostDetailScreenState();
// }
 // class _PostDetailScreenState extends State<PostDetailScreen> {
 //   final TextEditingController _commentController = TextEditingController();
 //   final TextEditingController _nameController = TextEditingController();
 //
 //   @override
 //   void dispose() {
 //     _commentController.dispose();
 //     _nameController.dispose();
 //     super.dispose();
 //   }
 //
 //   // Add comment function as specified in requirements
 //   Future<void> addComment(String postId, String commentText) async {
 //     if (commentText.trim().isEmpty && _nameController.text.trim().isEmpty) {
 //       return;
 //     }
 //
 //     await FirebaseFirestore.instance
 //         .collection('posts')
 //         .doc(postId)
 //         .collection('comments')
 //         .add({
 //       'authorName': _nameController.text.trim(),
 //       'text': commentText.trim(),
 //       'timestamp': FieldValue.serverTimestamp(),
 //     });
 //
 //     _commentController.clear();
 //   }
 //
 //   @override
 //   Widget build(BuildContext context) {
 //     return Scaffold(
 //       appBar: AppBar(
 //         title: const Text('Post Details'),
 //       ),
 //       body: Column(
 //         children: [
 //           // Post content section
 //           FutureBuilder<DocumentSnapshot>(
 //             future: FirebaseFirestore.instance
 //                 .collection('posts')
 //                 .doc(widget.postId)
 //                 .get(),
 //             builder: (context, snapshot) {
 //               if (!snapshot.hasData) {
 //                 return const Padding(
 //                   padding: EdgeInsets.all(16),
 //                   child: CircularProgressIndicator(),
 //                 );
 //               }
 //
 //               final postData = snapshot.data!.data() as Map<String, dynamic>;
 //               return Container(
 //                 width: double.infinity,
 //                 padding: const EdgeInsets.all(16),
 //                 decoration: BoxDecoration(
 //                   color: Colors.grey[100],
 //                   border: Border(
 //                     bottom: BorderSide(color: Colors.grey[300]!),
 //                   ),
 //                 ),
 //                 child: Column(
 //                   crossAxisAlignment: CrossAxisAlignment.start,
 //                   children: [
 //                     Text(
 //                       postData['authorName'] ?? 'Anonymous',
 //                       style: const TextStyle(
 //                         fontWeight: FontWeight.bold,
 //                         fontSize: 18,
 //                       ),
 //                     ),
 //                     const SizedBox(height: 8),
 //                     Text(
 //                       postData['content'] ?? '',
 //                       style: const TextStyle(fontSize: 16),
 //                     ),
 //                   ],
 //                 ),
 //               );
 //             },
 //           ),
 //
 //           // Comments section header
 //           Padding(
 //             padding: const EdgeInsets.all(16),
 //             child: Row(
 //               children: [
 //                 const Icon(Icons.comment, size: 20),
 //                 const SizedBox(width: 8),
 //                 const Text(
 //                   'Comments',
 //                   style: TextStyle(
 //                     fontSize: 18,
 //                     fontWeight: FontWeight.bold,
 //                   ),
 //                 ),
 //               ],
 //             ),
 //           ),
 //
 //           // Real-time comments list
 //           Expanded(
 //             child: StreamBuilder<QuerySnapshot>(
 //               stream: FirebaseFirestore.instance
 //                   .collection('posts')
 //                   .doc(widget.postId)
 //                   .collection('comments')
 //                   .orderBy('timestamp', descending: true)
 //                   .snapshots(),
 //               builder: (context, snapshot) {
 //                 if (snapshot.connectionState == ConnectionState.waiting) {
 //                   return const Center(child: CircularProgressIndicator());
 //                 }
 //
 //                 if (snapshot.hasError) {
 //                   return Center(child: Text('Error: ${snapshot.error}'));
 //                 }
 //
 //                 if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
 //                   return const Center(
 //                     child: Text(
 //                       'No comments yet. Be the first!',
 //                       style: TextStyle(color: Colors.grey),
 //                     ),
 //                   );
 //                 }
 //
 //                 final comments = snapshot.data!.docs;
 //
 //                 return ListView.builder(
 //                   itemCount: comments.length,
 //                   padding: const EdgeInsets.symmetric(horizontal: 16),
 //                   itemBuilder: (context, index) {
 //                     final comment = comments[index].data() as Map<String, dynamic>;
 //                     return CommentCard(
 //                       authorName: comment['authorName'] ?? 'Anonymous',
 //                       text: comment['text'] ?? '',
 //                       timestamp: comment['timestamp'] as Timestamp?,
 //                     );
 //                   },
 //                 );
 //               },
 //             ),
 //           ),
 //
 //           // Comment input section
 //           Container(
 //             decoration: BoxDecoration(
 //               color: Colors.white,
 //               boxShadow: [
 //                 BoxShadow(
 //                   color: Colors.grey.withOpacity(0.3),
 //                   blurRadius: 4,
 //                   offset: const Offset(0, -2),
 //                 ),
 //               ],
 //             ),
 //             padding: const EdgeInsets.all(16),
 //             child: Column(
 //               children: [
 //                 TextField(
 //                   controller: _nameController,
 //                   decoration: const InputDecoration(
 //                     hintText: 'Your name',
 //                     border: OutlineInputBorder(),
 //                     contentPadding: EdgeInsets.symmetric(
 //                       horizontal: 12,
 //                       vertical: 8,
 //                     ),
 //                   ),
 //                 ),
 //                 const SizedBox(height: 8),
 //                 Row(
 //                   children: [
 //                     Expanded(
 //                       child: TextField(
 //                         controller: _commentController,
 //                         decoration: const InputDecoration(
 //                           hintText: 'Write a comment...',
 //                           border: OutlineInputBorder(),
 //                           contentPadding: EdgeInsets.symmetric(
 //                             horizontal: 12,
 //                             vertical: 12,
 //                           ),
 //                         ),
 //                         maxLines: null,
 //                       ),
 //                     ),
 //                     const SizedBox(width: 8),
 //                     IconButton(
 //                       onPressed: () => addComment(
 //                         widget.postId,
 //                         _commentController.text,
 //                       ),
 //                       icon: const Icon(Icons.send),
 //                       color: Theme.of(context).primaryColor,
 //                       iconSize: 28,
 //                     ),
 //                   ],
 //                 ),
 //               ],
 //             ),
 //           ),
 //         ],
 //       ),
 //     );
 //   }
 // }
class PostDetailsScreen extends StatefulWidget {
  final String postId;
  const PostDetailsScreen({super.key, required this.postId});

  @override
  State<PostDetailsScreen> createState() => _PostDetailsScreenState();
}

class _PostDetailsScreenState extends State<PostDetailsScreen> {
  final TextEditingController _commentController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();


  @override
  void dispose() {
    _commentController.dispose();
    _nameController.dispose();
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
                      return ListView.builder(
                        itemCount: state.posts.length,
                        itemBuilder: (context, index) {
                          final post = state.posts;
                          return Column(
                            children: [
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: Colors.grey[100],
                                  border: Border(
                                    bottom: BorderSide(color: Colors.grey[300]!),
                                  ),
                                )
                              ),
                               Column(
                               crossAxisAlignment: CrossAxisAlignment.start,
                               children: [
                                 Text(
                                    post.authorName ?? 'Anonymous',
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


                            ],
                          );
                        },
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
                      TextField(
                        controller: _nameController,
                        decoration: const InputDecoration(
                          hintText: 'Your name',
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                        ),
                      ),
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
                              if (_commentController.text.isNotEmpty &&
                                  _nameController.text.isNotEmpty) {
                                context.read<CommentCubit>().addComment(
                                    widget.postId,
                                    _nameController.text,
                                    _commentController.text
                                );
                                _commentController.clear();
                                _nameController.clear();
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