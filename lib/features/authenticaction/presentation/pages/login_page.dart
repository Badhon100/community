import 'package:community/core/helpers/snack_bar_helper.dart';
import 'package:community/core/widgets/custom_widgets.dart';
import 'package:community/features/authenticaction/presentation/bloc/auth/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthFailure) {
            showSnackBar(context, state.message);
          } else if (state is AuthSuccess) {
            showSnackBar(context, "Login Successful");
            // Navigate to home page
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomTextField(controller: _emailController, label: 'Email'),
                const SizedBox(height: 16),
                CustomTextField(
                  controller: _passwordController,
                  label: 'Password',
                  obscureText: true,
                ),
                const SizedBox(height: 24),
                BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    if (state is AuthLoading) {
                      return const CircularProgressIndicator();
                    }
                    return CustomButton(
                      text: "Login",
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          context.read<AuthBloc>().add(
                            LoginRequested(
                              email: _emailController.text.trim(),
                              password: _passwordController.text.trim(),
                            ),
                          );
                        }
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
