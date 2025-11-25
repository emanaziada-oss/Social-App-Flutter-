import 'package:flutter/material.dart';
import 'package:socialapp/cubit/post/post_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'feed_screen.dart';

class SocialFeedApp extends StatelessWidget {
  const SocialFeedApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PostCubit>(
          create: (_) => PostCubit()..listenToPosts(),
        ),
      ], child:MaterialApp(
      title: 'Social Feed',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const FeedScreen(),
      debugShowCheckedModeBanner: false,
    ),
    );
  }
}