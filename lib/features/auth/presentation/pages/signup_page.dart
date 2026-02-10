import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../widgets/auth_field.dart';
import '../widgets/auth_gradient_button.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Signup. ',
                style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 30),
              AuthField(hintText: 'Name', controller: _nameController),
              const SizedBox(height: 15),
              AuthField(hintText: 'Email', controller: _emailController),
              const SizedBox(height: 15),
              AuthField(
                hintText: 'Password',
                controller: _passwordController,
                isObscureText: true,
              ),
              const SizedBox(height: 20),
              const AuthGradientButton(textButton: 'Sign Up.'),
              const SizedBox(height: 20),
              RichText(
                text: TextSpan(
                  text: 'Already have an account? ',
                  children: [
                    TextSpan(
                      text: 'Sign In.',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: AppColors.gradient2,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
