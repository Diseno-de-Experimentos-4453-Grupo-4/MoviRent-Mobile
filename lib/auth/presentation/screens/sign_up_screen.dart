import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movirent/auth/domain/dto/sign_up.dto.dart';
import 'package:movirent/auth/domain/service/profile.service.dart';
import 'package:movirent/auth/infrastructure/service/fireauth.service.dart';
import 'package:movirent/auth/presentation/screens/auth_screen.dart';
import 'package:movirent/shared/presentation/widgets/custom_alert.dart';

import '../../../shared/presentation/widgets/app_button.dart';
import '../../../shared/presentation/widgets/app_text_field.dart';
import '../../../ui/styles/ui_styles.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController dniController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController streetController = TextEditingController();
  final TextEditingController neighborhoodController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController districtController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool termsChecked = false;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView( 
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            const SizedBox(height: 70),
            AspectRatio(
              aspectRatio: 3.0,
              child: Text(
                "Registrate",
                style: TextStyle(
                  fontSize: textLarge,
                  color: secondary,
                ),
              ),
            ),
            AppTextField(label: "Nombre", hintText: "Ingrese su nombre", prefixIcon: Icons.person, controller: firstNameController, labelColor: secondary),
            const SizedBox(height: 20),
            AppTextField(label: "Apellido", hintText: "Ingrese su apellido", prefixIcon: Icons.person, controller: lastNameController,labelColor: secondary),
            const SizedBox(height: 20),
            AppTextField(label: "Email", hintText: "Ingrese su email", prefixIcon: Icons.email, controller: emailController,labelColor: secondary),
            const SizedBox(height: 20),
            AppTextField(label: "DNI", hintText: "Ingrese su DNI", prefixIcon: Icons.credit_card, controller: dniController,labelColor: secondary),
            const SizedBox(height: 20),
            AppTextField(label: "Edad", hintText: "Ingrese su edad", prefixIcon: Icons.cake, controller: ageController, keyboardType: TextInputType.number,labelColor: secondary),
            const SizedBox(height: 20),
            AppTextField(label: "Teléfono", hintText: "Ingrese su teléfono", prefixIcon: Icons.phone, controller: phoneController,labelColor: secondary),
            const SizedBox(height: 20),
            AppTextField(label: "Calle", hintText: "Ingrese su calle", prefixIcon: Icons.location_on, controller: streetController,labelColor: secondary),
            const SizedBox(height: 20),
            AppTextField(label: "Barrio", hintText: "Ingrese su barrio", prefixIcon: Icons.map, controller: neighborhoodController,labelColor: secondary),
            const SizedBox(height: 20),
            AppTextField(label: "Ciudad", hintText: "Ingrese su ciudad", prefixIcon: Icons.location_city, controller: cityController,labelColor: secondary),
            const SizedBox(height: 20),
            AppTextField(label: "Distrito", hintText: "Ingrese su distrito", prefixIcon: Icons.flag, controller: districtController,labelColor: secondary),
            const SizedBox(height: 20),
            AppTextField(label: "Contraseña", hintText: "Ingrese su contraseña", prefixIcon: Icons.lock, obscureText: true, controller: passwordController,labelColor: secondary),
            const SizedBox(height: 20),
            Row(
              children: [
                Checkbox(
                    value: termsChecked,
                  onChanged: (checked) async {
                    if (!termsChecked) {
                      await showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return CustomAlert(
                            title: "Acuerdos de servicio",
                            content: '''
Obligaciones del Usuario

Responsabilidad sobre el Estado del Scooter:
El usuario es responsable de inspeccionar el estado del scooter antes de iniciar su uso. Cualquier daño o defecto deberá ser reportado a través de la aplicación para evitar cargos por daños preexistentes.

Cumplimiento de las Leyes de Tránsito:
El usuario se compromete a utilizar el scooter de manera responsable y a cumplir con todas las normativas de tránsito locales durante su uso.

Derechos del Usuario

Derecho a la Privacidad y Protección de Datos:
El usuario tiene derecho a que su información personal sea tratada conforme a nuestra política de privacidad, la cual cumple con las regulaciones vigentes en materia de protección de datos.

Acceso al Historial de Pagos:
El usuario puede acceder en todo momento a su historial de pagos y transacciones dentro de la plataforma.

Restricciones del Usuario

Uso No Comercial:
El uso de los scooters está restringido únicamente para fines personales y de transporte. Está prohibido utilizarlos para servicios comerciales o de mensajería sin la aprobación explícita de Movirent.

Prohibición de Subalquiler:
El usuario no está autorizado a subarrendar el scooter a terceros mientras esté en uso bajo su cuenta.
''',
                            isSuccess: true,
                            onPressed:(){
                              Navigator.pop(context);
                            },
                          );
                        },
                      );
                    }

                    setState(() {
                      termsChecked = checked!;
                    });
                  },

                ),
                Flexible(
                  flex: 1,
                  child: Text(
                    "Al registrarse acepta nuestros terminos y condiciones",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: textSmall
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 30),
            AppButton(
              backgroundButton: primary,
              onPressed: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => AuthScreen()));
              },
              label: "Inicia Sesión",
            ),
            AppButton(
              backgroundButton: danger,
              onPressed: () async {
                final request = SignUpDTO(
                  firstName: firstNameController.text,
                  lastName: lastNameController.text,
                  email: emailController.text,
                  dni: dniController.text,
                  age: int.tryParse(ageController.text) ?? 0,
                  phone: phoneController.text,
                  street: streetController.text,
                  neighborhood: neighborhoodController.text,
                  city: cityController.text,
                  district: districtController.text,
                  password: passwordController.text,
                );

                final profileService = ProfileService();
                final fireAuthService = FireAuthService();
                if (!termsChecked){
                  await showDialog(
                    context: context,
                    builder: (context) => CustomAlert(
                      title: "Acepte nuestros terminos y condiciones",
                      content: "Acepte nuestros terminos y condiciones antes de iniciar sesion.",
                      isSuccess: false,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  );
                  return;
                }
                await fireAuthService.signUp(request);
                 try{
                   final success = await profileService.post(request);
                   if (success){
                     await showDialog(
                       context: context,
                       builder: (context) => CustomAlert(
                         title: "Registro exitoso",
                         content: "El usuario se registro con exito",
                         isSuccess: true,
                         onPressed: () {
                           Navigator.push(context, MaterialPageRoute(builder: (_) => AuthScreen()));
                         },
                       ),
                     );
                   }
                 } catch(_){
                   await showDialog(
                     context: context,
                     builder: (context) => CustomAlert(
                       title: "Ocurrió un error en el registro",
                       content: "El usuario en cuestión ya existe",
                       isSuccess: false,
                       onPressed: () => Navigator.of(context).pop(),
                     ),
                   );
                 }
              },
              label: "Registrate",
            )
          ],
        ),
      ),
    );
  }
}
