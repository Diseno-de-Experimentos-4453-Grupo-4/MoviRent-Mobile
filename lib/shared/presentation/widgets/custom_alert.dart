import 'package:flutter/material.dart';
import 'package:movirent/shared/presentation/widgets/app_button.dart';
import 'package:movirent/ui/styles/ui_styles.dart';

class CustomAlert extends StatelessWidget {
  final String title;
  final String content;
  final bool isSuccess;
  final VoidCallback onPressed;

  const CustomAlert({
    super.key,
    required this.title,
    required this.content,
    required this.isSuccess,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: background,
      content: ConstrainedBox(
        constraints: const BoxConstraints(
          maxHeight: 500, // Altura máxima del modal
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: secondary,
                fontSize: 30,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  content,
                  style: TextStyle(
                    color: secondary,
                    fontSize: textMid - 5,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Image.asset(
              isSuccess ? "assets/success_icon.jpeg" : "assets/error_icon.png",
              width: 70,
            ),
          ],
        ),
      ),
      actions: [
        AppButton(
          backgroundButton: isSuccess ? primary : danger,
          onPressed: onPressed,
          label: "Aceptar",
        ),
      ],
    );
  }
}
