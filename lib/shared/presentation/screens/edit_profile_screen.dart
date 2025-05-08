import 'package:flutter/material.dart';
import 'package:movirent/auth/domain/dto/profile.dto.dart';
import 'package:movirent/auth/domain/dto/sign_up.dto.dart';
import 'package:movirent/auth/domain/service/profile.service.dart';
import 'package:movirent/auth/presentation/providers/profile_provider.dart';
import 'package:movirent/shared/presentation/widgets/app_button.dart';
import 'package:movirent/shared/presentation/widgets/app_text_field.dart';
import 'package:provider/provider.dart';
import '../../../ui/styles/ui_styles.dart';
import '../widgets/custom_alert.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController dniController;
  late TextEditingController ageController;
  late TextEditingController phoneController;
  late TextEditingController streetController;
  late TextEditingController neighborhoodController;
  late TextEditingController cityController;
  late TextEditingController districtController;

  final profileService = ProfileService();

  @override
  void initState() {
    super.initState();
    final profile = context.read<ProfileProvider>().profile;

    firstNameController = TextEditingController(text: profile.firstName);
    lastNameController = TextEditingController(text: profile.lastName);
    dniController = TextEditingController(text: profile.dni);
    ageController = TextEditingController(text: profile.age?.toString());
    phoneController = TextEditingController(text: profile.phone);
    streetController = TextEditingController(text: profile.street);
    neighborhoodController = TextEditingController(text: profile.neighborhood);
    cityController = TextEditingController(text: profile.city);
    districtController = TextEditingController(text: profile.district);
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    dniController.dispose();
    ageController.dispose();
    phoneController.dispose();
    streetController.dispose();
    neighborhoodController.dispose();
    cityController.dispose();
    districtController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Editar Perfil"),
        backgroundColor: primary,
        foregroundColor: secondary,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: AppTextField(
                controller: firstNameController,
                label: "Nombre",
                labelColor: secondary,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: AppTextField(
                controller: lastNameController,
                label: "Apellido",
                labelColor: secondary,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: AppTextField(
                controller: dniController,
                label: "DNI",
                labelColor: secondary,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: AppTextField(
                controller: ageController,
                label: "Edad",
                labelColor: secondary,
                keyboardType: TextInputType.number,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: AppTextField(
                controller: phoneController,
                label: "Teléfono",
                labelColor: secondary,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: AppTextField(
                controller: streetController,
                label: "Calle",
                labelColor: secondary,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: AppTextField(
                controller: neighborhoodController,
                label: "Barrio",
                labelColor: secondary,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: AppTextField(
                controller: cityController,
                label: "Ciudad",
                labelColor: secondary,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: AppTextField(
                controller: districtController,
                label: "Distrito",
                labelColor: secondary,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: AppButton(
                backgroundButton: primary,
                onPressed: () async {
                  final request = SignUpDTO(
                    firstName: firstNameController.text,
                    lastName: lastNameController.text,
                    email: context.read<ProfileProvider>().profile.email, // No se modifica
                    dni: dniController.text,
                    age: int.tryParse(ageController.text),
                    phone: phoneController.text,
                    street: streetController.text,
                    neighborhood: neighborhoodController.text,
                    city: cityController.text,
                    district: districtController.text,
                  );

                  //print("Profile ID: ${context.read<ProfileProvider>().profile.id}");
                  //print("Request Data: ${request.toJson()}");
                  try {
                    await profileService.put(context.read<ProfileProvider>().profile.id!, request);
                    // convertir SignUpDTO a ProfileDTO para hacer el update en el provider
                    final updatedProfile = ProfileDTO(
                      id: context.read<ProfileProvider>().profile.id,
                      firstName: request.firstName,
                      lastName: request.lastName,
                      email: request.email,
                      dni: request.dni,
                      age: request.age,
                      phone: request.phone,
                      street: request.street,
                      neighborhood: request.neighborhood,
                      city: request.city,
                      district: request.district,
                    );
                    context.read<ProfileProvider>().setProfile(updatedProfile);
                    await showDialog(
                        context: context,
                        builder: (context){
                          return CustomAlert(
                              title: "Datos de perfil editados",
                              content: "Se actualizaron correctamente los datos del perfil",
                              isSuccess: true,
                              onPressed: (){
                                Navigator.pop(context);
                              }
                          );
                        }
                    );
                  } catch (e) {
                    await showDialog(
                        context: context,
                        builder: (context){
                          return CustomAlert(
                              title: "Ocurrió un error",
                              content: "Ocurrión un error al actualizar los datos de su perfil, por favor intentelo más tarde",
                              isSuccess: false,
                              onPressed: (){
                                Navigator.pop(context);
                              }
                          );
                        }
                    );
                  }
                },
                label: "Guardar",
              ),
            ),
          ],
        ),
      ),
    );
  }
}