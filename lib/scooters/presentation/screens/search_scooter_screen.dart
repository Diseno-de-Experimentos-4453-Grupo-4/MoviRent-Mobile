import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movirent/scooters/presentation/screens/search_scooter_district_screen.dart';
import 'package:movirent/ui/styles/ui_styles.dart';

class SearchScooterScreen extends StatelessWidget {
  const SearchScooterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        backgroundColor: background,
      ),
      body: Column(
        children: [
          const SizedBox(height: 100),
          Center(
            child: Text(
                "Que tipo de búsqueda deseas realizar?",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: textMid * 1.2,

              ),
            ),
          ),
          const SizedBox(height: 100),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (_) => SearchScooterDistrictScreen()));
                },
                child: SizedBox(
                  width: 100,
                  height: 40,
                  child: Card(
                    color: primary,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Text(
                        "Distrito",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: background,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                child: SizedBox(
                  width: 100,
                  height: 40,
                  child: Card(
                    color: primary,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Text(
                          "Dirección",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: background,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
