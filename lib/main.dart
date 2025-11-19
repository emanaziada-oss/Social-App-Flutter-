import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:socialapp/screen/social_feed_app.dart';

// Main App Entry Point
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const SocialFeedApp());
}





