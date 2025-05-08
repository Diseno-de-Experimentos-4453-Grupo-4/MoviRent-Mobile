import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movirent/auth/domain/dto/sign_in.dto.dart';
import 'package:movirent/auth/infrastructure/service/fireauth.service.dart';
import 'package:movirent/auth/presentation/screens/sign_up_screen.dart';
import 'package:movirent/core/shared_helper.dart';
import 'package:movirent/shared/presentation/screens/home_screen.dart';

import '../../../shared/presentation/widgets/app_button.dart';
import '../../../shared/presentation/widgets/app_text_field.dart';
import '../../../shared/presentation/widgets/custom_alert.dart';
import '../../../ui/styles/ui_styles.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  void dispose(){
    passwordController.dispose();
    emailController.dispose();
    super.dispose();
  }
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
              controller: emailController,

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
              controller: passwordController,
            ),
            const SizedBox(height: 50),
            AppButton(
                backgroundButton: primary,
                onPressed: ()async{
                  try{
                    final fireAuthService = FireAuthService();
                    final request = SignInDTO(emailController.text, passwordController.text);
                    final token = await fireAuthService.signIn(request);
                    await SharedHelper().setToken(token!);
                    await SharedHelper().setEmail(emailController.text);
                    await showDialog(
                      context: context,
                      builder: (context) => CustomAlert(
                        title: "Inicio de sesión exitoso",
                        content: "Bienvenido a MoviRent!",
                        isSuccess: true,
                        onPressed: () {
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => HomeScreen()));
                        },
                      ),
                    );
                  } catch (_){
                    await showDialog(
                      context: context,
                      builder: (context) => CustomAlert(
                        title: "Ocurrió un error en el inicio de sesión",
                        content: "Las credenciales proporcionadas no son validas",
                        isSuccess: false,
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    );
                  }

                },
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
