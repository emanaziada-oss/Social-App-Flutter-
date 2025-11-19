import 'package:flutter/material.dart';

import 'feed_screen.dart';

class SocialFeedApp extends StatelessWidget {
  const SocialFeedApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Social Feed',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const FeedScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}