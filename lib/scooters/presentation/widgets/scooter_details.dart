import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movirent/auth/domain/dto/profile.dto.dart';
import 'package:movirent/auth/domain/service/profile.service.dart';
import 'package:movirent/auth/presentation/providers/profile_provider.dart';
import 'package:movirent/scooters/domain/dto/scooter_response.dto.dart';
import 'package:movirent/shared/presentation/widgets/app_button.dart';
import 'package:provider/provider.dart';

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
  @override
  void initState(){
    super.initState();
    () async{
      final profileProvider = Provider.of<ProfileProvider>(context, listen: false);
      if (widget.scooterResponseDTO.profileId == profileProvider.profile.id){
        setState(() {
          userPublished = "Usted";
          isOwn = true;
        });
      }
      else{
        final profileService = ProfileService();
        final response = await profileService.getById(widget.scooterResponseDTO.profileId!);
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
            Image.network(
                widget.scooterResponseDTO.image!,
              width: double.infinity,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                  "Detalle de la marca: ${widget.scooterResponseDTO.brand} ",
                style: TextStyle(
                  fontSize: textMid
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Detalle del modelo: ${widget.scooterResponseDTO.model} ",
                style: TextStyle(
                    fontSize: textMid
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Dirección: ${widget.scooterResponseDTO.address} ",
                style: TextStyle(
                    fontSize: textMid
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Publicado por: $userPublished ",
                style: TextStyle(
                    fontSize: textMid
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Precio: S/. ${widget.scooterResponseDTO.price} ",
                style: TextStyle(
                    fontSize: textMid
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
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  IconButton(
                      onPressed: (){

                      },
                      icon: Icon(
                        Icons.arrow_forward_ios_sharp,
                        color: primary,
                        fill: 1,
                      )
                  )
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
                      color: danger
                    ),
                  ),
                  IconButton(
                      onPressed: (){

                      },
                      icon: Icon(
                          Icons.arrow_forward_ios_sharp,
                        color: danger,
                      )
                  )
                ],
              ),
            ),
            if(!isOwn) Padding(
              padding: const EdgeInsets.all(8.0),
              child: AppButton(
                  backgroundButton: danger,
                  onPressed: (){

                  },
                  label: "Alquilar"
              ),
            )

          ],
        ),
      ),
    );
  }
}
