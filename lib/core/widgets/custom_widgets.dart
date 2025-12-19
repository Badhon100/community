import 'package:community/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'core_widgets.dart';

Widget t14(BuildContext context, String title) => commonText(title, size: 14);

Widget t16(BuildContext context, String title) => commonText(title, size: 16);

Widget t14b600TextPrimary(BuildContext context, String title) => commonText(
  title,
  size: 14,
  fontWeight: FontWeight.w600,
  color: Theme.of(context).colorScheme.onSurface,
);

Widget t18bTextPrimary(BuildContext context, String title) => commonText(
  title,
  size: 18,
  fontWeight: FontWeight.bold,
  color: Theme.of(context).colorScheme.onSurface,
);

Widget t18bTextOnPrimary(BuildContext context, String title) => commonText(
  title,
  size: 18,
  fontWeight: FontWeight.bold,
  color: Theme.of(context).colorScheme.onPrimary,
);


class CustomButton extends StatelessWidget {
  final String text;
  final void Function()? onPressed;

  const CustomButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final bool obscureText;
  final String? Function(String?)? validator;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.label,
    this.obscureText = false,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        filled: true,
        fillColor: Theme.of(context).colorScheme.surface,
      ),
    );
  }
}
