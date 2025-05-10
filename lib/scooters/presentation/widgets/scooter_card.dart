import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movirent/scooters/domain/dto/scooter_response.dto.dart';
import 'package:movirent/scooters/presentation/screens/search_scooter_screen.dart';
import 'package:movirent/scooters/presentation/screens/scooter_details.dart';
import 'package:movirent/shared/presentation/screens/home_screen.dart';
import 'package:movirent/ui/styles/ui_styles.dart';

class ScooterCard extends StatelessWidget {
  final bool isPromotion;
  final ScooterResponseDTO scooter;
  const ScooterCard({
    super.key,
    this.isPromotion = true,
    required this.scooter
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: GestureDetector(
        onTap: (){
          !isPromotion ? Navigator.push(context, MaterialPageRoute(builder: (_) => ScooterDetails(scooterResponseDTO: scooter))) :  Navigator.push(context, MaterialPageRoute(builder: (_) => SearchScooterScreen()));
        },
        child: Card(
          elevation: 10.0,
          color: background,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                  scooter.image!,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(scooter.model!),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                    " S/. ${scooter.price}",
                  style: TextStyle(
                    fontSize: textMid,
                    color: secondary,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(scooter.brand!),
              )
            ],
          ),
        ),
      ),
    );
  }
}
