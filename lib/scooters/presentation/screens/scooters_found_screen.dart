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
    Future<List<ScooterResponseDTO>>? future;
    if (district != null && district!.isNotEmpty) {
      future = scooterService.getScootersDistrict(district!);
    } else if (address != null && address!.isNotEmpty) {
      future = scooterService.getScooterByAddress(address!);
    } else {
      future = Future.value([]);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Scooters disponibles")
      ),
      body: FutureBuilder<List<ScooterResponseDTO>>(
          future:future,
          builder: (BuildContext context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator(color: primary);
            }
            if (!snapshot.hasData) {
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
                  "Ocurrió un error al buscar los scooters  ",
                  style: TextStyle(
                      color: danger,
                      fontSize: textMid
                  ),
                  textAlign: TextAlign.center,
                ),
              );
            }
            final scooters = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: ListView.builder(
                itemCount: scooters.length,
                itemBuilder: (BuildContext context, int index) {
                  return ScooterCard(
                    isPromotion: false,
                    scooter: scooters[index],
                  );
                },
              ),
            );

          }
      ),
    );
  }
}
