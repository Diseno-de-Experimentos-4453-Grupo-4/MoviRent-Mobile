import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:movirent/auth/presentation/providers/profile_provider.dart';
import 'package:movirent/scooters/domain/dto/scooter_request.dto.dart';
import 'package:movirent/scooters/domain/service/scooter.service.dart';
import 'package:movirent/shared/infrastructre/service/imgur.service.dart';
import 'package:movirent/shared/presentation/screens/home_screen.dart';
import 'package:movirent/shared/presentation/widgets/app_button.dart';
import 'package:movirent/shared/presentation/widgets/app_text_field.dart';
import 'package:movirent/shared/presentation/widgets/custom_alert.dart';
import 'package:movirent/ui/styles/ui_styles.dart';
import 'package:provider/provider.dart';

class PublishScooter extends StatefulWidget {
  const PublishScooter({super.key});

  @override
  State<PublishScooter> createState() => _PublishScooterState();
}

class _PublishScooterState extends State<PublishScooter> {
  final imgUrService = ImgUrService();
  String currentImage = "";
  XFile? _selectedImage;

  final TextEditingController brandController = TextEditingController();
  final TextEditingController modelController = TextEditingController();
  final TextEditingController streetController = TextEditingController();
  final TextEditingController colonyController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController districtController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController bankAccountController = TextEditingController();

  Future<void> _pickImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        _selectedImage = picked;
      });

      final url = await imgUrService.uploadStaticImageToImgUr(_selectedImage!);
      print(url);
      setState(() {
        currentImage = url;
      });
    }
  }

  @override
  void dispose() {
    brandController.dispose();
    modelController.dispose();
    streetController.dispose();
    colonyController.dispose();
    cityController.dispose();
    districtController.dispose();
    priceController.dispose();
    bankAccountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scooterService = ScooterService();
    final profileProvider = context.watch<ProfileProvider>();

    return Scaffold(
      appBar: AppBar(
        foregroundColor: secondary,
        title: Text("Publica tu scooter"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Image.network(
                  width: double.infinity,
                  height: 220,
                  fit: BoxFit.cover,
                  currentImage.isEmpty
                      ? "https://tse4.mm.bing.net/th?id=OIP.vEEsolKY6Rv5ZV5wOz9OzQHaFE&pid=Api&P=0&h=180"
                      : currentImage,
                ),
                Positioned(
                  top: 160,
                  right: 10,
                  child: Container(
                    decoration: BoxDecoration(
                      color: primary,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: IconButton(
                      color: background,
                      onPressed: () async {
                        await _pickImage();
                      },
                      icon: Icon(Icons.image),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  AppTextField(
                    labelColor: secondary,
                    label: "Marca",
                    controller: brandController,
                  ),
                  SizedBox(height: 12),
                  AppTextField(
                    labelColor: secondary,
                    label: "Modelo",
                    controller: modelController,
                  ),
                  SizedBox(height: 12),
                  AppTextField(
                    labelColor: secondary,
                    label: "Calle",
                    controller: streetController,
                  ),
                  SizedBox(height: 12),
                  AppTextField(
                    labelColor: secondary,
                    label: "Colonia",
                    controller: colonyController,
                  ),
                  SizedBox(height: 12),
                  AppTextField(
                    labelColor: secondary,
                    label: "Ciudad",
                    controller: cityController,
                  ),
                  SizedBox(height: 12),
                  AppTextField(
                    labelColor: secondary,
                    label: "Distrito",
                    controller: districtController,
                  ),
                  SizedBox(height: 12),
                  AppTextField(
                    labelColor: secondary,
                    label: "Precio",
                    keyboardType: TextInputType.number,
                    controller: priceController,
                  ),
                  SizedBox(height: 12),
                  AppTextField(
                    labelColor: secondary,
                    label: "Cuenta bancaria",
                    keyboardType: TextInputType.text,
                    controller: bankAccountController,
                  ),
                  SizedBox(height: 12),
                  AppButton(
                    backgroundButton: primary,
                    onPressed: () async {
                      final request = ScooterRequestDTO(
                        profileId: profileProvider.profile.id,
                        brand: brandController.text,
                        model: modelController.text,
                        street: streetController.text,
                        neighborhood: colonyController.text,
                        city: cityController.text,
                        district: districtController.text,
                        price: double.tryParse(priceController.text) ?? 0,
                        image: currentImage,
                        bankAccount: bankAccountController.text
                      );
                      try{
                        await scooterService.post(request);
                        await showDialog(
                            context: context,
                            builder: (context){
                              return CustomAlert(
                                  title: "Publicación exitosa",
                                  content: "Tu scooter ha sido publicado con éxito!",
                                  isSuccess: true,
                                  onPressed: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (_) => HomeScreen()));
                                  }, height: 200,
                              );
                            }
                        );
                      } catch (e){
                        await showDialog(
                            context: context,
                            builder: (context){
                              return CustomAlert(
                                  title: "Error al publicar el scooter",
                                  content: "Ocurrió un error al publicar el scooter, por favor asegurese de llenar todos los campos",
                                  isSuccess: false,
                                  onPressed: (){
                                    Navigator.pop(context);
                                  }, height: 200,
                              );
                            }
                        );
                      }
                    },
                    label: "Publicar",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
