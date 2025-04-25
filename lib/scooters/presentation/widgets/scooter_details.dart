import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:movirent/auth/domain/service/profile.service.dart';
import 'package:movirent/auth/presentation/providers/profile_provider.dart';
import 'package:movirent/checkout/presentation/screens/checkout_payment_screen.dart';
import 'package:movirent/scooters/domain/dto/scooter_request.dto.dart';
import 'package:movirent/scooters/domain/dto/scooter_response.dto.dart';
import 'package:movirent/scooters/domain/service/scooter.service.dart';
import 'package:movirent/reviews/presentation/screens/add_review_screen.dart';
import 'package:movirent/reviews/presentation/screens/scooter_reviews_screen.dart';
import 'package:movirent/shared/infrastructre/service/imgur.service.dart';
import 'package:movirent/shared/presentation/widgets/app_button.dart';
import 'package:movirent/shared/presentation/widgets/app_text_field.dart';
import 'package:provider/provider.dart';
import '../../../reviews/presentation/screens/scooter_reports_screen.dart';
import '../../../ui/styles/ui_styles.dart';

class ScooterDetails extends StatefulWidget {
  final ScooterResponseDTO scooterResponseDTO;
  const ScooterDetails({super.key, required this.scooterResponseDTO});

  @override
  State<ScooterDetails> createState() => _ScooterDetailsState();
}

class _ScooterDetailsState extends State<ScooterDetails> {
  String userPublished = " ";
  bool isOwn = false;
  bool editMode = false;
  late TextEditingController brandController;
  late TextEditingController modelController;
  late TextEditingController addressController;
  late TextEditingController priceController;

  final imgUrService = ImgUrService();
  final scooterService = ScooterService();
  XFile? _selectedImage;
  String currentImage = "";

  Future<void> _pickImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        _selectedImage = picked;
      });

      final url = await imgUrService.uploadStaticImageToImgUr(_selectedImage!);
      setState(() {
        currentImage = url;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    final scooter = widget.scooterResponseDTO;
    brandController = TextEditingController(text: scooter.brand);
    modelController = TextEditingController(text: scooter.model);
    addressController = TextEditingController(text: scooter.address);
    priceController = TextEditingController(text: scooter.price.toString());
    currentImage = scooter.image ?? "";

    () async {
      final profileProvider = Provider.of<ProfileProvider>(context, listen: false);
      if (scooter.profileId == profileProvider.profile.id) {
        setState(() {
          userPublished = "Usted";
          isOwn = true;
        });
      } else {
        final profileService = ProfileService();
        final response = await profileService.getById(scooter.profileId!);
        setState(() {
          userPublished = "${response.firstName} ${response.lastName}";
        });
      }
    }();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: secondary,
        title: Text("Detalles del scooter"),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Image.network(
                  currentImage,
                  width: double.infinity,
                  height: 220,
                  fit: BoxFit.cover,
                ),
                if (editMode)
                  Positioned(
                    top: 170,
                    right: 10,
                    child: Container(
                      decoration: BoxDecoration(
                        color: primary,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: IconButton(
                        icon: Icon(Icons.image, color: background),
                        onPressed: _pickImage,
                      ),
                    ),
                  ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: editMode
                  ? AppTextField(
                controller: brandController,
                labelColor: secondary,
              )
                  : Text(
                "Detalle de la marca: ${widget.scooterResponseDTO.brand}",
                style: TextStyle(fontSize: textMid),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: editMode
                  ? AppTextField(
                controller: modelController,
                labelColor: secondary,
              )
                  : Text(
                "Detalle del modelo: ${widget.scooterResponseDTO.model}",
                style: TextStyle(fontSize: textMid),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: editMode
                  ? AppTextField(
                controller: addressController,
                labelColor: secondary,
              )
                  : Text(
                "Dirección: ${widget.scooterResponseDTO.address}",
                style: TextStyle(fontSize: textMid),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Publicado por: $userPublished",
                style: TextStyle(fontSize: textMid),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: editMode
                  ? AppTextField(
                controller: priceController,
                labelColor: secondary,
              )
                  : Text(
                "Precio: S/. ${widget.scooterResponseDTO.price}",
                style: TextStyle(fontSize: textMid),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Estado: ${widget.scooterResponseDTO.isAvailable! ? "Disponible" : "Reservado"}",
                style: TextStyle(
                    fontSize: textMid,
                  color: widget.scooterResponseDTO.isAvailable! ?Colors.green : danger
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text(
                    "Ver reseñas",
                    style: TextStyle(
                        fontSize: textMid,
                        color: primary,
                        fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ScooterReviewsScreen(
                            scooterId: widget.scooterResponseDTO.id!,
                          ),
                        ),
                      );
                    },
                    icon: Icon(Icons.arrow_forward_ios_sharp, color: primary),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: isOwn
                  ? AppButton(
                backgroundButton: primary,
                onPressed: () async {
                  if (editMode) {
                    final request = ScooterRequestDTO(
                      brand: brandController.text,
                      model: modelController.text,
                      profileId: widget.scooterResponseDTO.profileId,
                      price: double.tryParse(priceController.text),
                      image: currentImage,
                      street: addressController.text.split(",")[0],
                      neighborhood: addressController.text.split(",")[1],
                      city: addressController.text.split(",")[2],
                      district: addressController.text.split(",")[3],
                    );
                    try {
                      final response = await scooterService.put(widget.scooterResponseDTO.id!, request);
                      setState(() {
                        editMode = !editMode;
                      });
                    } catch (e) {
                      throw Exception("An error has occurred while trying to update scooter $e");
                    }
                  } else {
                    setState(() {
                      editMode = !editMode;
                    });
                  }
                },
                label: editMode ? "Guardar" : "Editar",
              )
                  : !widget.scooterResponseDTO.isAvailable!
                  ? AppButton(
                backgroundButton: Colors.grey,
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Este scooter no está disponible actualmente")),
                  );
                },
                label: "No disponible",
              )
                  : AppButton(
                backgroundButton: danger,
                onPressed: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => CheckoutPaymentScreen(
                        title: "Final el pago de alquiler",
                        userId: widget.scooterResponseDTO.profileId!,
                        description: "Completa el pago de alquiler de tu scooter",
                        isSubscription: false,
                        scooterId: widget.scooterResponseDTO.id,
                        price: widget.scooterResponseDTO.price,
                      ),
                    ),
                  );
                },
                label: "Alquilar",
              ),
            )
          ],
        ),
      ),
    );
  }
}
