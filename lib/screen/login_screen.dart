// //
// // import 'package:flutter/material.dart';
// // import 'package:myproject/bloc/auth/auth_cubit.dart';
// // import 'package:myproject/bloc/auth/auth_state.dart';
// // import '../widget/text_form_field.dart';
// //
// // class LoginForm extends StatefulWidget {
// //   const LoginForm({super.key});
// //
// //   @override
// //   State<LoginForm> createState() => _LoginFormState();
// // }
// //
// // class _LoginFormState extends State<LoginForm> {
// //   final _formKey = GlobalKey<FormState>();
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return BlocProvider(
// //       create :(_)=>AuthCubit(),
// //       child: SafeArea(
// //         child: Scaffold(
// //           appBar: AppBar(
// //             title: const Text('Sign In'),
// //             // backgroundColor: Colors.black87,
// //             centerTitle: true,
// //           ),
// //           body: SizedBox(
// //             width: double.infinity,
// //             height: double.infinity,
// //             child: Stack(
// //               children: [
// //                 Positioned.fill(
// //                   child: Image.asset(
// //                     'assets/welcome/1.png',
// //                     fit: BoxFit.cover,
// //                   ),
// //                 ),
// //
// //                 Center(
// //                   child: Padding(
// //                     padding: const EdgeInsets.symmetric(horizontal: 20),
// //                     child: Container(
// //                       width: double.infinity,
// //                       padding: const EdgeInsets.all(20),
// //                       decoration: BoxDecoration(
// //                         color: Colors.black.withOpacity(0.8),
// //                         borderRadius: BorderRadius.circular(16),
// //                       ),
// //                       child: Form(
// //                         key: _formKey,
// //                         child: Column(
// //                           mainAxisSize: MainAxisSize.min,
// //                           children: [
// //                             CustomTextFormField(text: 'Name', type: 'text'),
// //                             CustomTextFormField(text: 'Email', type: 'email'),
// //                             CustomTextFormField(text: 'Password', type: 'password'),
// //
// //                             // Submit Button
// //                             Padding(
// //                               padding: const EdgeInsets.all(8.0),
// //                               child: ElevatedButton(
// //                                 style: ElevatedButton.styleFrom(
// //                                   backgroundColor: Colors.white,
// //                                   foregroundColor: Colors.black,
// //                                   shape: RoundedRectangleBorder(
// //                                     borderRadius: BorderRadius.circular(12),
// //                                   ),
// //                                   padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
// //                                 ),
// //                                 onPressed: () {},
// //                                 child: const Text(
// //                                   'Submit',
// //                                   style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
// //                                 ),
// //                               ),
// //                             ),
// //                           ],
// //                         ),
// //                       ),
// //                     ),
// //                   ),
// //                 ),
// //               ],
// //             ),
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:myproject/bloc/auth/auth_cubit.dart';
// import 'package:myproject/bloc/auth/auth_state.dart';
// import 'package:myproject/screens/product_screen.dart';
// import '../widget/text_form_field.dart';
//
// class LoginForm extends StatefulWidget {
//   const LoginForm({super.key});
//
//   @override
//   State<LoginForm> createState() => _LoginFormState();
// }
//
// class _LoginFormState extends State<LoginForm> {
//   final _formKey = GlobalKey<FormState>();
//
//   // Controllers
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (_) => AuthCubit(),
//       child: SafeArea(
//         child: Scaffold(
//           appBar: AppBar(
//             title: const Text('Sign In'),
//             centerTitle: true,
//           ),
//           body: SizedBox(
//             width: double.infinity,
//             height: double.infinity,
//             child: Stack(
//               children: [
//                 /// Background Image
//                 Positioned.fill(
//                   child: Image.asset(
//                     'assets/welcome/1.png',
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//
//                 /// Login Form Card
//                 Center(
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 20),
//                     child: Container(
//                       width: double.infinity,
//                       padding: const EdgeInsets.all(20),
//                       decoration: BoxDecoration(
//                         color: Colors.black.withOpacity(0.8),
//                         borderRadius: BorderRadius.circular(16),
//                       ),
//                       child: Form(
//                         key: _formKey,
//                         child: BlocConsumer<AuthCubit, AuthState>(
//                           listenWhen: (previous, current) =>
//                           current is AuthSuccess || current is AuthFailure,
//                           listener: (context, state) {
//                             if (state is AuthSuccess) {
//                               ScaffoldMessenger.of(context).showSnackBar(
//                                 SnackBar(content: Text('Welcome ${state.user!.email!}')),
//                               );
//
//                               Future.delayed(const Duration(milliseconds: 500), () {
//                                 if (!context.mounted) return;
//                                 Navigator.pushReplacement(
//                                   context,
//                                   MaterialPageRoute(builder: (_) => const ProductsScreen()),
//                                 );
//                               });
//                             } else if (state is AuthFailure) {
//                               ScaffoldMessenger.of(context).showSnackBar(
//                                 SnackBar(content: Text(state.errorMessage)),
//                               );
//                             }
//                           },
//                           builder: (context, state) {
//                             return Column(
//                               mainAxisSize: MainAxisSize.min,
//                               children: [
//                                 // Name (optional)
//                                 CustomTextFormField(text: 'Email', type: 'email', controller: _emailController),
//                                 CustomTextFormField(text: 'Password', type: 'password', controller: _passwordController),
//
//                                 const SizedBox(height: 20),
//
//                                 // Login Button
//                                 state is AuthLoading
//                                     ? const CircularProgressIndicator()
//                                     : ElevatedButton(
//                                   style: ElevatedButton.styleFrom(
//                                     backgroundColor: Colors.white,
//                                     foregroundColor: Colors.black,
//                                     shape: RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(12),
//                                     ),
//                                     padding: const EdgeInsets.symmetric(
//                                       horizontal: 40,
//                                       vertical: 12,
//                                     ),
//                                   ),
//                                   onPressed: () {
//                                     if (_formKey.currentState!.validate()) {
//                                       context.read<AuthCubit>().login(
//                                         _emailController.text.trim(),
//                                         _passwordController.text.trim(),
//                                       );
//                                     }
//                                   },
//                                   child: const Text(
//                                     'Sign In',
//                                     style: TextStyle(
//                                         fontSize: 16,
//                                         fontWeight: FontWeight.bold),
//                                   ),
//                                 ),
//                               ],
//                             );
//                           },
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/auth/auth_cubit.dart';
import '../cubit/auth/auth_state.dart';
import '../widget/text_form_field.dart';
class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          backgroundColor: const Color(0xfff7efe6),
          appBar: AppBar(
            title: const Text('Sign In'),
            centerTitle: true,
          ),
          body: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Stack(
              children: [
                // Login Form Card
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Form(
                        key: _formKey,
                        child: BlocConsumer<AuthCubit, AuthState>(
                          listenWhen: (previous, current) =>
                          current is AuthSuccess || current is AuthFailure,
                          listener: (context, state) {
                            if (state is AuthSuccess) {
                              final email = state.user!.email?? 'User';
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Welcome $email')),
                              );

                              // Navigate after short delay so user sees snackbar (optional)
                              Future.delayed(const Duration(milliseconds: 300), () {
                                if (!context.mounted) return;
                                Navigator.pushReplacementNamed(
                                  context,
                                  '/social',
                                );
                              });
                            } else if (state is AuthFailure) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(state.errorMessage.toString())),
                              );
                            }
                          },
                          builder: (context, state) {
                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                CustomTextFormField(
                                  text: 'Email',
                                  type: 'email',
                                  controller: _emailController,
                                ),
                                CustomTextFormField(
                                  text: 'Password',
                                  type: 'password',
                                  controller: _passwordController,
                                ),
                                const SizedBox(height: 20),
                                state is AuthLoading
                                    ? const CircularProgressIndicator()
                                    : ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    foregroundColor: Colors.black,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 40,
                                      vertical: 12,
                                    ),
                                  ),
                                  onPressed: () {
                                      context.read<AuthCubit>().login(
                                        _emailController.text.trim(),
                                        _passwordController.text.trim(),
                                      );
                                      print( 'user: ${FirebaseAuth.instance.currentUser}');
                                  },
                                  child: const Text(
                                    'Sign In',
                                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

    );
  }
}
