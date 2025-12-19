import 'package:flutter/material.dart';

class Badged extends StatelessWidget {
  final String text;
  final Color color;
  final Color textColor;

  const Badged({super.key, 
    required this.text,
    required this.color,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(text, style: TextStyle(color: textColor, fontSize: 12)),
    );
  }
}
