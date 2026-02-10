import 'package:blog_app/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class AuthGradientButton extends StatelessWidget {
  final String textButton;
  const AuthGradientButton({super.key, required this.textButton});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7),
        gradient: const LinearGradient(
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          colors: [AppColors.gradient1, AppColors.gradient2],
        ),
      ),
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          fixedSize: const Size(395, 55),
          backgroundColor: AppColors.transparentColor,
          shadowColor: AppColors.transparentColor,
        ),
        child: Text(
          textButton,
          style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
