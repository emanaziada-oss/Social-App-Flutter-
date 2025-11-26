import 'package:flutter/material.dart';
import 'package:socialapp/screen/login_screen.dart';
import 'package:socialapp/screen/signup_screen.dart';
import 'package:socialapp/screen/social_feed_app.dart';
import 'package:socialapp/screen/welcome_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
        title: 'Donut Delights',
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/' : (context) => const WelcomeScreen(),
          '/login' : (context)=> LoginForm(),
          '/signup' : (context)=>  SignupScreen(),
          '/social':(context)=> SocialFeedApp() ,
        },
      );

    }
  }
