import 'package:flutter/material.dart';

import '../widget/custom_button.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea (
        child: Scaffold(
            backgroundColor: const Color(0xfff7efe6),
          body: SizedBox(
            width:double.infinity,
            height: double.infinity,
              child: Stack(
                children: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.7),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                style: const TextStyle(
                                  fontSize: 26,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                                children: [
                                  const TextSpan(
                                    text: 'Welcome in Our Social App ',
                                  ),
                                  WidgetSpan(
                                    alignment: PlaceholderAlignment.middle,
                                    child: Icon(
                                      Icons.favorite,
                                      color: Colors.white,
                                      size: 26,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(height: 20),
                            CustomButton(text: 'Sign In', route: '/login'),
                            CustomButton(text: 'Sign Up', route: '/signup'),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
        )
        )
    );
  }
}
