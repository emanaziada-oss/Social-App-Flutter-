import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:socialapp/app.dart';
import 'package:socialapp/cubit/post/post_cubit.dart';
import 'package:socialapp/screen/social_feed_app.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/auth/auth_cubit.dart';
// Main App Entry Point
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
      MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) =>  PostCubit()..listenToPosts()),
        BlocProvider(create: (_) => AuthCubit()),
      ],
      child:const MyApp()
      ),
  );
}





