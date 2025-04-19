import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movirent/scooters/domain/service/scooter.service.dart';
import 'package:movirent/scooters/presentation/widgets/scooter_card.dart';

import '../../../ui/styles/ui_styles.dart';
import '../../domain/dto/scooter_response.dto.dart';

class ScootersFoundScreen extends StatelessWidget {
  final String? district;
  final String? address;
  const ScootersFoundScreen({super.key, this.address, this.district});

  @override
  Widget build(BuildContext context) {
    final scooterService = ScooterService();
    return Scaffold(
      appBar: AppBar(
        title: Text("Scooters disponibles")
      ),
      body: FutureBuilder<dynamic>(
          future:
          district!.isNotEmpty ?
          scooterService.getScootersDistrict(district!) :
          scooterService.getScooterByAddress(address!),
          builder: (BuildContext context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator(color: primary);
            }
            if (!snapshot.hasData || snapshot.data == null) {
              return Center(
                child: Text(
                  "No existen scooters disponibles",
                  style: TextStyle(
                      color: secondary,
                      fontSize: textMid
                  ),
                  textAlign: TextAlign.center,
                ),
              );
            }
            if (snapshot.hasError) {
              return Center(
                child: Text(
                  "Ocurrió un error al buscar los scooters",
                  style: TextStyle(
                      color: danger,
                      fontSize: textMid
                  ),
                  textAlign: TextAlign.center,
                ),
              );
            }
            if (snapshot.hasData) {
              district!.isNotEmpty ? ListView.builder(
                  itemCount: (snapshot.data as List<ScooterResponseDTO>).length,
                  itemBuilder: (BuildContext context, int index) {
                    return ScooterCard(
                        isPromotion: false,
                        scooter: snapshot.data[index]
                    );
                  }
              ) : ScooterCard(
                  isPromotion: false,
                  scooter: snapshot.data
              );
            }
            return Center(
              child: Text(
                "Error desconocido",
                style: TextStyle(color: danger),
              ),
            );
          }
      ),
    );
  }
}
