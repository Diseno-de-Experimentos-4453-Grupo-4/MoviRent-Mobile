import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movirent/auth/presentation/screens/sign_up_screen.dart';

import '../../../shared/presentation/widgets/app_button.dart';
import '../../../shared/presentation/widgets/app_text_field.dart';
import '../../../ui/styles/ui_styles.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            const SizedBox(height: 70),
            AspectRatio(
              aspectRatio: 3.0,
              child: Text(
                "Inicia Sesión",
                style: TextStyle(
                  fontSize: textLarge,
                  color: secondary,
                ),
              ),
            ),
            AppTextField(
              label: "Email",
              hintText: "Ingrese su email",
              prefixIcon: Icons.email,
              borderColor: secondary,
              focusedBorderColor: Colors.grey,
              labelColor: secondary,

            ),
            const SizedBox(height: 30),
            AppTextField(
              label: "Contraseña",
              hintText: "Ingrese su contraseña",
              prefixIcon: Icons.block,
              obscureText: true,
              borderColor: secondary,
              focusedBorderColor: Colors.grey,
              labelColor: secondary,
            ),
            const SizedBox(height: 50),
            AppButton(
                backgroundButton: primary,
                onPressed: (){},
                label: "Inicia Sesión"
            ),
            AppButton(
                backgroundButton: danger,
                onPressed: (){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => SignUpScreen()));
                },
                label: "Registrate"
            )
          ],
        ),
      ),
    );
  }
}
