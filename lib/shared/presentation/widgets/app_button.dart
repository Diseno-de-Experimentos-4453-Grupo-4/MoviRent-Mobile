import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movirent/ui/styles/ui_styles.dart';

class AppButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final Color backgroundButton;
  const AppButton({super.key, required this.backgroundButton, required this.onPressed, required this.label});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 65,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: backgroundButton,
            foregroundColor: background,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10)
            )
          ),
            onPressed: onPressed,
            child: Text(
              label,
              style: TextStyle(
               fontSize: textMid
              ),
            )
        ),
      ),
    );
  }
}
