import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movirent/shared/presentation/widgets/app_button.dart';
import 'package:movirent/ui/styles/ui_styles.dart';

class CustomAlert extends StatelessWidget {
  final String title;
  final String content;
  final bool isSuccess;
  final VoidCallback onPressed;
  const CustomAlert({super.key, required this.title, required this.content, required this.isSuccess,  required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: background,
      content: SizedBox(
        height: 400,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
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
            Flexible(
              flex: 1,
              child: Text(
                  content,
                style: TextStyle(
                  color: secondary,
                  fontSize: textMid - 5
                ),
              ),
            ),
            const SizedBox(height: 20),
            isSuccess ?
            Image.asset(
                "assets/success_icon.jpeg",
              width: 70,
            ) :
            Image.asset(
                "assets/error_icon.png",
              width: 70,
            )
          ],
        ),
      ),
      actions: [
        AppButton(
            backgroundButton: isSuccess ? primary : danger,
            onPressed: onPressed,
            label: "Aceptar"
        ),
      ],
    );
  }
}
