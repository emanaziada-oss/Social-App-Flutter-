import 'package:flutter/material.dart';
import '../cubit/auth/auth_cubit.dart';
import '../cubit/auth/auth_state.dart';
import '../widget/text_form_field.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _rePasswordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _rePasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  SafeArea(
        child: Scaffold(
          backgroundColor: const Color(0xfff7efe6),
          appBar: AppBar(
            title: const Text('Sign Up'),
            // backgroundColor: Colors.black87,
            centerTitle: true,
          ),
          body: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Stack(
              children: [

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
                                  final email = state.user!.email ?? 'User';
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
                                    SnackBar(content: Text(state.errorMessage)),
                                  );
                                }
                              },
                              builder: (context, state) {
                                return Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    CustomTextFormField(
                                        text: 'Name', type: 'text', controller: _nameController),
                                    CustomTextFormField(
                                        text: 'Email', type: 'email', controller: _emailController,),
                                    CustomTextFormField(
                                        text: 'Password', type: 'password',controller: _passwordController,),
                                    CustomTextFormField(
                                        text: 'RePassword', type: 'password', controller: _rePasswordController,),
                                    // Submit Button
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.white,
                                          foregroundColor: Colors.black,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                12),
                                          ),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 40, vertical: 12),
                                        ),
                                        onPressed: () {
                                          context.read<AuthCubit>().register(
                                            _emailController.text.trim(),
                                            _passwordController.text.trim(),
                                            _nameController.text.trim(),
                                          );
                                        },
                                        child: const Text(
                                          'Submit',
                                          style: TextStyle(fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ],
                                );

                              },
                            ),
                          ),
                      ),
                    ),
                  )
              ],
            ),
          ),
        )
    );
  }
}
