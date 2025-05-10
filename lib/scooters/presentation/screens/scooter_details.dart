import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:movirent/auth/domain/service/profile.service.dart';
import 'package:movirent/auth/presentation/providers/profile_provider.dart';
import 'package:movirent/booking/domain/dto/booking_request.dto.dart';
import 'package:movirent/booking/domain/service/booking.service.dart';
import 'package:movirent/scooters/domain/dto/scooter_request.dto.dart';
import 'package:movirent/scooters/domain/dto/scooter_response.dto.dart';
import 'package:movirent/scooters/domain/service/scooter.service.dart';
import 'package:movirent/reviews/presentation/screens/scooter_reviews_screen.dart';
import 'package:movirent/shared/infrastructre/service/imgur.service.dart';
import 'package:movirent/shared/presentation/widgets/app_button.dart';
import 'package:movirent/shared/presentation/widgets/app_text_field.dart';
import 'package:provider/provider.dart';
import '../../../reviews/presentation/screens/scooter_reports_screen.dart';
import '../../../shared/presentation/screens/home_screen.dart';
import '../../../shared/presentation/widgets/custom_alert.dart';
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
  final bookingService = BookingService();
  XFile? _selectedImage;
  String currentImage = "";

  XFile? _selectedBaucher;
  String currentBaucher = "";


  Future<void> _pickBaucher() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        _selectedBaucher = picked;
      });
      final url = await imgUrService.uploadStaticImageToImgUr(_selectedBaucher!);
      setState(() {
        currentBaucher = url;
      });
    }
  }

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
    final profileProvider = context.watch<ProfileProvider>();
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
              child: Row(
                children: [
                  Text(
                    "Ver reportes",
                    style: TextStyle(
                        fontSize: textMid,
                        color: danger,
                        fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ScooterReportsScreen(
                            scooterId: widget.scooterResponseDTO.id!,
                          ),
                        ),
                      );
                    },
                    icon: Icon(Icons.arrow_forward_ios_sharp, color: danger),
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
                      bankAccount: widget.scooterResponseDTO.bankAccount
                    );
                    try {
                      await scooterService.put(widget.scooterResponseDTO.id!, request);
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
                  await showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        backgroundColor: primary,
                        title: const Text("Completar reserva"),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Para completar la reserva por favor suba su baucher de compra, la cuenta del usuario es la siguiente: ${widget.scooterResponseDTO.bankAccount}",
                              style: TextStyle(
                                  color: background,
                                  fontSize: textMid,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                            const SizedBox(height: 16),
                            const Text(
                              "La empresa no se hace responsable de las transacciones realizadas entre los usuarios.",
                              style: TextStyle(
                                fontSize: 12,
                                color: secondary,
                              ),
                            ),
                            const SizedBox(height: 20),
                            Image.network(currentBaucher.isNotEmpty ? currentBaucher
                                : "https://img.freepik.com/premium-vector/default-image-icon-vector-missing-picture-page-for-website-design-or-mobile-app-no-photo-available_87543-11093.jpg"),
                            const SizedBox(height: 20),
                            AppButton(
                                backgroundButton:warn,
                                onPressed: () async {
                                   await _pickBaucher();
                                },
                                label: "Subir Baucher"
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                AppButton(
                                  onPressed: () => Navigator.of(context).pop(true),
                                  backgroundButton: danger,
                                  label: 'Cancelar',
                                ),
                                const SizedBox(width: 8),
                                AppButton(
                                  onPressed: ()async{
                                    BookingRequestDTO data = BookingRequestDTO(
                                        profileId: profileProvider.profile.id,
                                        scooterId: widget.scooterResponseDTO.id,
                                        baucher: currentBaucher
                                    );
                                    try{
                                      await bookingService.post(data);
                                      await showDialog(
                                          context: context,
                                          builder: (context){
                                            return CustomAlert(
                                              title: 'Reserva completada',
                                              content: 'El baucher de compra sera enviado al dueño del scooter para completar la reserva.',
                                              isSuccess: true,
                                              onPressed: () {
                                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => HomeScreen()));
                                              },
                                            );
                                          }
                                      );
                                    } catch (e){
                                      await showDialog(
                                          context: context,
                                          builder: (context){
                                            return  CustomAlert(
                                              title: 'Ocurrio un error al completar la reserva',
                                              content: 'Ocurrio un error al completar la reserva, por favor intentelo mas tarde.',
                                              isSuccess: false,
                                              onPressed: () {
                                                Navigator.of(context).pop(true);
                                              },
                                            );
                                          }
                                      );
                                    }
                                  },
                                  backgroundButton: warn,
                                  label: 'Confirmar',
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
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
